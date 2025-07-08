import 'package:flutter/material.dart';
import 'package:personal_website/data/models/blogposts/blogpost_no_content.dart';
import 'package:personal_website/layout/generic/generic_buttons/non_depressed_button.dart';
import 'package:personal_website/layout/generic/generic_loading/loading_text.dart';
import 'package:personal_website/layout/taskbar/task_bar_page_button.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:provider/provider.dart';

int _maxVisibleButtons = 0;
final NonDepressedButton isLoadingButton = NonDepressedButton(
  child: const LoadingText(additionalText: "blog posts"),
  onPressed: () {},
);

class TaskBarPages extends StatefulWidget {
  const TaskBarPages({super.key});

  @override
  State<TaskBarPages> createState() => _TaskBarPagesState();
}

class _TaskBarPagesState extends State<TaskBarPages> {
  int startIndex = 0;

  void _onPressRight(List<BlogpostNoContent> blogpostsNoContent) {
    setState(() {
      startIndex = (startIndex + 1) % blogpostsNoContent.length;
      if (startIndex + _maxVisibleButtons > blogpostsNoContent.length) {
        startIndex = 0;
      }
    });
  }

  void _onPressLeft(List<BlogpostNoContent> blogpostsNoContent) {
    setState(() {
      startIndex = (startIndex - 1) % blogpostsNoContent.length;
      if (startIndex < 0) {
        startIndex = blogpostsNoContent.length - _maxVisibleButtons;
        if (startIndex < 0) {
          startIndex = 0;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BlogpostNoContent>? blogpostsNoContent =
        Provider.of<BlogpostProvider>(context).blogpostsNoContent;
    if (blogpostsNoContent == null) {
      return Expanded(child: isLoadingButton);
    } else {
      return Expanded(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Image(
                image: AssetImage('assets/icons/scrollbar_arrow_left.png'),
                semanticLabel: 'Scroll left button',
              ),
              onPressed: () => _onPressLeft(blogpostsNoContent),
              constraints: const BoxConstraints(),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  _maxVisibleButtons =
                      ((constraints.maxWidth - 50) / taskBarNavButtonWidth)
                          .floor();
                  _maxVisibleButtons = _maxVisibleButtons.clamp(
                    0,
                    blogpostsNoContent.length,
                  );

                  final List<BlogpostNoContent> visible = <BlogpostNoContent>[];
                  final int endLoop = startIndex + _maxVisibleButtons;

                  for (int i = startIndex; i < endLoop; i++) {
                    final int idx = i % blogpostsNoContent.length;
                    visible.add(blogpostsNoContent[idx]);
                  }

                  return Row(
                    children:
                        visible
                            .map(
                              (BlogpostNoContent blogpost) => TaskBarNavButton(
                                title: blogpost.title,
                                id: blogpost.id,
                              ),
                            )
                            .toList(),
                  );
                },
              ),
            ),
            IconButton(
              icon: const Image(
                image: AssetImage('assets/icons/scrollbar_arrow_right.png'),
                semanticLabel: 'Scroll right button',
              ),
              onPressed: () => _onPressRight(blogpostsNoContent),
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      );
    }
  }
}

class TaskBarNavButtons extends StatelessWidget {
  const TaskBarNavButtons({
    super.key,
    required this.blogpostsNoContent,
    required this.startIndex,
  });

  final List<BlogpostNoContent>? blogpostsNoContent;
  final int startIndex;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (blogpostsNoContent == null) {
        return isLoadingButton;
      }

      _maxVisibleButtons =
          ((constraints.maxWidth - 50) / taskBarNavButtonWidth).floor();
      _maxVisibleButtons = _maxVisibleButtons.clamp(
        0,
        blogpostsNoContent!.length,
      );

      final List<BlogpostNoContent> visible = <BlogpostNoContent>[];
      final int endLoop = startIndex + _maxVisibleButtons;

      for (int i = startIndex; i < endLoop; i++) {
        final int idx = i % blogpostsNoContent!.length;
        visible.add(blogpostsNoContent![idx]);
      }

      return Row(
        children:
            visible
                .map(
                  (BlogpostNoContent blogpost) =>
                      TaskBarNavButton(title: blogpost.title, id: blogpost.id),
                )
                .toList(),
      );
    },
  );
}
