import 'package:flutter/material.dart';
import 'package:portfolio_v2/widgets/global_widgets/custom_button.dart';
import 'package:portfolio_v2/widgets/global_widgets/dash_title.dart';
import 'package:portfolio_v2/widgets/resume_page_widgets/experience_item.dart';
import 'package:portfolio_v2/widgets/resume_page_widgets/section_title.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DashTitle(title: 'MY RESUME'),
              const SizedBox(height: 12),

              // ── header ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Skills &',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(
                                text: ' Experience',
                                style: TextStyle(color: colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '2+ years building Flutter apps across school projects, internships and personal projects.',
                          textAlign: isMobile ? TextAlign.center : TextAlign.start,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  CustomButton(title: 'Download PDF', isActive: true),
                ],
              ),

              const Divider(height: 40),

              // ── BODY — sidebar + main ──
              // mobile: stacked, tablet+desktop: side by side
              if (isMobile)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sidebar(context, isMobile: true),
                    const Divider(height: 40),
                    _mainContent(context),
                  ],
                )
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // sidebar — fixed width on tablet, slightly wider on desktop
                      SizedBox(
                        width: isTablet ? 240 : 300,
                        child: _sidebar(context, isMobile: false),
                      ),
                      const VerticalDivider(),
                      // main content
                      Expanded(child: _mainContent(context)),
                    ],
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }

  // ── SIDEBAR ──
  Widget _sidebar(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SectionTitle(title: 'Contact'),
        const SizedBox(height: 10),
        socialButtons(title: '@',  desc: 'undang.markjonas29@gmail.com'),
        const SizedBox(height: 8),
        socialButtons(title: 'G',  desc: 'github.com/emjeypugee'),
        const SizedBox(height: 8),
        socialButtons(title: 'in', desc: 'linkedin.com/in/markjundang'),

        const SizedBox(height: 24),
        SectionTitle(title: 'Skills'),
        const SizedBox(height: 10),

        // skills wrap — wraps on narrow sidebar
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _skillBullet('Flutter'),
            _skillBullet('Dart'),
            _skillBullet('Auth'),
            _skillBullet('BloC'),
            _skillBullet('Github'),
            _skillBullet('REST API'),
            _skillBullet('Provider'),
            _skillBullet('Git'),
            _skillBullet('Firebase'),
            _skillBullet('SQL'),
            _skillBullet('Drift'),
          ],
        ),

        const SizedBox(height: 24),
        SectionTitle(title: 'Language'),
        const SizedBox(height: 10),
        _languageItem(language: 'Filipino', level: 5),
        const SizedBox(height: 8),
        _languageItem(language: 'English',  level: 3),

      ],
    );
  }

  // ── MAIN CONTENT ──
  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SectionTitle(title: 'Job Experience'),
        const SizedBox(height: 20),

        ExperienceItem(
          role: 'IT Intern',
          company: 'PGX Group Inc. · Internship',
          duration: 'FEB 2026 - Present',
          bullets: [
            'Collaborated with the mobile development team to build and design responsive UI components using Flutter.',
            'Integrated RESTful APIs to fetch and display dynamic data, ensuring a seamless user experience.',
            'Participated in daily stand-ups, code reviews, and utilized Git for version control to maintain a clean codebase.',
          ],
        ),

        ExperienceItem(
          role: 'Flutter Developer Intern',
          company: 'Peddlr Philippines, Inc. · Internship',
          duration: 'DEC 2025 - Present',
          bullets: [
            'Assisted in developing and optimizing core features for POS and inventory management systems.',
            'Implemented state management using BLoC to ensure a scalable, predictable, and maintainable application architecture.',
            'Resolved UI/UX bugs and improved app performance across multiple screen sizes for both Android and iOS devices.',
          ],
        ),

        ExperienceItem(
          role: 'IT Intern',
          company: 'KnowlesTI · Voluntary Internship',
          duration: 'JUNE 2024 - AUG 2024',
          bullets: [
            'Designed and customized website themes and page layouts using WordPress.',
            'Maintained smooth site operation by troubleshooting and resolving technical issues.',
          ],
        ),

        ExperienceItem(
          role: 'Service Crew',
          company: 'McDonalds · Part-Time',
          duration: 'AUG 2022 - DEC 2023',
          bullets: [
            'Collaborated with a 10+ person team in a high-volume environment to meet customer demand during peak hours.',
            'Mastered all front-of-house stations, demonstrating flexibility to support team goals during rushes or staffing shortages.',
          ],
        ),

      ],
    );
  }

  Widget socialButtons({required String title, required String desc}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      spacing: 10,
      children: [
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHigh,
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(title, style: const TextStyle(fontSize: 10)),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            overflow: TextOverflow.ellipsis, // 👈 prevents overflow on narrow screens
          ),
        ),
      ],
    );
  }

  Widget _skillBullet(String skill) {
    final colorScheme = Theme.of(context).colorScheme;
    return Text.rich(
      TextSpan(
        text: '• ',
        style: TextStyle(
          color: colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: skill,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _languageItem({required String language, required int level}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: TextStyle(fontSize: 13, color: colorScheme.onSurface)),
        Row(
          spacing: 5,
          children: List.generate(5, (i) {
            final filled = i < level;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: filled ? colorScheme.primary : colorScheme.surfaceContainerHigh,
                border: Border.all(
                  color: filled ? colorScheme.primary : colorScheme.outlineVariant,
                  width: 1.5,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}