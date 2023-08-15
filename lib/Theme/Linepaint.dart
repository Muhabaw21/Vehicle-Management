

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint(), color = Colors.white, strokeWidth = 1;

    // Define the curve path
    Path path = Path()
      ..moveTo(0, size.height / 2)
      ..arcToPoint(Offset(size.width, size.height / 2),
          radius: Radius.circular(size.height / 2));
    clockwise:
    false;

    // Draw the curve
    canvas.drawPath(path, paint);

    // Draw the curve
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text('Row 1, Column 1'),
            ),
            Expanded(
              child: Text('Row 1, Column 2'),
            ),
            Expanded(
              child: Text('Row 1, Column 3'),
            ),
          ],
        ),
        CustomPaint(
          painter: CurvePainter(),
          child: Container(
            height: 1,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text('Row 2, Column 1'),
            ),
            Expanded(
              child: Text('Row 2, Column 2'),
            ),
            Expanded(
              child: Text('Row 2, Column 3'),
            ),
          ],
        ),
      ],
    );
  }
}
