import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedLineWidget extends StatelessWidget {
  const DottedLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: DottedLine(
        dashColor: Colors.grey,
        dashGapLength: 5,
      ),
    );
  }
}
