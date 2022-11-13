import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/models/cart_model.dart';
import 'package:shoes_app_ui_training/models/shoe_model.dart';
import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/utils/styles.dart';

class PurchasedShoe extends ConsumerWidget {
  final Cart cart;
  const PurchasedShoe({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void cancelPurchase(BuildContext context, Cart cart, Shoe shoe) async {
      ref
          .read(shoeControllerProvider.notifier)
          .cancelPurchase(context: context, cart: cart, shoe: shoe);
    }

    final user = ref.watch(userProvider)!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 220,
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
                  cart.shoeImage,
                ),
                radius: 95,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      cart.shoeBrand,
                      style: textstyle2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      cart.shoeTitle,
                      style: textstyle2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      'Size: ${cart.size}',
                      style: textstyle1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          '\$ ',
                          style: textstyle1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          '${cart.cost}',
                          style: textstyle1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ref.watch(getShoeByIdProvider(cart.shoeId)).when(
                        data: (shoe) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () => cancelPurchase(context, cart, shoe),
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: Colors.red.shade300,
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
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
                        error: ((error, stackTrace) =>
                            ErrorText(error: error.toString())),
                        loading: () => const Loader()),
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
