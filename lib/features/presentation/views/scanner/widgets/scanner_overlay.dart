import 'package:flutter/material.dart';

class QRScannerOverlay extends StatelessWidget {
  final Color overlayColour;

  const QRScannerOverlay({super.key, required this.overlayColour});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scanArea = (size.width < 400 || size.height < 400)
        ? size.width - 40
        : size.width * 0.7;

    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.22 + 50 + (size.height * 0.4) / 2),
      width: scanArea,
      height: size.height * 0.4,
    );

    return Stack(
      children: [
        // Background overlay with a transparent hole
        CustomPaint(
          size: size,
          painter: ScannerOverlayPainter(
            scanRect: scanRect,
            overlayColor: overlayColour,
          ),
        ),
        // Border outline for scan area
        Positioned(
          top: scanRect.top + 6,
          left: scanRect.left + 6,
          child: CustomPaint(
            foregroundPainter: BorderPainter(),
            child: SizedBox(
              width: scanRect.width - 12,
              height: scanRect.height - 12,
            ),
          ),
        ),
      ],
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final Rect scanRect;
  final Color overlayColor;

  ScannerOverlayPainter({
    required this.scanRect,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = overlayColor;

    // Full screen overlay path
    final backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Transparent cut-out path
    final holePath = Path()
      ..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(14)))
      ..close();

    // Combine paths to cut the hole
    final finalPath = Path.combine(PathOperation.difference, backgroundPath, holePath);

    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double borderWidth = 4.0;
    const double cornerRadius = 10.0;
    const double clipPadding = 5 * cornerRadius;

    final rect = Rect.fromLTWH(
      borderWidth,
      borderWidth,
      size.width - 2 * borderWidth,
      size.height - 2 * borderWidth,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(cornerRadius),
    );

    final clippingRects = [
      Rect.fromLTWH(0, 0, clipPadding, clipPadding),
      Rect.fromLTWH(size.width - clipPadding, 0, clipPadding, clipPadding),
      Rect.fromLTWH(0, size.height - clipPadding, clipPadding, clipPadding),
      Rect.fromLTWH(size.width - clipPadding, size.height - clipPadding, clipPadding, clipPadding),
    ];

    final clipPath = Path();
    for (final rect in clippingRects) {
      clipPath.addRect(rect);
    }
    canvas.clipPath(clipPath);

    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white // 🔄 Use white or another visible color
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
