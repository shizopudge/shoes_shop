import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/widgets/shoe_widget.dart';

class FavoriteShoes extends ConsumerWidget {
  final bool isOrdered;
  const FavoriteShoes({
    super.key,
    required this.isOrdered,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return isOrdered
        ? ref.watch(getLikedShoesCostDecendingProvider(user.uid)).when(
              data: (data) {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final shoe = data[index];
                      return ShoeWidget(
                        shoe: shoe,
                      );
                    });
              },
              error: ((error, stackTrace) => Center(
                    child: ErrorText(
                      error: error.toString(),
                    ),
                  )),
              loading: () => const Loader(),
            )
        : ref.watch(getLikedShoesProvider(user.uid)).when(
              data: (data) {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final shoe = data[index];
                      return ShoeWidget(
                        shoe: shoe,
                      );
                    });
              },
              error: ((error, stackTrace) => Center(
                    child: ErrorText(
                      error: error.toString(),
                    ),
                  )),
              loading: () => const Loader(),
            );
  }
}
