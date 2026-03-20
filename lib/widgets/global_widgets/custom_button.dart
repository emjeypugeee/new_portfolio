import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.isActive = false
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: isActive ? Colors.transparent : colorScheme.primary),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? colorScheme.onPrimary : colorScheme.primary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
