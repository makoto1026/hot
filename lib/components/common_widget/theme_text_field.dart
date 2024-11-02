import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hub_of_talking/theme/color_theme.dart';

class ThemeTextField extends HookConsumerWidget {
  const ThemeTextField({
    super.key,
    this.label,
    this.hintText,
    this.keyboardType,
    required this.onChanged,
    this.maxLength,
    this.validator,
    this.showCounter = false,
    this.focusNode,
    this.autofocus = false,
    this.enabled = true,
    this.controller,
  });
  final String? label;
  final String? hintText;
  final bool autofocus;
  final int? maxLength;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool showCounter;
  final FocusNode? focusNode;
  final bool enabled;
  final TextEditingController? controller;

  InputBorder errorBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }

  InputBorder focusedBorder(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  InputBorder border(BuildContext context) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: Theme.of(context).focusColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = useState<String?>(null);

    bool hasError() {
      return errorText.value != null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          focusNode: focusNode,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyLarge,
          validator: (value) {
            final text = validator?.call(value);

            errorText.value = text;
            if (text == '') {
              return null;
            }
            return text;
          },
          keyboardType: keyboardType,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintStyle: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: ColorTheme.placeHolder),
            enabledBorder: hasError() ? errorBorder(context) : border(context),
            focusedBorder:
                hasError() ? errorBorder(context) : focusedBorder(context),
            errorStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.error),
            counter: !showCounter ? const SizedBox.shrink() : null,
            hintText: hintText,
            disabledBorder: enabled ? const UnderlineInputBorder() : null,
          ),
          enabled: enabled,
        ),
      ],
    );
  }
}
