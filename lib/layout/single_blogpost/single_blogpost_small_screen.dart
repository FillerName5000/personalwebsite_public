import 'package:flutter/material.dart';
import 'package:personal_website/layout/file_explorer/components/file_explorer_window_border.dart';
import 'package:personal_website/layout/generic/generic_window/window_border_painter.dart';
import 'package:personal_website/layout/single_blogpost/components/single_blogpost_text.dart';

class SingleBlogpostSmallScreen extends StatelessWidget {
  const SingleBlogpostSmallScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: WindowBorderPainter(),
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: SingleBlogpostContentSmallScreen(id: id),
    ),
  );
}

class SingleBlogpostContentSmallScreen extends StatelessWidget {
  const SingleBlogpostContentSmallScreen({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      Expanded(
        child: FileExplorerWindowBorder(
          child: SingleBlogpostText(id: id),
        ),
      ),
    ],
  );
}
