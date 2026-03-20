import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_v2/widgets/global_widgets/custom_button.dart';
import 'package:portfolio_v2/widgets/global_widgets/skills_container.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/blinking_dot.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/floating_badge.dart';
import 'package:portfolio_v2/widgets/home_page_widgets/spinning_avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final hPad = width * 0.05;
    final vPad = height * 0.1;
    final bool isDesktop = width > 1200;
    final bool isMobile = width < 500;

    final double fluidTitleSize = (width * 0.06).clamp(40.0, 80.0);
    final double fluidNameSize = (width * 0.04).clamp(28.0, 50.0);

    return SizedBox.expand(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT COLUMN
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4AE08A).withValues(alpha: 0.07),
                        border: Border.all(
                          color: const Color(0xFF4AE08A).withValues(alpha: 0.22),
                        ),
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
                    if (isMobile) rightColumn(context, hPad: hPad),
                    Text(
                      'Hi, I\'m',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 30,
                      ),
                    ),
              
                    Text(
                      'Mark Jonas Undang',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fluidNameSize,
                        color: colorScheme.onSurface,
                      ),
                    ),
              
                    Text(
                      'App Developer.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fluidTitleSize,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
              
                    Text(
                      'Building cross-platform mobile apps with Flutter & Dart — clean code,\nsmooth UX, and pixel-perfect interfaces from idea to Play Store.',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
              
                    Row(
                      spacing: 20,
                      children: [
                        CustomButton(
                          title: 'View Projects →',
                          onTap: () => context.push('/project'),
                          isActive: true,
                        ),
                        CustomButton(
                          title: 'Download CV ↓',
                          isActive: false,
                        ),
                      ],
                    ),
              
                    const Divider(),
              
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        bottomTitles(context, title: '2+', desc: 'YEARS EXP.'),
                        Row(
                          spacing: 20,
                          children: [
                            const SizedBox(
                              height: 50,
                              child: VerticalDivider(),
                            ),
                            bottomTitles(context, title: '5', desc: 'PROJECTS'),
                          ],
                        ),
                        Row(
                          spacing: 20,
                          children: [
                            const SizedBox(
                              height: 50,
                              child: VerticalDivider(),
                            ),
                            bottomTitles(context, title: '0', desc: 'CLIENTS'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const VerticalDivider(width: 1),

          if (isDesktop) rightColumn(context, hPad: hPad),
        ],
      ),
    );
  }

  Widget bottomTitles(
    BuildContext context, {
    required String title,
    required String desc,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          desc,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }

  Widget rightColumn(BuildContext context, {required double hPad}) {
    return Padding(
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
              const Positioned(
                top: 20,
                left: -10,
                child: FloatingBadge(
                  icon: '📱',
                  label: 'Primary Stack',
                  value: 'Flutter · Dart',
                ),
              ),
              const Positioned(
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
              SkillsContainer(title: 'Flutter'),
              SkillsContainer(title: 'Dart'),
              SkillsContainer(title: 'Firebase'),
              SkillsContainer(title: 'REST API'),
            ],
          ),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkillsContainer(title: 'Git'),
              SkillsContainer(title: 'Figma'),
              SkillsContainer(title: 'SQLite'),
              SkillsContainer(title: 'BLoC'),
            ],
          ),
        ],
      ),
    );
  }
}
