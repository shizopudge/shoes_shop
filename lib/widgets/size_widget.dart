import 'package:flutter/material.dart';

import '../utils/styles.dart';

class SizeWidget extends StatefulWidget {
  final bool isTapped;
  final String size;
  const SizeWidget({super.key, required this.isTapped, required this.size});

  @override
  State<SizeWidget> createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: widget.isTapped ? Colors.black87 : Colors.grey.shade300,
        ),
        child: Center(
          child: Text(
            widget.size,
            style: textstylecollection.copyWith(
              color: widget.isTapped ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
