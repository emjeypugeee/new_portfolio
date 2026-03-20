import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio_v2/widgets/about_page_widgets/education_card.dart';
import 'package:portfolio_v2/widgets/about_page_widgets/image_description.dart';
import 'package:portfolio_v2/widgets/about_page_widgets/stat_card.dart';
import 'package:portfolio_v2/widgets/global_widgets/custom_button.dart';
import 'package:portfolio_v2/widgets/global_widgets/dash_title.dart';
import 'package:portfolio_v2/widgets/global_widgets/skills_container.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 700;
    final bool isTablet = width >= 600 && width < 1024;

    const String desc =
        'A passionate App Developer based in Santa Maria, Bulacan Philippines, specializing in Flutter for cross-platform mobile development. I love crafting clean, performant apps with great user experiences.';

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 20 : 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── HERO — profile card + bio ──
              if (isMobile)
                // mobile: stack vertically
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageDescription(),
                    const SizedBox(height: 24),
                    _bioSection(context, desc: desc, isMobile: true),
                  ],
                )
              else
                // tablet + desktop: side by side
                Row(
                  spacing: 50,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageDescription(),
                    Expanded(
                      child: _bioSection(context, desc: desc, isMobile: false),
                    ),
                  ],
                ),

              const Divider(height: 40),

              // ── STAT CARDS ──
              // mobile: 2x2 grid, tablet+desktop: 4 in a row
              isMobile
                  ? Column(
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: StatCard(
                                number: '2+',
                                label: 'YEARS EXPERIENCE',
                              ),
                            ),
                            Expanded(
                              child: StatCard(
                                number: '5',
                                label: 'PROJECTS BUILT',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: StatCard(number: '1', label: 'CLIENT'),
                            ),
                            Expanded(
                              child: StatCard(
                                number: '∞',
                                label: 'MATCHA CONSUMED',
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 8,
                      children: [
                        Expanded(
                          child: StatCard(
                            number: '2+',
                            label: 'YEARS EXPERIENCE',
                          ),
                        ),
                        Expanded(
                          child: StatCard(number: '5', label: 'PROJECTS BUILT'),
                        ),
                        Expanded(
                          child: StatCard(number: '1', label: 'CLIENT'),
                        ),
                        Expanded(
                          child: StatCard(
                            number: '∞',
                            label: 'MATCHA CONSUMED',
                          ),
                        ),
                      ],
                    ),

              const Divider(height: 40),
              const SizedBox(height: 8),

              // ── EDUCATION + EXPERIENCE ──
              // mobile: stacked column, tablet+desktop: side by side
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashTitle(title: 'EDUCATION'),
                    const SizedBox(height: 16),
                    EducationCard(
                      textIcon: '🎓',
                      title: 'Bachelor of Science in Information Technology',
                      place: 'STI Colleges · SJDM Bulacan',
                      year: '2022 - Present',
                    ),
                    const Divider(height: 40),
                    DashTitle(title: 'EXPERIENCE'),
                    const SizedBox(height: 16),
                    ..._timelineItems(context),
                  ],
                )
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DashTitle(title: 'EDUCATION'),
                            EducationCard(
                              textIcon: '🎓',
                              title:
                                  'Bachelor of Science in Information Technology',
                              place: 'STI Colleges · SJDM Bulacan',
                              year: '2022 - Present',
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20,
                          children: [
                            DashTitle(title: 'EXPERIENCE'),
                            ..._timelineItems(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ── extracted so both mobile + desktop share same items ──
  List<Widget> _timelineItems(BuildContext context) {
    return [
      timelineItem(
        context: context,
        date: 'FEB 2026 — Present',
        role: 'IT Intern',
        company: 'PGX Group Inc. · Philippines',
        isActive: true,
      ),
      timelineItem(
        context: context,
        date: 'DEC 2025 — Present',
        role: 'Flutter Developer Intern',
        company: 'Peddlr Philippines, Inc.',
        isActive: true,
      ),
      timelineItem(
        context: context,
        date: 'JUNE 2024 — AUG 2024',
        role: 'IT Intern',
        company: 'KnowlesTI · Singapore',
      ),
      timelineItem(
        context: context,
        date: 'AUG 2022 — DEC 2023',
        role: 'Service Crew',
        company: 'McDonalds · Philippines',
      ),
    ];
  }

  // ── bio section extracted to avoid duplication ──
  Widget _bioSection(
    BuildContext context, {
    required String desc,
    required bool isMobile,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        DashTitle(title: 'ABOUT ME'),
        const SizedBox(height: 12),
        Text.rich(
          TextSpan(
            text: 'Hi, I\'m ',
            style: TextStyle(
              fontSize: isMobile ? 36 : 50,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'Mark',
                style: TextStyle(
                  fontSize: isMobile ? 36 : 50,
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 12),
        Text(
          desc,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(color: colorScheme.onSurfaceVariant, height: 1.6),
        ),
        const Divider(height: 32),
        Text(
          'CORE SKILLS',
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 10),
        // Wrap instead of Row so chips don't overflow on small screens
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            SkillsContainer(title: 'Flutter'),
            SkillsContainer(title: 'Dart'),
            SkillsContainer(title: 'Firebase'),
            SkillsContainer(title: 'REST APIs'),
            SkillsContainer(title: 'Git'),
          ],
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            CustomButton(
              title: 'View Projects →',
              isActive: true,
              onTap: () => context.push('/project'),
            ),
            CustomButton(title: 'Contact me', isActive: false),
          ],
        ),
      ],
    );
  }

  Widget timelineItem({
    required BuildContext context,
    required String date,
    required String role,
    required String company,
    bool isActive = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? colorScheme.primary : Colors.transparent,
                  border: Border.all(
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    width: 1.5,
                  ),
                ),
              ),
              Expanded(
                child: Container(width: 1.5, color: colorScheme.outlineVariant),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 12,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    company,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
