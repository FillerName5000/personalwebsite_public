import 'package:flutter/material.dart';
import 'package:personal_website/layout/file_explorer/components/file_explorer_small_primary_top_bar.dart';
import 'package:personal_website/layout/file_explorer/components/file_explorer_window_border.dart';
import 'package:personal_website/layout/generic/generic_window/window_border_painter.dart';
import 'package:personal_website/layout/single_blogpost/components/single_blogpost_text.dart';

class SingleBlogpostSmallScreen extends StatelessWidget {
  const SingleBlogpostSmallScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: WindowBorderPainter(),
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: SingleBlogpostContentSmallScreen(title: title),
    ),
  );
}

class SingleBlogpostContentSmallScreen extends StatelessWidget {
  const SingleBlogpostContentSmallScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      const FileExplorerSmallPrimaryTopBar(),
      Expanded(
        child: FileExplorerWindowBorder(
          child: SingleBlogpostText(title: title),
        ),
      ),
    ],
  );
}
