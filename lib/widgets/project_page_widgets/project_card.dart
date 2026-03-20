import 'package:flutter/material.dart';
import 'package:portfolio_v2/theme/app_theme.dart';
import 'package:portfolio_v2/widgets/global_widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final int? stars;
  final String? githubUrl;
  final String? playStoreUrl;
  final List<String> imagePaths;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePaths,
    this.stars,
    this.githubUrl,
    this.playStoreUrl,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── carousel thumbnail ──
          _buildCarousel(colorScheme),

          Container(height: 1, color: colorScheme.outlineVariant),

          // ── body ──
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: widget.tags
                      .map((t) => _tag(t, colorScheme))
                      .toList(),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 16),

                // Inside your _ProjectCardState build method...
                Row(
                  children: [
                    if (widget.githubUrl != null)
                      CustomButton(
                        title: 'GitHub →',
                        color: colorScheme.primary,
                        isActive: true, 
                        onTap: () => _launchURL(widget.githubUrl ?? ''),
                      ),
                    if (widget.playStoreUrl != null) ...[
                      const SizedBox(width: 10),
                      CustomButton(
                        title: 'Play Store ↗',
                        color: colorScheme.primary,
                        isActive: false, 
                        onTap: () {}, 
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(ColorScheme colorScheme) {
    final images = widget.imagePaths;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Stack(
          children: [
            // ── PageView ──
            images.isEmpty
                ? _placeholder()
                : PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemBuilder: (context, index) => Image.asset(
                      images[index],
                      fit: BoxFit.contain,
                      width: double.infinity,
                      alignment: Alignment.center,
                    ),
                  ),

            // ── dot indicators (bottom center) ──
            if (images.length > 1)
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (i) {
                    final isActive = i == _currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.brandYellow
                            : Colors.white.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),

            // ── left / right arrow buttons ──
            if (images.length > 1) ...[
              _arrowBtn(
                icon: Icons.chevron_left_rounded,
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                alignment: Alignment.centerLeft,
              ),
              _arrowBtn(
                icon: Icons.chevron_right_rounded,
                onTap: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                alignment: Alignment.centerRight,
              ),
            ],

            // ── image counter badge (top right) ──
            if (images.length > 1)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_currentPage + 1} / ${images.length}',
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _arrowBtn({
    required IconData icon,
    required VoidCallback onTap,
    required Alignment alignment,
  }) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppTheme.elevatedDark,
      child: Center(
        child: Text(
          '[ Preview ]',
          style: TextStyle(
            fontSize: 12,
            color: AppTheme.textGrey.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _tag(String label, ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppTheme.elevatedDark,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: cs.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
