import 'package:flutter/material.dart';

class FloatingBadge extends StatefulWidget {
  final String icon;
  final String label;
  final String value;

  const FloatingBadge({super.key, required this.icon, required this.label, required this.value});

  @override
  State<FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<FloatingBadge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000))
      ..repeat(reverse: true);

    _float = Tween<double>(
      begin: 0,
      end: -6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _float.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.07)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // icon box
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFF5C518).withOpacity(0.1),
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: const Color(0xFFF5C518).withOpacity(0.25)),
              ),
              child: Center(child: Text(widget.icon, style: const TextStyle(fontSize: 14))),
            ),
            const SizedBox(width: 9),
            // text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label.toUpperCase(),
                  style: TextStyle(fontSize: 9, color: const Color(0xFF777777), letterSpacing: 0.7),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.value,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF0EDE6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
