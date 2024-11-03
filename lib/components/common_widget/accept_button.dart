import 'package:flutter/widgets.dart';
import 'package:hub_of_talking/gen/assets.gen.dart';

// childをタップするとfocusを外す
class AcceptButton extends StatelessWidget {
  const AcceptButton({
    super.key,
    required this.label,
    required this.onPressed,
  });
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            child: Assets.images.buttonBg.image(),
          ),
          Align(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
