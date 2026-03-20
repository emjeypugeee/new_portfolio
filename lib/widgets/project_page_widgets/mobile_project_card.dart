import 'package:flutter/material.dart';
import 'package:portfolio_v2/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final List<String> tags;
  final String? githubUrl;
  final String? playStoreUrl;
  final List<String> imagePaths;

  const MobileProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tags,
    required this.imagePaths,
    this.githubUrl,
    this.playStoreUrl,
  });

  @override
  State<MobileProjectCard> createState() => _MobileProjectCardState();
}

class _MobileProjectCardState extends State<MobileProjectCard> {
  final PageController _pageController = PageController(
    viewportFraction: 0.62, // 👈 shows peek of next/prev screenshot
  );
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
          // ── header ──
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // tags
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: widget.tags
                      .map((t) => _tag(t, colorScheme))
                      .toList(),
                ),
                const SizedBox(height: 10),

                // title + star badge row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // description
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 14),

                // buttons
                Row(
                  children: [
                    if (widget.playStoreUrl != null)
                      _fillBtn(
                        label: 'Play Store ↗',
                        colorScheme: colorScheme,
                        onTap: () {},
                      ),
                    if (widget.githubUrl != null) ...[
                      const SizedBox(width: 10),
                      _outlineBtn(
                        label: 'GitHub →',
                        color: colorScheme.primary,
                        onTap: () => _launchURL(widget.githubUrl ?? ''),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          Container(height: 1, color: colorScheme.outlineVariant),

          // ── portrait screenshot carousel ──
          _buildPortraitCarousel(colorScheme),
        ],
      ),
    );
  }

  Widget _buildPortraitCarousel(ColorScheme colorScheme) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(11)),
      child: Container(
        color: AppTheme.bgDark,
        padding: const EdgeInsets.only(top: 20, bottom: 16),
        child: Column(
          children: [
            // screenshots row
            SizedBox(
              height: 500,
              child: widget.imagePaths.isEmpty
                  ? _placeholder()
                  : PageView.builder(
                      controller: _pageController,
                      itemCount: widget.imagePaths.length,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (context, index) {
                        final isActive = index == _currentPage;
                        return AnimatedScale(
                          scale: isActive
                              ? 1.0
                              : 0.88, // 👈 inactive screenshots shrink
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // 👈 phone-like corners
                              child: Image.asset(widget.imagePaths[index]),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const SizedBox(height: 14),

            // dot indicators
            if (widget.imagePaths.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.imagePaths.length, (i) {
                  final isActive = i == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: isActive ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppTheme.brandYellow
                          : Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Center(
      child: Text(
        '[ No Screenshots ]',
        style: TextStyle(
          fontSize: 12,
          color: AppTheme.textGrey.withValues(alpha: 0.4),
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

  Widget _fillBtn({
    required String label,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }

  Widget _outlineBtn({
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.6)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
