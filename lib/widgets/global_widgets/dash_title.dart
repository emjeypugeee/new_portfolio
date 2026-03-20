import 'package:flutter/material.dart';

class DashTitle extends StatelessWidget {
  final String title;
  const DashTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(width: 40, height: 3, color: colorScheme.primary),
        SizedBox(width: 12),
        Text(title, style: TextStyle(color: colorScheme.primary)),
      ],
    );
  }
}
