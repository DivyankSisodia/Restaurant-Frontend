import 'package:flutter/material.dart';


class IsAvailableContainer extends StatelessWidget {
  const IsAvailableContainer({
    super.key,
    required this.isOpen,
  });

  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isOpen ? Colors.green : Colors.red,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          isOpen ? Icons.check : Icons.close,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
