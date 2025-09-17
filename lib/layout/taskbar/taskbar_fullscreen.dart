import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/taskbar/task_bar_pages.dart';
import 'package:personal_website/layout/taskbar/taskbar_start_button.dart';
import 'package:personal_website/layout/taskbar/taskbar_time_indicator.dart';
import 'package:personal_website/providers/api_url_provider.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:provider/provider.dart';

class TaskbarFullScreen extends StatelessWidget {
  const TaskbarFullScreen({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 40,
    decoration: const BoxDecoration(
      color: menuBackgroundColor,
      border: Border(
        top: BorderSide(color: defaultButtonLightBorderColor, width: 1.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        const TaskBarStartButton(),
        Consumer<ApiTypeProvider>(
          builder:
              (BuildContext context, ApiTypeProvider apiTypeProvider, _) =>
                  Consumer<BlogpostProvider>(
                    builder:
                        (
                          BuildContext context,
                          BlogpostProvider blogPostProvider,
                          _,
                        ) => const TaskBarPages(),
                  ),
        ),
        const TaskBarTimeIndicator(),
      ],
    ),
  );
}
