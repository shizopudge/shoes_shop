import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app_ui_training/common/error_text.dart';
import 'package:shoes_app_ui_training/common/loader.dart';
import 'package:shoes_app_ui_training/shoes/controller/shoes_controller.dart';
import 'package:shoes_app_ui_training/widgets/shoe_widget.dart';

// class Shoes extends ConsumerStatefulWidget {
//   final String brand;
//   const Shoes({
//     super.key,
//     required String brand,
//   }) : brand = 'Adidas';

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ShoesState();
// }

// class _ShoesState extends ConsumerState<Shoes> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.brand == '') {
//       return ref.watch(getShoesProvider).when(
//             data: (data) {
//               return ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     final shoe = data[index];
//                     return ShoeWidget(
//                         img: shoe.image, title: shoe.title, cost: shoe.cost);
//                   });
//             },
//             error: ((error, stackTrace) => Center(
//                   child: ErrorText(
//                     error: error.toString(),
//                   ),
//                 )),
//             loading: () => const Loader(),
//           );
//     }
//     return ref.watch(getShoesByBrandProvider(widget.brand)).when(
//           data: (data) {
//             return ListView.builder(
//                 itemCount: data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final shoe = data[index];
//                   return ShoeWidget(
//                       img: shoe.image, title: shoe.title, cost: shoe.cost);
//                 });
//           },
//           error: ((error, stackTrace) => Center(
//                 child: ErrorText(
//                   error: error.toString(),
//                 ),
//               )),
//           loading: () => const Loader(),
//         );
//   }
// }

class Shoes extends ConsumerWidget {
  final String brand;
  final bool isOrdered;
  const Shoes({
    super.key,
    this.brand = '',
    required this.isOrdered,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (brand == '') {
      return isOrdered
          ? ref.watch(getShoesCostDecendingProvider).when(
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
          : ref.watch(getShoesProvider).when(
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
    return isOrdered
        ? ref.watch(getShoesByBrandCostDecendingProvider(brand)).when(
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
        : ref.watch(getShoesByBrandProvider(brand)).when(
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
