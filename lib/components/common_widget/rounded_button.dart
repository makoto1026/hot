import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

class RoundedButton extends HookConsumerWidget {
  const RoundedButton({
    super.key,
    required this.text,
    this.caption,
    required this.onPressed,
    this.enabled = true,
    this.style = const RoundedButtonStyle(),
    this.prefixIcon,
  });

  final String text;
  final String? caption;
  final VoidCallback onPressed;
  final RoundedButtonStyle? style;
  final bool enabled;
  final Widget? prefixIcon;

  double get height {
    if (style is OutlineButtonStyle || style is GradientOutlinedButtonStyle) {
      return 52;
    }
    return 56;
  }

  BorderSide? get borderSide {
    if (style is OutlineButtonStyle) {
      return BorderSide(
        color: (style! as OutlineButtonStyle).borderColor ??
            ColorTheme.placeHolder,
        width: 3,
      );
    }
    return null;
  }

  Color? get backgroundColor {
    return style?.backgroundColor?.withOpacity(enabled ? 1 : 0);
  }

  TextStyle? textStyle(BuildContext context) {
    return Theme.of(context).textTheme.displaySmall?.copyWith(
          color: style?.textColor,
        );
  }

  TextStyle? captionStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall?.copyWith(
          color: style?.captionColor,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: enabled ? onPressed : null,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: style is GradientOutlinedButtonStyle?
                  ? LinearGradient(
                      begin: const Alignment(-0.8, -1),
                      end: const Alignment(0.8, 0.8),
                      stops: const [0.3, 1],
                      colors: (style! as GradientOutlinedButtonStyle).colors,
                    )
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      if (prefixIcon != null) prefixIcon!,
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              text,
                              style: textStyle(context),
                              textAlign: TextAlign.center,
                            ),
                            if (caption != null)
                              Text(
                                caption!,
                                style: captionStyle(context),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonStyle {
  const RoundedButtonStyle({
    this.backgroundColor = Colors.white,
    this.textColor = ColorTheme.black,
    this.captionColor = ColorTheme.paleGray,
  });

  RoundedButtonStyle.primary()
      : captionColor = ColorTheme.paleGray,
        backgroundColor = ColorTheme.primary,
        textColor = Colors.white;

  final Color? backgroundColor;
  final Color? textColor;
  final Color? captionColor;
}

class OutlineButtonStyle extends RoundedButtonStyle {
  const OutlineButtonStyle({
    this.borderColor = ColorTheme.placeHolder,
  }) : super();

  OutlineButtonStyle.primary() : borderColor = ColorTheme.primary;

  final Color? borderColor;
}

class GradientOutlinedButtonStyle extends RoundedButtonStyle {
  const GradientOutlinedButtonStyle({
    this.colors = const [],
  }) : super();

  final List<Color> colors;
}
