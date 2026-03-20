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
                  crossAxisAlignment: isMobile
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    // status pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4AE08A).withValues(alpha: 0.07),
                        border: Border.all(
                          color: const Color(
                            0xFF4AE08A,
                          ).withValues(alpha: 0.22),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          BlinkingDot(),
                          SizedBox(width: 8),
                          Text(
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

                    // avatar on mobile
                    if (isMobile) ...[
                      rightColumn(context, hPad: hPad, isMobile: true),
                      SizedBox(height: 20),
                    ],

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
                      textAlign: isMobile ? TextAlign.center : TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fluidNameSize,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      'App Developer.',
                      textAlign: isMobile ? TextAlign.center : TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fluidTitleSize,
                        color: colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Building cross-platform mobile apps with Flutter & Dart — clean code, smooth UX, and pixel-perfect interfaces from idea to Play Store.',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),

                    const SizedBox(height: 24),

                    // ── CTA buttons ──
                    if (isMobile)
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          CustomButton(
                            title: 'View Projects →',
                            onTap: () => context.go('/project'),
                            isActive: true,
                          ),
                          CustomButton(title: 'Download CV ↓', isActive: false),
                        ],
                      )
                    else
                      Row(
                        spacing: 20,
                        children: [
                          CustomButton(
                            title: 'View Projects →',
                            onTap: () => context.go('/project'),
                            isActive: true,
                          ),
                          CustomButton(title: 'Download CV ↓', isActive: false),
                        ],
                      ),

                    const Divider(),

                    // ── stats ──
                    if (isMobile)
                      Row(
                        children: [
                          Expanded(
                            child: bottomTitles(
                              context,
                              title: '2+',
                              desc: 'YEARS EXP.',
                              isMobile: true,
                            ),
                          ),
                          const SizedBox(height: 40, child: VerticalDivider()),
                          Expanded(
                            child: bottomTitles(
                              context,
                              title: '5',
                              desc: 'PROJECTS',
                              isMobile: true,
                            ),
                          ),
                          const SizedBox(height: 40, child: VerticalDivider()),
                          Expanded(
                            child: bottomTitles(
                              context,
                              title: '0',
                              desc: 'CLIENTS',
                              isMobile: true,
                            ),
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          bottomTitles(
                            context,
                            title: '2+',
                            desc: 'YEARS EXP.',
                          ),
                          Row(
                            spacing: 20,
                            children: [
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(),
                              ),
                              bottomTitles(
                                context,
                                title: '5',
                                desc: 'PROJECTS',
                              ),
                            ],
                          ),
                          Row(
                            spacing: 20,
                            children: [
                              const SizedBox(
                                height: 50,
                                child: VerticalDivider(),
                              ),
                              bottomTitles(
                                context,
                                title: '0',
                                desc: 'CLIENTS',
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),

          // hide vertical divider on mobile
          if (!isMobile) const VerticalDivider(width: 1),

          // right column desktop only
          if (isDesktop) rightColumn(context, hPad: hPad),
        ],
      ),
    );
  }

  Widget bottomTitles(
    BuildContext context, {
    required String title,
    required String desc,
    bool isMobile = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorScheme.primary,
            fontSize: isMobile ? 22 : 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          desc,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: isMobile ? 8 : null,
            letterSpacing: isMobile ? 1.0 : 2.0,
          ),
        ),
      ],
    );
  }

  // 👈 added isMobile parameter
  Widget rightColumn(
    BuildContext context, {
    required double hPad,
    bool isMobile = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 0 : hPad,
        vertical: isMobile ? 0 : 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30,
        children: [
          // scale down avatar on mobile
          Transform.scale(
            scale: isMobile ? 0.75 : 1.0,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: const [
                SpinningAvatar(),
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
          ),

          // ── skills: Wrap on mobile, two Rows on desktop ──
          if (isMobile)
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: const [
                SkillsContainer(title: 'Flutter'),
                SkillsContainer(title: 'Dart'),
                SkillsContainer(title: 'Firebase'),
                SkillsContainer(title: 'REST API'),
                SkillsContainer(title: 'Git'),
                SkillsContainer(title: 'Figma'),
                SkillsContainer(title: 'SQLite'),
                SkillsContainer(title: 'BLoC'),
              ],
            )
          else ...[
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SkillsContainer(title: 'Flutter'),
                SkillsContainer(title: 'Dart'),
                SkillsContainer(title: 'Firebase'),
                SkillsContainer(title: 'REST API'),
              ],
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SkillsContainer(title: 'Git'),
                SkillsContainer(title: 'Figma'),
                SkillsContainer(title: 'SQLite'),
                SkillsContainer(title: 'BLoC'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
