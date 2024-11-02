import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

class CorneredSquareButton extends HookConsumerWidget {
  const CorneredSquareButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 56,
    this.backgroundColor,
    this.gradientColor,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final double size;
  final Color? backgroundColor;
  final List<Color>? gradientColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        gradient: gradientColor != null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.3, 1],
                colors: gradientColor!,
              )
            : null,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 4,
            color: const Color(0xff000000).withOpacity(0.2),
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 32,
            maxHeight: 32,
          ),
          child: icon,
        ),
      ),
    );
  }
}

class CorneredSquareButtonStyle {
  const CorneredSquareButtonStyle({
    this.backgroundColor = Colors.white,
    this.textColor = ColorTheme.black,
  });
  CorneredSquareButtonStyle.primary()
      : this(
          backgroundColor: ColorTheme.primary,
          textColor: Colors.white,
        );
  final Color backgroundColor;
  final Color textColor;
}

class OutlineButtonStyle extends CorneredSquareButtonStyle {
  const OutlineButtonStyle({
    super.backgroundColor,
    this.borderColor = ColorTheme.placeHolder,
  });
  OutlineButtonStyle.primary()
      : this(
          borderColor: ColorTheme.primary,
        );

  final Color borderColor;
}
