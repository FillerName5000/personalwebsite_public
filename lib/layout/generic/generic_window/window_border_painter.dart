import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';

class WindowBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..color = windowLightFirstExternalBorderColor
          ..strokeWidth = 1;
    canvas.drawPath(
      // in pixels
      Path()
        ..moveTo(6, size.height) // bottom left with offset
        ..lineTo(0, size.height) // bottom left
        ..lineTo(0, 0) // top left
        ..lineTo(size.width, 0) // top right
        ..lineTo(size.width, 6) // top right with offset
        ..lineTo(size.width, 0) // top right
        ..lineTo(0, 0) // top left
        ..lineTo(0, size.height) // bottom lft
        ..close(),
      paint,
    );

    paint
      ..color = windowDarkFirstExternalBorderColor
      ..strokeWidth = 1;
    canvas.drawPath(
      Path()
        ..moveTo(size.width, 0) // top right
        ..lineTo(size.width, size.height) // bottom right
        ..lineTo(0, size.height) // bottom left
        ..lineTo(size.width, size.height) // bottom right
        ..lineTo(size.width, 0) // top right
        ..close(),
      paint,
    );

    paint
      ..color = windowLightSecondExternalBorderColor
      ..strokeWidth = 2;
    canvas.drawPath(
      Path()
        ..moveTo(6, size.height - 1) // bottom left with offset
        ..lineTo(1, size.height - 1) // bottom left
        ..lineTo(1, 1) // top left
        ..lineTo(size.width - 1, 1) // top right
        ..lineTo(size.width - 1, 2) // top right
        ..lineTo(1, 1) // top left
        ..lineTo(1, size.height - 1) // bottom left
        ..close(),
      paint,
    );

    paint
      ..color = windowDarkSecondExternalBorderColor
      ..strokeWidth = 2;
    canvas.drawPath(
      Path()
        ..moveTo(size.width - 1, 2) // top right
        ..lineTo(size.width - 1, size.height - 1) // bottom right
        ..lineTo(2, size.height - 1) // bottom left
        ..lineTo(4, size.height - 3) // bottom left
        ..lineTo(size.width - 1, size.height - 1) // bottom right
        ..lineTo(size.width - 1, 2) // top right
        ..lineTo(size.width - 3, 4) // top right
        ..close(),
      paint,
    );

    paint
      ..color = menuBackgroundColor
      ..strokeWidth = 4;
    canvas.drawRect(
      Rect.fromLTWH(4, 4, size.width - 8, size.height - 8),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
