import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shoes_app_ui_training/auth/auth_controller.dart';
import 'package:shoes_app_ui_training/drawers/profile_drawer.dart';
import 'package:shoes_app_ui_training/screens/shoes.dart';
import 'package:shoes_app_ui_training/widgets/all_collection_widget.dart';
import 'package:shoes_app_ui_training/widgets/collection_widget.dart';
import 'package:shoes_app_ui_training/widgets/search_shoe_delegate.dart';

import '../utils/styles.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  bool isAll = true;
  bool isNike = false;
  bool isAdidas = false;
  bool isPuma = false;
  bool isOrdered = false;
  String brand = '';
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      endDrawer: const ProfileDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  user.isAuthenticated
                      ? Row(
                          children: [
                            Text(
                              'Hi ',
                              style: textstyle1.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${user.name}!',
                              style: textstyle2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 200, 0),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              'Hi ',
                              style: textstyle1.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'guest!',
                              style: textstyle2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 200, 0),
                              ),
                            )
                          ],
                        ),
                  user.isAuthenticated
                      ? Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                                onTap: () => displayEndDrawer(context),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(user.avatar),
                                  radius: 28,
                                )),
                          );
                        })
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
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
                        ),
                ],
              ),
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
                      Text('Collections', style: textstyle1),
                    ],
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Container(
                        height: 90,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: SearchShoeDelegate(ref));
                          },
                          icon: const Icon(
                            CupertinoIcons.search,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isNike = false;
                          isAdidas = false;
                          isPuma = false;
                          isAll = true;
                          brand = '';
                        });
                      },
                      child: AllCollectionWidget(
                          isTapped: isAll,
                          collection: 'All',
                          collectionpic: 'assets/images/logo.png'),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isNike = true;
                          brand = 'Nike';
                          isAdidas = false;
                          isPuma = false;
                          isAll = false;
                        });
                      },
                      child: CollectionWidget(
                        isTapped: isNike,
                        collection: 'Nike',
                        collectionpic: 'assets/images/nike.png',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isAdidas = true;
                          brand = 'Adidas';
                          isNike = false;
                          isPuma = false;
                          isAll = false;
                        });
                      },
                      child: CollectionWidget(
                        isTapped: isAdidas,
                        collection: 'Adidas',
                        collectionpic: 'assets/images/adidas.png',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isPuma = true;
                          brand = 'Puma';
                          isAdidas = false;
                          isNike = false;
                          isAll = false;
                        });
                      },
                      child: CollectionWidget(
                        isTapped: isPuma,
                        collection: 'Puma',
                        collectionpic: 'assets/images/puma.png',
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Shoes',
                    style: textstyle1.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
              Expanded(
                child: Shoes(
                  brand: brand,
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
