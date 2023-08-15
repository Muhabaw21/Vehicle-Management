import 'dart:math';

import 'package:flutter/material.dart';

import '../const/constant.dart';

// clipp up contianer
class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
        size.width - (size.width / 2), size.height, size.width, 0);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// clipping bottom container
class ClippingClasss extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

    path.quadraticBezierTo(
        size.width / 2, size.height - 100, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(0, 0),
      radius: Radius.circular(size.height),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DashLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final dashWidth = 3;
    final dashSpace = 5;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DashLinePainter oldDelegate) => false;
}

class QuarterCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Color:
    Colors.white;
    final path = Path();
    final radius = min(size.width, size.height);
    path.lineTo(radius, 0.0);
    path.arcTo(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius),
      -pi / 2,
      -pi / 2,
      false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class HalfClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.arcToPoint(Offset(0, 0),
        radius: Radius.circular(50), clockwise: false);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HalfCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kBackgroundColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width, size.height)
      ..arcTo(
        Rect.fromCircle(
          center: Offset(size.width, size.height / 2),
          radius: size.height / 2,
        ),
        -1.5708, // Use -1.5708 (90 degrees in radians) for a half-circle
        -3.1416,
        false,
      )
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

