import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shoes_app_ui_training/constants/firebase_constants.dart';
import 'package:shoes_app_ui_training/core/failure.dart';
import 'package:shoes_app_ui_training/core/type_defs.dart';
import 'package:shoes_app_ui_training/core/utils.dart';

import 'package:shoes_app_ui_training/models/cart_model.dart';
import 'package:shoes_app_ui_training/models/shoe_model.dart';
import 'package:shoes_app_ui_training/models/user_model.dart';

import 'package:shoes_app_ui_training/providers/firebase_providers.dart';

final shoesRepositoryProvider = Provider((ref) {
  return ShoesRepository(firestore: ref.watch(firestoreProvider));
});

class ShoesRepository {
  final FirebaseFirestore _firestore;
  ShoesRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _shoes =>
      _firestore.collection(FirebaseConstants.shoesCollection);
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);
  CollectionReference get _carts =>
      _firestore.collection(FirebaseConstants.cartsCollection);

  Stream<List<Shoe>> getShoes() {
    return _shoes
        .orderBy(
          'cost',
          descending: false,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Shoe.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Shoe>> getShoesCostDecending() {
    return _shoes
        .orderBy(
          'cost',
          descending: true,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Shoe.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Shoe>> getShoesByBrand(String brand) {
    return _shoes
        .where('brand', isEqualTo: brand)
        .orderBy(
          'cost',
          descending: false,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Shoe.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Shoe>> getShoesByBrandCostDecending(String brand) {
    return _shoes
        .where('brand', isEqualTo: brand)
        .orderBy(
          'cost',
          descending: true,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Shoe.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Shoe>> getLikedShoesCostDecending(String uid) {
    return _shoes
        .where('likes', arrayContains: uid)
        .orderBy(
          'cost',
          descending: true,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Shoe.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Shoe>> getLikedShoes(String uid) {
    return _shoes
        .where('likes', arrayContains: uid)
        .orderBy(
          'cost',
          descending: false,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Shoe.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<Shoe> getShoeById(String title) {
    return _shoes
        .doc(title)
        .snapshots()
        .map((event) => Shoe.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<List<Cart>> getShoesInCart(String uid) {
    return _users
        .doc(uid)
        .collection('cart')
        .orderBy(
          'cost',
          descending: false,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Cart.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Cart>> getShoesInCartCostDescending(String uid) {
    return _users
        .doc(uid)
        .collection('cart')
        .orderBy(
          'cost',
          descending: true,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Cart.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Cart>> getShoesInPurchases(String uid) {
    return _users.doc(uid).collection('purchases').snapshots().map(
          (event) => event.docs
              .map(
                (e) => Cart.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Cart>> getShoesInPurchasesCostDescending(String uid) {
    return _users
        .doc(uid)
        .collection('purchases')
        .orderBy(
          'cost',
          descending: true,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Cart.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  void like(Shoe shoe, String userId) async {
    if (shoe.likes.contains(userId)) {
      _shoes.doc(shoe.id).update({
        'likes': FieldValue.arrayRemove([userId]),
      });
    } else {
      _shoes.doc(shoe.id).update({
        'likes': FieldValue.arrayUnion([userId]),
      });
    }
  }

  FutureVoid addToCart(
      BuildContext context, Cart cart, UserModel user, Shoe shoe) async {
    try {
      await _users
          .doc(user.uid)
          .collection('cart')
          .doc(shoe.id)
          .set(cart.toMap());
      return right(_shoes.doc(shoe.id).update({
        'inCart': FieldValue.arrayUnion([user.uid]),
      }));
    } on FirebaseException catch (e) {
      throw (e.message!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid removeFromCart(
      BuildContext context, Cart cart, UserModel user) async {
    try {
      await _users.doc(user.uid).collection('cart').doc(cart.shoeId).delete();
      return right(_shoes.doc(cart.shoeId).update({
        'inCart': FieldValue.arrayRemove([user.uid]),
      }));
    } on FirebaseException catch (e) {
      throw (e.message!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid cancelPurchase(
      BuildContext context, Cart cart, UserModel user, Shoe shoe) async {
    try {
      await _users.doc(user.uid).collection('purchases').doc(cart.id).delete();
      return right(_shoes.doc(cart.shoeId).update({
        'count': FieldValue.increment(1),
      }));
    } on FirebaseException catch (e) {
      throw (e.message!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FutureVoid addToPurchases(
  //     BuildContext context, Cart cart, UserModel user, Shoe shoe) async {
  //   try {
  //     await _users
  //         .doc(user.uid)
  //         .collection('purchases')
  //         .doc()
  //         .set(cart.toMap());
  //     return right(_shoes.doc(shoe.id).update({
  //       'inCart': FieldValue.arrayRemove([user.uid]),
  //     }));
  //   } on FirebaseException catch (e) {
  //     throw (e.message!);
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  FutureVoid buyShoeFromCart(
      BuildContext context, Cart cart, UserModel user, Shoe shoe) async {
    try {
      await _users.doc(user.uid).collection('cart').doc(cart.shoeId).delete();
      await _users
          .doc(user.uid)
          .collection('purchases')
          .doc(cart.id)
          .set(cart.toMap());
      return right(_shoes.doc(cart.shoeId).update({
        'inCart': FieldValue.arrayRemove([user.uid]),
        'count': shoe.count - 1,
      }));
    } on FirebaseException catch (e) {
      throw (e.message!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Shoe>> searchShoe(String query) {
    return _shoes
        .where(
          'title',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<Shoe> shoes = [];
      for (var shoe in event.docs) {
        shoes.add(Shoe.fromMap(shoe.data() as Map<String, dynamic>));
      }
      return shoes;
    });
  }
}
