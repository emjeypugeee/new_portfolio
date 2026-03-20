import 'package:flutter/material.dart';

class HoverableSocialButton extends StatefulWidget {
  final String title;
  final String desc;
  final void Function()? onTap;

  const HoverableSocialButton({
    super.key,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  State<HoverableSocialButton> createState() => _HoverableSocialButtonState();
}

class _HoverableSocialButtonState extends State<HoverableSocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final bool isClickable = widget.onTap != null;
    final baseTextStyle = theme.textTheme.bodyMedium ?? const TextStyle();
    return MouseRegion(
      cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            // Animated Icon Box
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                // Change background color on hover
                color: _isHovered && isClickable
                    ? colorScheme.primaryContainer
                    : colorScheme.surfaceContainerHigh,
                // Highlight border on hover
                border: Border.all(
                  color: _isHovered && isClickable
                      ? colorScheme.primary
                      : colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: baseTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: _isHovered && isClickable
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _isHovered && isClickable
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: _isHovered ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: baseTextStyle.copyWith(
                  fontSize: 14,
                  color: _isHovered && isClickable
                      ? colorScheme.primary
                      : colorScheme.onSurface,
                  decoration: _isHovered && isClickable
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
                child: Text(widget.desc, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
