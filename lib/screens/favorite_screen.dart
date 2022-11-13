import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/screens/favorite_shoes.dart';

import 'package:shoes_app_ui_training/utils/styles.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  bool isOrdered = false;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        'Favorite',
                        style: textstyle1.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
                      child: FavoriteShoes(
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
