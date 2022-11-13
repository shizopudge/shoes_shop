import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/styles.dart';

class CollectionWidget extends StatefulWidget {
  final bool isTapped;
  final String collection;
  final String collectionpic;
  const CollectionWidget({
    super.key,
    required this.isTapped,
    required this.collection,
    required this.collectionpic,
  });

  @override
  State<CollectionWidget> createState() => _CollectionWidgetState();
}

class _CollectionWidgetState extends State<CollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 80,
        width: widget.isTapped ? 140 : 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          color: widget.isTapped ? Colors.black87 : Colors.grey.shade300,
        ),
        child: widget.isTapped
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.collectionpic,
                    height: 45,
                  ),
                  const Gap(5),
                  Text(
                    widget.collection,
                    style: textstylecollection,
                  ),
                ],
              )
            : Center(
                child: Image.asset(
                  widget.collectionpic,
                  height: 40,
                ),
              ),
      ),
    );
  }
}
