import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/core/utils.dart';

import 'package:shoes_app_ui_training/models/shoe_model.dart';

import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/utils/styles.dart';
import 'package:shoes_app_ui_training/widgets/size_widget.dart';

class ShoeScreen extends ConsumerStatefulWidget {
  final String shoeId;
  const ShoeScreen({
    super.key,
    required this.shoeId,
  });

  @override
  ConsumerState<ShoeScreen> createState() => _ShoeScreenState();
}

class _ShoeScreenState extends ConsumerState<ShoeScreen> {
  bool isTapped1 = false;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;
  bool isTapped5 = false;
  bool isTapped6 = false;
  String size = '';

  void like(WidgetRef ref, Shoe shoe) async {
    ref.read(shoeControllerProvider.notifier).like(shoe);
  }

  void addToCart(BuildContext context, String size, Shoe shoe) {
    ref
        .read(shoeControllerProvider.notifier)
        .addToCart(context: context, size: size, shoe: shoe);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    return Scaffold(
      body: ref.watch(getShoeByIdProvider(widget.shoeId)).when(
          data: (shoe) {
            bool isLiked = shoe.likes.contains(user.uid);
            bool isInCart = shoe.inCart.contains(user.uid);
            bool isOutOfStock = shoe.count == 0;
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(36),
                        color: Colors.grey.shade300,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    size: 28,
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    IconButton(
                                      onPressed: isGuest
                                          ? () {
                                              showSnackBar(context,
                                                  'You need to be logged in to add a shoe to favorite.');
                                            }
                                          : () => like(ref, shoe),
                                      icon: isLiked
                                          ? const Icon(
                                              CupertinoIcons.heart_fill,
                                              size: 32,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              CupertinoIcons.heart,
                                              size: 32,
                                            ),
                                    ),
                                    Text(
                                      shoe.likes.length.toString(),
                                      style: textstyle2.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(shoe.image),
                                radius: 125,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 10,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: Colors.black87,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 10,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 10,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 10,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: Colors.grey,
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 10,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: shoe.brand == 'Nike'
                          ? Image.asset(
                              'assets/images/nike.png',
                              height: 30,
                            )
                          : shoe.brand == 'Adidas'
                              ? Image.asset(
                                  'assets/images/adidas.png',
                                  height: 30,
                                )
                              : shoe.brand == 'Puma'
                                  ? Image.asset(
                                      'assets/images/puma.png',
                                      height: 30,
                                    )
                                  : Image.asset(
                                      'assets/images/logo.png',
                                      height: 30,
                                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Text(
                        shoe.title,
                        style: textstyle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    shoe.count == 0
                        ? Text(
                            overflow: TextOverflow.ellipsis,
                            'Out of stock',
                            style: textstyle2.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                'In stock: ',
                                style: textstyle2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                '${shoe.count} шт.',
                                style: textstyle2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                    const Gap(5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Size',
                        style: textstyle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (() {
                              setState(() {
                                size = '5';
                                isTapped1 = true;
                                isTapped2 = false;
                                isTapped3 = false;
                                isTapped4 = false;
                                isTapped5 = false;
                                isTapped6 = false;
                              });
                            }),
                            child: SizeWidget(isTapped: isTapped1, size: '5'),
                          ),
                          InkWell(
                            onTap: (() {
                              setState(() {
                                size = '5.5';
                                isTapped1 = false;
                                isTapped2 = true;
                                isTapped3 = false;
                                isTapped4 = false;
                                isTapped5 = false;
                                isTapped6 = false;
                              });
                            }),
                            child: SizeWidget(isTapped: isTapped2, size: '5.5'),
                          ),
                          InkWell(
                            onTap: (() {
                              setState(() {
                                size = '6';
                                isTapped1 = false;
                                isTapped2 = false;
                                isTapped3 = true;
                                isTapped4 = false;
                                isTapped5 = false;
                                isTapped6 = false;
                              });
                            }),
                            child: SizeWidget(isTapped: isTapped3, size: '6'),
                          ),
                          InkWell(
                            onTap: (() {
                              setState(() {
                                size = '6.5';
                                isTapped1 = false;
                                isTapped2 = false;
                                isTapped3 = false;
                                isTapped4 = true;
                                isTapped5 = false;
                                isTapped6 = false;
                              });
                            }),
                            child: SizeWidget(isTapped: isTapped4, size: '6.5'),
                          ),
                          InkWell(
                            onTap: (() {
                              setState(() {
                                size = '7';
                                isTapped1 = false;
                                isTapped2 = false;
                                isTapped3 = false;
                                isTapped4 = false;
                                isTapped5 = true;
                                isTapped6 = false;
                              });
                            }),
                            child: SizeWidget(isTapped: isTapped5, size: '7'),
                          ),
                          InkWell(
                            onTap: (() {
                              setState(() {
                                size = '7.5';
                                isTapped1 = false;
                                isTapped2 = false;
                                isTapped3 = false;
                                isTapped4 = false;
                                isTapped5 = false;
                                isTapped6 = true;
                              });
                            }),
                            child: SizeWidget(isTapped: isTapped6, size: '7.5'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.grey.shade300,
                              ),
                              child: Center(
                                child: Text(
                                  '\$ ${shoe.cost}',
                                  style: textstylecollection.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Gap(8),
                          isOutOfStock
                              ? Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: isInCart
                                          ? Colors.red.shade300
                                          : Colors.grey,
                                    ),
                                    child: Center(
                                      child: Text(
                                        isInCart
                                            ? 'Already In Cart'
                                            : 'Add To Cart',
                                        style: textstylecollection.copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: isGuest
                                        ? () {
                                            showSnackBar(context,
                                                'You need to be logged in');
                                          }
                                        : size == ''
                                            ? isInCart
                                                ? () {}
                                                : () {
                                                    showSnackBar(context,
                                                        'You have not selected a size');
                                                  }
                                            : isInCart
                                                ? () {
                                                    showSnackBar(context,
                                                        'Already In Cart');
                                                  }
                                                : () {
                                                    addToCart(
                                                        context, size, shoe);
                                                    setState(() {
                                                      isTapped1 = false;
                                                      isTapped2 = false;
                                                      isTapped3 = false;
                                                      isTapped4 = false;
                                                      isTapped5 = false;
                                                      isTapped6 = false;
                                                      size = '';
                                                    });
                                                  },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: isInCart
                                            ? Colors.red.shade300
                                            : Colors.black87,
                                      ),
                                      child: Center(
                                        child: Text(
                                          isInCart
                                              ? 'Already In Cart'
                                              : 'Add To Cart',
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
                    )
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
