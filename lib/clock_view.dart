import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var datetime = DateTime.now();
    // Properties
    var centerX = size.width / 2;
    var centerY = size.width / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var secHandX = centerX + 80 * cos(datetime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(datetime.second * 6 * pi / 180);
    var minHandX = centerX + 80 * cos(datetime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(datetime.minute * 6 * pi / 180);
    var hourHandX = centerX +
        60 * cos((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((datetime.hour * 30 + datetime.minute * 0.5) * pi / 180);
    // ----------------------------

    /// Brushes
    // innercirclebrush
    var circleFillBrush = Paint()..color = const Color(0xFF444974);

    //centerdotbrush
    var centerCircleBrush = Paint()..color = Colors.white;
    //centerdotbrush
    var centerCircleBrushStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    //centerdotbrushwith yellow ring
    var centerYellowRingBrush = Paint()
      ..color = Colors.orange[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    //centerdotbrushwith Pink ring
    var centerPinkRingBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      // ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    //centerdotbrushwith Blue ring
    var centerBlueRingBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // outercirclebrush
    var outerCircleFillBrush = Paint()
      ..color = Colors.white
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    // secHandBrush
    var secHandBrush = Paint()
      ..color = Colors.orange[300]!
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // minHandBrush
    var minHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFF748EF6), Color(0xFF77DDFF)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // hourHandBrush
    var hourHandBrush = Paint()
      ..shader =
          const RadialGradient(colors: [Color(0xFFEA74AB), Color(0xFFC279FB)])
              .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12;

    /// Laying shapes
    canvas.drawCircle(center, radius - 40, circleFillBrush);
    canvas.drawCircle(center, radius - 40, outerCircleFillBrush);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);
    canvas.drawCircle(center, 15, centerCircleBrush);
    canvas.drawCircle(center, 7, centerYellowRingBrush);
    canvas.drawCircle(center, 5, centerBlueRingBrush);
    canvas.drawCircle(center, 4, centerPinkRingBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
