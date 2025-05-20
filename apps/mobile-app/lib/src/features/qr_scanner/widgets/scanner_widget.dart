import 'package:flutter/material.dart';

class QRScannerOverlay extends StatelessWidget {
  const QRScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dark overlay covering the entire screen
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.srcOut,
          ),
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Scanner corner decorations
        Center(
          child: SizedBox(
            width: 280,
            height: 280,
            child: Stack(
              children: [
                _buildGradientCorner(Alignment.topLeft, false, true),
                _buildGradientCorner(Alignment.topRight, false, false),
                _buildGradientCorner(Alignment.bottomLeft, true, true),
                _buildGradientCorner(Alignment.bottomRight, true, false),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientCorner(Alignment alignment, bool isBottom, bool isLeft) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: 60,
        height: 60,
        child: CustomPaint(
          painter: GradientBorderPainter(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF849D65),
                Color(0xFF849D65),
              ],
            ),
            isBottom: isBottom,
            isLeft: isLeft,
            strokeWidth: 6,
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final Gradient gradient;
  final bool isBottom;
  final bool isLeft;
  final double strokeWidth;

  GradientBorderPainter({
    required this.gradient,
    required this.isBottom,
    required this.isLeft,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(Offset.zero & size)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final radius = size.width * 0.6;
    final length = size.width * 1;

    Path path = Path();

    if (isLeft) {
      if (isBottom) {
        path.moveTo(0, size.height - length);
        path.lineTo(0, size.height - radius);
        path.quadraticBezierTo(0, size.height, radius, size.height);
        path.lineTo(length, size.height);
      } else {
        path.moveTo(length, 0);
        path.lineTo(radius, 0);
        path.quadraticBezierTo(0, 0, 0, radius);
        path.lineTo(0, length);
      }
    } else {
      if (isBottom) {
        path.moveTo(size.width - length, size.height);
        path.lineTo(size.width - radius, size.height);
        path.quadraticBezierTo(size.width, size.height, size.width, size.height - radius);
        path.lineTo(size.width, size.height - length);
      } else {
        path.moveTo(size.width, length);
        path.lineTo(size.width, radius);
        path.quadraticBezierTo(size.width, 0, size.width - radius, 0);
        path.lineTo(size.width - length, 0);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}