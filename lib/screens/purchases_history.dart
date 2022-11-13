import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import 'package:shoes_app_ui_training/auth/auth_controller.dart';

import 'package:shoes_app_ui_training/screens/purchases_shoes.dart';

import 'package:shoes_app_ui_training/utils/styles.dart';

class PurchasesHistoryScreen extends ConsumerStatefulWidget {
  const PurchasesHistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<PurchasesHistoryScreen> {
  bool isOrdered = false;
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: (() {
                        Routemaster.of(context).pop();
                      }),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 28,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Sort by',
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
                        'Purchases',
                        style: textstyle1.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: PurchaseShoes(
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
