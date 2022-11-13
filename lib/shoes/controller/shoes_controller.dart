import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/core/utils.dart';
import 'package:shoes_app_ui_training/models/cart_model.dart';
import 'package:shoes_app_ui_training/models/shoe_model.dart';
import 'package:shoes_app_ui_training/shoes/repository/shoes_repository.dart';
import 'package:uuid/uuid.dart';

final shoeControllerProvider =
    StateNotifierProvider<ShoesController, bool>((ref) {
  final shoesRepository = ref.watch(shoesRepositoryProvider);
  return ShoesController(
    shoesRepository: shoesRepository,
    ref: ref,
  );
});

final getShoesProvider = StreamProvider((ref) {
  return ref.watch(shoeControllerProvider.notifier).getShoes();
});

final getShoesCostDecendingProvider = StreamProvider((ref) {
  return ref.watch(shoeControllerProvider.notifier).getShoesCostDecending();
});

final getShoesInCartProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(shoeControllerProvider.notifier).getShoesInCart(uid);
});

final getShoesInPurchasesProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(shoeControllerProvider.notifier).getShoesInPurchases(uid);
});

final getShoesInPurchasesCostDescendingProvider =
    StreamProvider.family((ref, String uid) {
  return ref
      .watch(shoeControllerProvider.notifier)
      .getShoesInPurchasesCostDescending(uid);
});

final getShoesByBrandProvider = StreamProvider.family((ref, String brand) {
  return ref.watch(shoeControllerProvider.notifier).getShoesByBrand(brand);
});

final getShoesByBrandCostDecendingProvider =
    StreamProvider.family((ref, String brand) {
  return ref
      .watch(shoeControllerProvider.notifier)
      .getShoesByBrandCostDecending(brand);
});

final getShoesInCartCostDescendingProvider =
    StreamProvider.family((ref, String uid) {
  return ref
      .watch(shoeControllerProvider.notifier)
      .getShoesInCartCostDescending(uid);
});

final searchShoeProvider = StreamProvider.family((ref, String query) {
  return ref.watch(shoeControllerProvider.notifier).searchShoe(query);
});

final getLikedShoesProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(shoeControllerProvider.notifier).getLikedShoes(uid);
});

final getLikedShoesCostDecendingProvider =
    StreamProvider.family((ref, String uid) {
  return ref
      .watch(shoeControllerProvider.notifier)
      .getLikedShoesCostDecending(uid);
});

final getShoeByIdProvider = StreamProvider.family((ref, String title) {
  return ref.watch(shoeControllerProvider.notifier).getShoeById(title);
});

class ShoesController extends StateNotifier<bool> {
  final ShoesRepository _shoesRepository;
  final Ref _ref;
  ShoesController({
    required ShoesRepository shoesRepository,
    required Ref ref,
  })  : _shoesRepository = shoesRepository,
        _ref = ref,
        super(false);

  Stream<List<Shoe>> getShoes() {
    return _shoesRepository.getShoes();
  }

  Stream<List<Shoe>> getShoesCostDecending() {
    return _shoesRepository.getShoesCostDecending();
  }

  Stream<List<Cart>> getShoesInCart(String uid) {
    return _shoesRepository.getShoesInCart(uid);
  }

  Stream<List<Cart>> getShoesInPurchases(String uid) {
    return _shoesRepository.getShoesInPurchases(uid);
  }

  Stream<List<Shoe>> getShoesByBrand(String brand) {
    return _shoesRepository.getShoesByBrand(brand);
  }

  Stream<List<Cart>> getShoesInPurchasesCostDescending(String uid) {
    return _shoesRepository.getShoesInPurchasesCostDescending(uid);
  }

  Stream<List<Shoe>> getShoesByBrandCostDecending(String brand) {
    return _shoesRepository.getShoesByBrandCostDecending(brand);
  }

  Stream<List<Cart>> getShoesInCartCostDescending(String uid) {
    return _shoesRepository.getShoesInCartCostDescending(uid);
  }

  Stream<List<Shoe>> getLikedShoesCostDecending(String uid) {
    return _shoesRepository.getLikedShoesCostDecending(uid);
  }

  Stream<List<Shoe>> getLikedShoes(String uid) {
    return _shoesRepository.getLikedShoes(uid);
  }

  Stream<Shoe> getShoeById(String title) {
    return _shoesRepository.getShoeById(title);
  }

  void like(Shoe shoe) async {
    final uid = _ref.read(userProvider)!.uid;
    _shoesRepository.like(shoe, uid);
  }

  void addToCart({
    required BuildContext context,
    required String size,
    required Shoe shoe,
  }) async {
    final user = _ref.read(userProvider)!;
    String cartId = const Uuid().v1();
    Cart cart = Cart(
        id: cartId,
        uid: user.uid,
        shoeId: shoe.id,
        shoeTitle: shoe.title,
        shoeImage: shoe.image,
        size: size,
        shoeBrand: shoe.brand,
        cost: shoe.cost);
    final res = await _shoesRepository.addToCart(context, cart, user, shoe);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void removeFromCart({
    required BuildContext context,
    required Cart cart,
  }) async {
    final user = _ref.read(userProvider)!;
    final res = await _shoesRepository.removeFromCart(context, cart, user);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void cancelPurchase({
    required BuildContext context,
    required Cart cart,
    required Shoe shoe,
  }) async {
    final user = _ref.read(userProvider)!;
    final res =
        await _shoesRepository.cancelPurchase(context, cart, user, shoe);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  void buyShoeFromCart({
    required BuildContext context,
    required Cart cart,
    required Shoe shoe,
  }) async {
    final user = _ref.read(userProvider)!;
    final res =
        await _shoesRepository.buyShoeFromCart(context, cart, user, shoe);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  Stream<List<Shoe>> searchShoe(String query) {
    return _shoesRepository.searchShoe(query);
  }
}
