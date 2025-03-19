
import 'package:flutter/material.dart';

import '../../../../../core/utils/utils_barrel.dart';


class QRScannerOverlay extends StatelessWidget {
  final Color overlayColour;
  const QRScannerOverlay({super.key, required this.overlayColour});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? size.width - 40 : size.width * 0.7;
    return Stack(
      alignment: Alignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(overlayColour, BlendMode.srcOut), // This one will create the magic
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      backgroundBlendMode: BlendMode.dstOut
                  ), // This one will handle background + difference out
                ),
                Positioned(
                  top: size.height*0.22 + 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height * 0.4,
                      width: scanArea,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: size.height*0.22 + 56,
            child: CustomPaint(
              foregroundPainter: BorderPainter(),
              child: SizedBox(
                height: size.height * 0.4 - 14,
                width: scanArea - 14,
              ),
            ),
          ),
        ]
    );
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const width = 4.0;
    const radius = 10.0;
    const tRadius = 5 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));
    const clippingRect0 = Rect.fromLTWH(
      0,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect1 = Rect.fromLTWH(
      size.width - tRadius,
      0,
      tRadius,
      tRadius,
    );
    final clippingRect2 = Rect.fromLTWH(
      0,
      size.height - tRadius,
      tRadius,
      tRadius,
    );
    final clippingRect3 = Rect.fromLTWH(
      size.width - tRadius,
      size.height - tRadius,
      tRadius,
      tRadius,
    );

    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = AppColors.primaryColor as Color
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BarReaderSize {
  static double width = 200;
  static double height = 200;
}

class OverlayWithHolePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
          Path()..addOval(Rect.fromCircle(center: Offset(size.width - 44, size.height - 44), radius: 40))..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
}