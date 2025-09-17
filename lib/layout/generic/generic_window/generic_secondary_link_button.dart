import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';

class GenericSecondaryLinkButton extends StatefulWidget {
  const GenericSecondaryLinkButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? color;

  @override
  State<GenericSecondaryLinkButton> createState() =>
      _GenericSecondaryLinkButtonState();
}

class _GenericSecondaryLinkButtonState
    extends State<GenericSecondaryLinkButton> {
  bool _hasBeenPressed = false;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
    child: TextButton(
      onPressed: () {
        setState(() => _hasBeenPressed = true);
        widget.onPressed();
      },
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 16,
          color: _hasBeenPressed
              ? clickedLinkColor
              : unclickedLinkColor,
        ),
      ),
    ),
  );
}
