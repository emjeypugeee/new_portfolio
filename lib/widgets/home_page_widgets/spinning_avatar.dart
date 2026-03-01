import 'package:flutter/material.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/dashed_circle_painter.dart';

class SpinningAvatar extends StatefulWidget {
  const SpinningAvatar({super.key});

  @override
  State<SpinningAvatar> createState() => _SpinningAvatarState();
}

class _SpinningAvatarState extends State<SpinningAvatar> with TickerProviderStateMixin {
  // TickerProviderStateMixin for multiple controllers
  late AnimationController _ring1;
  late AnimationController _ring2;

  @override
  void initState() {
    super.initState();

    // inner ring — spins forward, 20 seconds per rotation
    _ring1 = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();

    // outer ring — spins backward, slower
    _ring2 = AnimationController(vsync: this, duration: const Duration(seconds: 35))..repeat();
  }

  @override
  void dispose() {
    _ring1.dispose();
    _ring2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // outer ring (spins reverse)
          AnimatedBuilder(
            animation: _ring2,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_ring2.value * 2 * 3.14159265, // negative = reverse
                child: child,
              );
            },
            child: SizedBox(
              width: 250,
              height: 250,
              child: CustomPaint(
                painter: DashedCirclePainter(
                  color: Color(0xFFF5C518).withOpacity(0.09),
                  strokeWidth: 1.0,
                  dashCount: 24,
                ),
              ),
            ),
          ),

          // inner ring (spins forward)
          AnimatedBuilder(
            animation: _ring1,
            builder: (context, child) {
              return Transform.rotate(angle: _ring1.value * 2 * 3.14159265, child: child);
            },
            child: SizedBox(
              width: 230,
              height: 230,
              child: CustomPaint(
                painter: DashedCirclePainter(
                  color: Color(0xFFF5C518).withOpacity(0.22),
                  strokeWidth: 1.5,
                  dashCount: 20,
                ),
              ),
            ),
          ),

          // yellow border around avatar
          Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFF5C518).withOpacity(0.25), width: 2.5),
            ),
          ),

          // the actual avatar
          CircleAvatar(
            radius: 102,
            backgroundColor: Color(0xFF272727),
            child: Text(
              'MJ',
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontSize: 52,
                fontWeight: FontWeight.w900,
                color: Color(0xFFF5C518),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
