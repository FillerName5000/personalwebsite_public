import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_website/constants/api_types.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/generic/generic_window/generic_secondary_link_button.dart';
import 'package:personal_website/providers/api_url_provider.dart';
import 'package:personal_website/providers/font_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

const Color _cSharpPurple = Color(0xFF5027d5);
const Color _javaRed = Color(0xFFE01D20);

class GenericSecondaryTopBar extends StatelessWidget {
  const GenericSecondaryTopBar({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: menuBackgroundColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GenericSecondaryLinkButton(
          onPressed: () {
            unawaited(
              launchUrl(Uri.parse("https://github.com/FillerName5000")),
            );
          },
          text: 'Files',
        ),
        GenericSecondaryLinkButton(
          onPressed: () {
            Provider.of<FontProvider>(
              context,
              listen: false,
            ).changeFontFamily();
          },
          text: 'Font',
        ),
        Consumer<ApiTypeProvider>(
          builder:
              (BuildContext context, ApiTypeProvider apiTypeProvider, _) =>
                  const ApiButtons(),
        ),
      ],
    ),
  );
}

class ApiButtons extends StatelessWidget {
  const ApiButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiType apiType = Provider.of<ApiTypeProvider>(context).apiType;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ColoredSecondaryLinkButton(
          text: 'C#/.NET API',
          onPressed:
              () =>
                  Provider.of<ApiTypeProvider>(context, listen: false).apiType =
                      ApiType.dotnet,
          isActiveColor:
              apiType == ApiType.dotnet ? _cSharpPurple : Colors.grey,
          isUserApi: apiType == ApiType.dotnet,
          apiType: ApiType.dotnet,
        ),
        ColoredSecondaryLinkButton(
          text: 'Java API',
          onPressed:
              () =>
                  Provider.of<ApiTypeProvider>(context, listen: false).apiType =
                      ApiType.java,
          isActiveColor: apiType == ApiType.java ? _javaRed : Colors.grey,
          isUserApi: apiType == ApiType.java,
          apiType: ApiType.java,
        ),
      ],
    );
  }
}

class ColoredSecondaryLinkButton extends StatefulWidget {
  const ColoredSecondaryLinkButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActiveColor,
    this.isUserApi = false,
    this.apiType,
  });

  final String text;
  final VoidCallback onPressed;
  final Color? isActiveColor;
  final bool isUserApi;
  final ApiType? apiType;

  @override
  State<ColoredSecondaryLinkButton> createState() =>
      _ColoredSecondaryLinkButtonState();
}

class _ColoredSecondaryLinkButtonState extends State<ColoredSecondaryLinkButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  Color? _prevColor;
  bool _showUnderline = false;

  @override
  void initState() {
    super.initState();
    _prevColor = widget.isActiveColor ?? Colors.grey;
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _colorAnimation = ColorTween(
      begin: _prevColor,
      end: widget.isActiveColor ?? Colors.grey,
    ).animate(_controller);
    _controller.value = 1.0;
    _showUnderline = widget.isUserApi;
  }

  @override
  void didUpdateWidget(covariant ColoredSecondaryLinkButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActiveColor != oldWidget.isActiveColor) {
      _colorAnimation = ColorTween(
        begin: oldWidget.isActiveColor ?? Colors.grey,
        end: widget.isActiveColor ?? Colors.grey,
      ).animate(_controller);
      _controller.reset();
      _showUnderline = false;
      _controller.forward().then((_) {
        if (mounted && widget.isUserApi) {
          setState(() {
            _showUnderline = true;
          });
        }
      });
      _prevColor = widget.isActiveColor ?? Colors.grey;
    } else {
      _showUnderline = widget.isUserApi;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Flexible(
    child: AnimatedBuilder(
      animation: _colorAnimation,
      builder:
          (BuildContext context, Widget? child) => TextButton(
            onPressed: () {
              if (widget.isUserApi && widget.apiType != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'The ${widget.apiType!.toStr()} API is currently active',
                    ),
                    duration: const Duration(milliseconds: 1800),
                  ),
                );
              } else {
                widget.onPressed();
              }
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              widget.text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: _colorAnimation.value,
                decoration:
                    _showUnderline
                        ? TextDecoration.underline
                        : TextDecoration.none,
              ),
            ),
          ),
    ),
  );
}
