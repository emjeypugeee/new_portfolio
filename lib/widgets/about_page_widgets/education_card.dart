import 'package:flutter/material.dart';

class EducationCard extends StatelessWidget {
  final String textIcon;
  final String title;
  final String place;
  final String year;
  const EducationCard({
    super.key,
    required this.textIcon,
    required this.title,
    required this.place,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 10,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                border: Border.all(color: colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text(textIcon, style: TextStyle(fontSize: 20))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,maxLines: 2,),
                  Text(
                    place,
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    year,
                    style: TextStyle(color: colorScheme.primary, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
