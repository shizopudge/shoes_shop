import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/core/utils.dart';
import 'package:shoes_app_ui_training/models/cart_model.dart';
import 'package:shoes_app_ui_training/models/shoe_model.dart';
import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/utils/styles.dart';

class ShoeCartWidget extends ConsumerStatefulWidget {
  final Cart cart;
  const ShoeCartWidget({
    super.key,
    required this.cart,
  });

  @override
  ConsumerState<ShoeCartWidget> createState() => _ShoeWidgetState();
}

class _ShoeWidgetState extends ConsumerState<ShoeCartWidget> {
  @override
  Widget build(BuildContext context) {
    // void navigateToEditCartScreen(BuildContext context) {
    //   Routemaster.of(context).push('/edit-cart-screen/${widget.cart.id}');
    // }

    void removeFromCart(BuildContext context, Cart cart) async {
      ref
          .read(shoeControllerProvider.notifier)
          .removeFromCart(context: context, cart: cart);
    }

    void buyShoeFromCart(BuildContext context, Cart cart, Shoe shoe) async {
      ref
          .read(shoeControllerProvider.notifier)
          .buyShoeFromCart(context: context, cart: cart, shoe: shoe);
    }

    final user = ref.watch(userProvider)!;

    final cart = widget.cart;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 240,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: Colors.grey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.cart.shoeImage,
                ),
                radius: 95,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.cart.shoeBrand,
                      style: textstyle2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      widget.cart.shoeTitle,
                      style: textstyle2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      '\$ ${widget.cart.cost}',
                      style: textstyle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          'Size: ',
                          style: textstyle2.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          widget.cart.size,
                          style: textstyle2.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    ref.watch(getShoeByIdProvider(widget.cart.shoeId)).when(
                          data: (shoe) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((context) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: shoe.count == 0
                                                  ? () {
                                                      Routemaster.of(context)
                                                          .pop();
                                                      showSnackBar(context,
                                                          'Sorry, looks like these shoes are out of stock.');
                                                    }
                                                  : () {
                                                      buyShoeFromCart(
                                                          context, cart, shoe);
                                                      Routemaster.of(context)
                                                          .pop();
                                                    },
                                              child: Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  color: Colors.green.shade300,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Pay \$ ${widget.cart.cost}',
                                                    style: textstylecollection
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
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Routemaster.of(context).pop();
                                              },
                                              child: Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  color: Colors.red.shade300,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Go back',
                                                    style: textstylecollection
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
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.green.shade300,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Pay',
                                      style: textstylecollection.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          error: ((error, stackTrace) => ErrorText(
                                error: error.toString(),
                              )),
                          loading: (() => const Loader()),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () => removeFromCart(context, cart),
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.red.shade300,
                          ),
                          child: Center(
                            child: Text(
                              'Remove',
                              style: textstylecollection.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
