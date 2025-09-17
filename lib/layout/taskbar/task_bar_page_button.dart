import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/extensions/string_extensions.dart';
import 'package:personal_website/layout/generic/generic_buttons/non_depressed_button.dart';

const double taskBarNavButtonWidth = 160;

class TaskBarNavButton extends StatelessWidget {
  const TaskBarNavButton({super.key, this.id = -1, required this.title});

  final int id;
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(2),
    child: SizedBox(
      width: taskBarNavButtonWidth,
      child: NonDepressedButton(
        onPressed:
            () => GoRouter.of(context).go('/blogpost/$title'.urlEncoded()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: <Widget>[
              const Image(
                image: AssetImage('assets/icons/taskbar_folder_icon.png'),
                semanticLabel: 'Taskbar Folder Icon',
                width: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontSize: 14),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
