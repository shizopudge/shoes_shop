import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/core/utils.dart';
import 'package:shoes_app_ui_training/models/cart_model.dart';
import 'package:shoes_app_ui_training/models/shoe_model.dart';
import 'package:shoes_app_ui_training/screens/cart_shoes.dart';
import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/utils/styles.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void buyShoeFromCart(BuildContext context, Cart cart, Shoe shoe) async {
    ref
        .read(shoeControllerProvider.notifier)
        .buyShoeFromCart(context: context, cart: cart, shoe: shoe);
  }

  bool isOrdered = false;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    var sum = 0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shoes',
                        style: textstyle1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cart',
                        style: textstyle1.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  isGuest
                      ? const SizedBox()
                      : ref.watch(getShoesInCartProvider(user.uid)).when(
                            data: ((data) {
                              for (var i = 0; i < data.length; i++) {
                                final cart = data[i];
                                sum = sum + cart.cost;
                              }
                              return InkWell(
                                onTap: sum == 0
                                    ? () {
                                        showSnackBar(
                                            context, 'You cart is empty.');
                                      }
                                    : () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: ((context) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      //
                                                      Routemaster.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        color: Colors
                                                            .green.shade300,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Pay \$ $sum',
                                                          style:
                                                              textstylecollection
                                                                  .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Routemaster.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18),
                                                        color:
                                                            Colors.red.shade300,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Go back',
                                                          style:
                                                              textstylecollection
                                                                  .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.black87,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Pay for all',
                                        style: textstylecollection.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '\$ ',
                                              style:
                                                  textstylecollection.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.green.shade300,
                                              ),
                                            ),
                                            Text(
                                              '$sum',
                                              style:
                                                  textstylecollection.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            error: ((error, stackTrace) => ErrorText(
                                  error: error.toString(),
                                )),
                            loading: (() => const Loader()),
                          ),
                  Row(
                    children: [
                      Text(
                        'Sort by cost',
                        style: textstylecollection.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: isOrdered ? 3 : 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isOrdered = !isOrdered;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isGuest
                  ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Login',
                              style: textstyle1.copyWith(
                                color: Colors.green,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => logOut(ref),
                            child: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://blog.hubspot.com/hubfs/image8-2.jpg'),
                              radius: 28,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: CartShoes(
                        isOrdered: isOrdered,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
