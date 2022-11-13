import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/core/utils.dart';
import 'package:shoes_app_ui_training/models/shoe_model.dart';
import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';

import '../utils/styles.dart';

class ShoeWidget extends ConsumerStatefulWidget {
  final Shoe shoe;
  const ShoeWidget({
    super.key,
    required this.shoe,
  });

  @override
  ConsumerState<ShoeWidget> createState() => _ShoeWidgetState();
}

class _ShoeWidgetState extends ConsumerState<ShoeWidget> {
  @override
  Widget build(BuildContext context) {
    void navigateToShoeScreen(BuildContext context) {
      Routemaster.of(context).push('/shoe-screen/${widget.shoe.id}');
    }

    void like(WidgetRef ref) async {
      ref.read(shoeControllerProvider.notifier).like(widget.shoe);
    }

    final user = ref.watch(userProvider)!;
    final shoe = widget.shoe;
    bool isLiked = shoe.likes.contains(user.uid);
    final isGuest = !user.isAuthenticated;

    return InkWell(
      onTap: () => navigateToShoeScreen(context),
      child: Padding(
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
                    widget.shoe.image,
                  ),
                  radius: 95,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.all(4),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            IconButton(
                              onPressed: isGuest
                                  ? () {
                                      showSnackBar(context,
                                          'You need to be logged in to add a shoe to favorite.');
                                    }
                                  : () => like(ref),
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
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.shoe.brand,
                        style: textstyle2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        widget.shoe.title,
                        style: textstyle2.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        '\$ ${widget.shoe.cost}',
                        style: textstyle1.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      widget.shoe.count == 0
                          ? Text(
                              overflow: TextOverflow.ellipsis,
                              'Out of stock',
                              style: textstyle2.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            )
                          : Text(
                              overflow: TextOverflow.ellipsis,
                              'Available',
                              style: textstyle2.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
