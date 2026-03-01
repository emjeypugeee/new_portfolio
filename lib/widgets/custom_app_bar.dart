import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1E1E1E),
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 52,
      titleSpacing: 50,
      title: const Text(
        'MJU.DEV',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: Color(0xFFF5C518),
          letterSpacing: 0.8,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.white.withValues(alpha: 0.07)),
      ),
      actions: [
        _navLink('Home', isActive: true),
        _navLink('About'),
        _navLink('Projects'),
        _navLink('Resume'),
        const SizedBox(width: 16),
        _hireButton(),
        const SizedBox(width: 32),
      ],
    );
  }

  // ── NAV HELPERS ──
  Widget _navLink(String label, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 0.5,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                color: isActive ? const Color(0xFFF5C518) : Colors.grey,
              ),
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 2),
                height: 1,
                width: 24,
                color: const Color(0xFFF5C518),
              ),
          ],
        ),
      ),
    );
  }

  Widget _hireButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFF5C518),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Hire Me ↗',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF141414),
            letterSpacing: 0.6,
          ),
        ),
      ),
    );
  }
}
