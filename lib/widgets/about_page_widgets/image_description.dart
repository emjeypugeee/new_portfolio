import 'package:flutter/material.dart';
import 'package:portfolio_v2/widgets/global_widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageDescription extends StatelessWidget {
  const ImageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('Could not launch $url');
      }
    }

    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: SizedBox(
              height: 320,
              width: double.infinity,
              child: Image.asset(
                'assets/images/portfolio_profile.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(height: 1, color: colorScheme.outlineVariant),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Mark Jonas Undang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'App Developer · Flutter',
                  style: TextStyle(color: colorScheme.primary),
                ),
                Row(
                  spacing: 10,
                  children: [
                    socialButtons(
                      bgColor: colorScheme.surfaceContainerHigh,
                      borderColor: colorScheme.outlineVariant,
                      title: 'G',
                      textColor: colorScheme.onSurfaceVariant,
                      onTap: () => launchURL('https://github.com/emjeypugeee'),
                    ),
                    socialButtons(
                      bgColor: colorScheme.surfaceContainerHigh,
                      borderColor: colorScheme.outlineVariant,
                      title: 'IG',
                      textColor: colorScheme.onSurfaceVariant,
                      onTap: () =>launchURL('https://www.instagram.com/emjeyundang/'),
                    ),
                    socialButtons(
                      bgColor: colorScheme.surfaceContainerHigh,
                      borderColor: colorScheme.outlineVariant,
                      title: 'in',
                      textColor: colorScheme.onSurfaceVariant,
                      onTap: () => launchURL('https://www.linkedin.com/in/mark-jonas-undang-44636b216/'),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(title: 'Download CV ↓', isActive: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialButtons({
    required Color bgColor,
    required Color borderColor,
    required String title,
    required Color textColor,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(title, style: TextStyle(color: textColor)),
          ),
        ),
      ),
    );
  }
}
