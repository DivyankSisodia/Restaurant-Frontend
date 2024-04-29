import 'package:flutter/material.dart';

class DotSeparatorWidget extends StatelessWidget {
  const DotSeparatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: TextStyle(
        fontSize: 14,
        color: Colors.black.withOpacity(0.8),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
