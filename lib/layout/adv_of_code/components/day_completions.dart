import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/data/models/adv_of_code/adv_of_code_24_completion.dart';
import 'package:url_launcher/url_launcher.dart';

const String _baseFileUrl =
    'https://github.com/FillerName5000/AdventOfCode2024cpp/blob/main/';

class DayCompletions extends StatelessWidget {
  const DayCompletions({super.key, required this.completion});

  final AdvOfCode24Completion completion;

  int get _dayNum => completion.entryIndex;

  @override
  Widget build(BuildContext context) {
    final Widget partOneWidget =
        completion.partOneCompletionStatus ==
                AdvOfCode24CompletionStatus.notCompleted
            ? _PartIndicator(
              status: completion.partOneCompletionStatus,
              isPartOne: true,
            )
            : _InteractablePartIndicator(
              filename: completion.partOneFilename,
              status: completion.partOneCompletionStatus,
              isPartOne: true,
            );

    final Widget partTwoWidget =
        completion.partTwoCompletionStatus ==
                AdvOfCode24CompletionStatus.notCompleted
            ? _PartIndicator(
              status: completion.partTwoCompletionStatus,
              isPartOne: false,
            )
            : _InteractablePartIndicator(
              filename: completion.partTwoFilename,
              status: completion.partTwoCompletionStatus,
              isPartOne: false,
            );

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              partOneWidget,
              const SizedBox(width: 12),
              partTwoWidget,
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Day $_dayNum',
            style: const TextStyle(color: advOfCode2024TextColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _InteractablePartIndicator extends StatelessWidget {
  const _InteractablePartIndicator({
    required this.filename,
    required this.status,
    required this.isPartOne,
  });

  final String filename;
  final AdvOfCode24CompletionStatus status;
  final bool isPartOne;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => launchUrl(Uri.parse('$_baseFileUrl$filename')),
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: _PartIndicator(status: status, isPartOne: isPartOne),
    ),
  );
}

class _PartIndicator extends StatelessWidget {
  const _PartIndicator({required this.status, required this.isPartOne});

  final AdvOfCode24CompletionStatus status;
  final bool isPartOne;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text(
        '*',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.normal,
          color: _colorForPart(status),
        ),
      ),
      Text(
        isPartOne ? '\u00B9' : '\u00B2',
        style: TextStyle(fontSize: 16, color: _colorForPart(status)),
      ),
    ],
  );
}

Color _colorForPart(AdvOfCode24CompletionStatus status) {
  switch (status) {
    case AdvOfCode24CompletionStatus.fullyCompleted:
      return advOfCode2024FullyCompleteColor;
    case AdvOfCode24CompletionStatus.onHold:
      return advOfCode2024OnHoldColor;
    case AdvOfCode24CompletionStatus.notCompleted:
      return advOfCode2024NotCompleteColor;
  }
}
