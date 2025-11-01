import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/data/models/adv_of_code/adv_of_code_24_completion.dart';
import 'package:personal_website/layout/adv_of_code/adv_of_code_24_full_screen.dart';
import 'package:personal_website/layout/adv_of_code/adv_of_code_24_small_screen.dart';
import 'package:personal_website/providers/adv_of_code_24_provider.dart';
import 'package:personal_website/routing/pw_router.dart';
import 'package:provider/provider.dart';

const String advOfCode24TooltipMessage =
    'Advent of Code is an annual coding event. \n'
    'Each day of Advent unlocks two programming challenges, part two unlocking after completing part one. \n'
    'The color indicates whether a part has been completed, it is not yet completed, or I have not started it. \n'
    'These challenges are solved using C++, with the per-part solutions linked here.';

const String onHoldTooltipMessage =
    'After being unable to complete a part within a certain time limit, it has been put on hold. \n'
    'I will return to it later. ';

const String baseFileUrl =
    'https://github.com/FillerName5000/AdventOfCode2024cpp/tree/main/';

class AdvOfCode24Screen extends StatelessWidget {
  const AdvOfCode24Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdvOfCode24Provider provider = Provider.of<AdvOfCode24Provider>(
      context,
    );
    final List<AdvOfCode24Completion> completions =
        provider.completions ?? const <AdvOfCode24Completion>[];
    return Scaffold(
      backgroundColor: advOfCode2024BackgroundColor,
      body: SafeArea(
        child: DefaultTextStyle.merge(
          style: const TextStyle(
            fontFamily: 'SourceCodePro',
            fontWeight: FontWeight.w900,
          ),
          child: Stack(
            children: <Widget>[
              const HomeButton(),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 550) {
                      return AdvOfCode24SmallScreen(completions: completions);
                    }
                    return AdvOfCode24FullScreen(completions: completions);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButton extends StatefulWidget {
  const HomeButton({super.key});

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) => Positioned(
    top: 16,
    left: 16,
    child: GestureDetector(
      onTap: () async => context.push(routeHome),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Text(
          '< Home',
          style: TextStyle(
            color: advOfCode2024TextColor,
            fontSize: 16,
            decoration:
                _isHovering ? TextDecoration.underline : TextDecoration.none,
            decorationColor: advOfCode2024TextColor,
          ),
        ),
      ),
    ),
  );
}
