import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/data/models/adv_of_code/adv_of_code_24_completion.dart';
import 'package:personal_website/layout/adv_of_code/components/day_completions.dart';
import 'package:personal_website/screens/adv_of_code_24.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvOfCode24FullScreen extends StatelessWidget {
  const AdvOfCode24FullScreen({required this.completions, super.key});

  final List<AdvOfCode24Completion> completions;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    children: <Widget>[
      const _TitleText(),
      const SizedBox(height: 8),
      const _ExplanationTexts(),
      const SizedBox(height: 8),
      GridView.extent(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        maxCrossAxisExtent: 390,
        childAspectRatio: 2.6,
        children:
            completions
                .map(
                  (AdvOfCode24Completion completion) =>
                      DayCompletions(completion: completion),
                )
                .toList(),
      ),
    ],
  );
}

class _ExplanationTexts extends StatelessWidget {
  const _ExplanationTexts();

  @override
  Widget build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        '*Fully Completed',
        style: TextStyle(color: advOfCode2024FullyCompleteColor, fontSize: 12),
      ),
      SizedBox(width: 25),
      Text(
        '*On Hold',
        style: TextStyle(color: advOfCode2024OnHoldColor, fontSize: 12),
      ),
      SizedBox(width: 5),
      Tooltip(
        textStyle: TextStyle(fontFamily: 'SourceCodePro', color: Colors.white),
        decoration: BoxDecoration(color: Color(0xFF707070)),
        message: onHoldTooltipMessage,
        preferBelow: false,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: advOfCode2024BackgroundColor,
            child: Icon(
              Icons.info_outline,
              size: 12,
              color: advOfCode2024OnHoldColor,
            ),
          ),
        ),
      ),
      SizedBox(width: 25),
      Text(
        '*Not Started',
        style: TextStyle(color: advOfCode2024NotCompleteColor, fontSize: 12),
      ),
    ],
  );
}

class _TitleText extends StatefulWidget {
  const _TitleText();

  @override
  State<_TitleText> createState() => _TitleTextState();
}

class _TitleTextState extends State<_TitleText> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      GestureDetector(
        onTap:
            () => unawaited(
              launchUrl(Uri.parse('https://adventofcode.com/2024/about')),
            ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: Text(
            'Advent Of Code 24:',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              decoration:
                  _isHovering ? TextDecoration.underline : TextDecoration.none,
              decorationColor: Colors.blue,
            ),
          ),
        ),
      ),
      const Text(
        ' Completed Challenges',
        style: TextStyle(color: advOfCode2024TextColor, fontSize: 16),
      ),
      const SizedBox(width: 8),
      const Tooltip(
        textStyle: TextStyle(fontFamily: 'SourceCodePro', color: Colors.white),
        decoration: BoxDecoration(color: Color(0xFF707070)),
        message: advOfCode24TooltipMessage,
        preferBelow: false,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: advOfCode2024BackgroundColor,
            child: Icon(Icons.info_outline, size: 16, color: Colors.blue),
          ),
        ),
      ),
    ],
  );
}
