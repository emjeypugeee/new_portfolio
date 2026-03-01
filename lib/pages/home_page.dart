import 'package:flutter/material.dart';
import 'package:portfolio_v2/widgets/custom_app_bar.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/blinking_dot.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/floating_badge.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/spinning_avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hPad = width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFF141414),
      // ── NAVBAR ──
      appBar: PreferredSize(preferredSize: Size.fromHeight(53), child: CustomAppBar()),
      // ── BODY ──
      body: SizedBox.expand(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LEFT COLUMN
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4AE08A).withValues(alpha: 0.07),
                        border: Border.all(color: const Color(0xFF4AE08A).withValues(alpha: 0.22)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const BlinkingDot(),
                          const SizedBox(width: 8),
                          const Text(
                            'AVAILABLE FOR FREELANCE',
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.8,
                              color: Color(0xFF4AE08A),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Hi, I\'m',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    ),
                    const Text(
                      'Mark Jonas Undang',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 50,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'App Developer.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 80,
                        color: Color(0xFFF5C518),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Building cross-platform mobile apps with Flutter & Dart — clean code,\nsmooth UX, and pixel-perfect interfaces from idea to Play Store.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      spacing: 20,
                      children: [
                        buttonContainer(
                          bgColor: const Color(0xFFF5C518),
                          borderColor: Colors.transparent,
                          title: 'View Projects →',
                          textColor: const Color(0xFF141414),
                        ),
                        buttonContainer(
                          bgColor: Colors.transparent,
                          borderColor: const Color(0xFFF5C518),
                          title: 'Download CV ↓',
                          textColor: const Color(0xFFF5C518),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: Colors.white.withValues(alpha: 0.07)),
                  ],
                ),
              ),
            ),

            // DIVIDER
            Container(width: 1, color: Colors.white.withValues(alpha: 0.07)),

            // RIGHT COLUMN
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      const SpinningAvatar(),
                      Positioned(
                        top: 20,
                        left: -10,
                        child: FloatingBadge(
                          icon: '📱',
                          label: 'Primary Stack',
                          value: 'Flutter · Dart',
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: -10,
                        child: FloatingBadge(
                          icon: '🔥',
                          label: 'Open to work',
                          value: 'Remote / On-site',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      skillsContainer(title: 'Flutter'),
                      skillsContainer(title: 'Dart'),
                      skillsContainer(title: 'Firebase'),
                      skillsContainer(title: 'REST API'),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      skillsContainer(title: 'Git'),
                      skillsContainer(title: 'Figma'),
                      skillsContainer(title: 'SQLite'),
                      skillsContainer(title: 'BLoC'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonContainer({
    required Color bgColor,
    required Color borderColor,
    required String title,
    required Color textColor,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: borderColor),
        ),
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget skillsContainer({required String title}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF262315),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: const Color(0xFFF5C518)),
      ),
      child: Text(title, style: const TextStyle(color: Color(0xFFF5C518), letterSpacing: 0.8)),
    );
  }
}
