import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      spacing: 20,
      children: [
        Text(title, style: TextStyle(color: colorScheme.primary, fontSize: 18)),
        Expanded(child: Container(height: 0.5, color: colorScheme.primary)),
      ],
    );
  }
}