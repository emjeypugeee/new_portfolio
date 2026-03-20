import 'package:flutter/material.dart';
import 'package:portfolio_v2/widgets/global_widgets/dash_title.dart';
import 'package:portfolio_v2/widgets/project_page_widgets/mobile_project_card.dart';
import 'package:portfolio_v2/widgets/project_page_widgets/project_card.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1024;

    final int webCols = isMobile ? 1 : 2;

    final int mobCols = isMobile ? 1 : isTablet ? 2 : 3;

    return SizedBox.expand(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 16 : 30),
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [

              DashTitle(title: 'MY WORK'),
              const SizedBox(height: 12),

              // ── header row ──
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
                            text: 'Simple ',
                            style: TextStyle(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(
                                text: 'Projects.',
                                style: TextStyle(color: colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Flutter apps, portfolio and other experiments.',
                          textAlign: isMobile ? TextAlign.start : TextAlign.center,
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Total', style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14)),
                      Text('5', style: TextStyle(color: colorScheme.primary, fontSize: isMobile ? 28 : 40, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),

              const Divider(),
              const SizedBox(height: 8),

              // ── WEB & DESKTOP ──
              DashTitle(title: 'WEB & DESKTOP'),
              const SizedBox(height: 16),
              _buildRows(
                cols: webCols,
                children: [
                  ProjectCard(
                    title: 'Portfolio',
                    description: 'My personal Portfolio built with Flutter.',
                    tags: ['Flutter', 'Web', 'Dart'],
                    imagePaths: [
                      'assets/images/portfolio.png',
                      'assets/images/portfolio_about.png',
                    ],
                    githubUrl: 'https://github.com/emjeypugeee/new_portfolio',
                  ),
                  ProjectCard(
                    title: 'TrackTasty Website',
                    description: 'A download website for our Capstone Project.',
                    tags: ['HTML', 'CSS', 'JS'],
                    imagePaths: [
                      'assets/images/tracktasty.png',
                      'assets/images/tracktasty2.png',
                    ],
                    githubUrl: 'https://github.com/emjeypugeee/TrackTasty-Website',
                  ),
                ],
              ),

              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 8),

              // ── MOBILE APPS ──
              DashTitle(title: 'MOBILE APPS'),
              const SizedBox(height: 16),
              _buildRows(
                cols: mobCols,
                children: [
                  MobileProjectCard(
                    title: 'Track-Fund',
                    description: 'A simple expense tracker built with Flutter and Drift Database. (Personal Project)',
                    tags: ['Flutter', 'Drift', 'BLoC'],
                    imagePaths: [
                      'assets/images/trackfund/tf_start.png',
                      'assets/images/trackfund/tf_login.png',
                      'assets/images/trackfund/tf_settingup.png',
                      'assets/images/trackfund/tf_add.png',
                      'assets/images/trackfund/tf_signup.png',
                      'assets/images/trackfund/tf_home.png',
                      'assets/images/trackfund/tf_analytics.png',
                      'assets/images/trackfund/tf_wallet.png',
                    ],
                    githubUrl: 'https://github.com/emjeypugeee/TrackFund-Flutter',
                  ),
                  MobileProjectCard(
                    title: 'My ChatBot',
                    description: 'A simple chatbot with minimal features but with dark mode. Powered by DeepSeek API.',
                    tags: ['Flutter', 'Firebase', 'Provider'],
                    imagePaths: [
                      'assets/images/chatbot/cb.png',
                      'assets/images/chatbot/cb_login.png',
                      'assets/images/chatbot/cb_singup.png',
                      'assets/images/chatbot/cb_cb.png',
                    ],
                    githubUrl: 'https://github.com/emjeypugeee/chatbot-flutter',
                  ),
                  MobileProjectCard(
                    title: 'TrackTasty',
                    description: 'A macro-tracking application with food database, chatbot for nutrition advice, and smart food scanning.',
                    tags: ['Flutter', 'Firebase', 'Provider'],
                    imagePaths: [
                      'assets/images/tracktasty/tt.jpg',
                      'assets/images/tracktasty/tt_db.jpg',
                      'assets/images/tracktasty/tt_food.jpg',
                      'assets/images/tracktasty/tt_chatbot.jpg',
                      'assets/images/tracktasty/tt_achieve.jpg',
                    ],
                    githubUrl: 'https://github.com/emjeypugeee/TrackTasty',
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// Splits [children] into rows of [cols] — no GridView, no ListView
  Widget _buildRows({required int cols, required List<Widget> children}) {
    final List<List<Widget>> rows = [];
    for (int i = 0; i < children.length; i += cols) {
      rows.add(children.sublist(i, (i + cols).clamp(0, children.length)));
    }

    return Column(
      children: rows.map((rowItems) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // actual cards
                ...rowItems.expand((w) sync* {
                  if (rowItems.indexOf(w) > 0) yield const SizedBox(width: 16);
                  yield Expanded(child: w);
                }),

                // fill empty slots in last row so cards don't stretch full width
                ...List.generate(cols - rowItems.length, (_) {
                  return const Expanded(child: SizedBox.shrink());
                }).expand((w) sync* {
                  yield const SizedBox(width: 16);
                  yield w;
                }),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}