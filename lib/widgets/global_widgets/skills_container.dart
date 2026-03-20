import 'package:flutter/material.dart';

class SkillsContainer extends StatelessWidget {
  final String title;
  const SkillsContainer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: colorScheme.primary), 
      ),
      child: Text(title, style: TextStyle(color: colorScheme.primary, letterSpacing: 0.8)),
    );
  }
}