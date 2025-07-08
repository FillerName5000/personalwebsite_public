import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/generic/generic_buttons/depressed_button.dart';
import 'package:personal_website/providers/second_looping_provider.dart';
import 'package:provider/provider.dart';

class TaskBarTimeIndicator extends StatefulWidget {
  const TaskBarTimeIndicator({super.key});

  @override
  State<TaskBarTimeIndicator> createState() => _TaskBarTimeIndicatorState();
}

class _TaskBarTimeIndicatorState extends State<TaskBarTimeIndicator> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(3),
    child: DepressedButton(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 8),
        child: Row(
          children: <Widget>[
            const Image(
              image: AssetImage('assets/icons/flutter_logo.png'),
              semanticLabel: 'Flutter logo',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.none,
            ),
            const SizedBox(width: 8),
            const Image(
              image: AssetImage('assets/icons/csharp_logo.png'),
              semanticLabel: 'C Sharp logo',
              width: 20,
              height: 20,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.none,
            ),
            const SizedBox(width: 8),
            Consumer<SecondLoopingProvider>(
              builder:
                  (BuildContext context, SecondLoopingProvider provider, _) =>
                      Text(
                        DateFormat('h:mm a').format(provider.currentTime),
                        style: const TextStyle(
                          color: menuTextColor,
                          fontSize: 18,
                        ),
                      ),
            ),
          ],
        ),
      ),
    ),
  );
}
