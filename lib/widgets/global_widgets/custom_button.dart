import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String title;
  final bool isActive;
  final Color? color;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.color,
    this.isActive = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? Theme.of(context).colorScheme.primary;
    final onBaseColor = Theme.of(context).colorScheme.onPrimary;

    Color backgroundColor;
    Color textColor;
    Color borderColor;

    if (widget.isActive) {
      backgroundColor = _isHovered ? baseColor.withValues(alpha: 0.1) : Colors.transparent;
      textColor = baseColor;
      borderColor = baseColor.withValues(alpha: _isHovered ? 1.0 : 0.6);
    } else {
      backgroundColor = _isHovered ? baseColor.withValues(alpha: 0.8) : baseColor;
      textColor = onBaseColor;
      borderColor = Colors.transparent;
    }
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() {
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: borderColor
            ),
          ),
          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                color: textColor,
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
