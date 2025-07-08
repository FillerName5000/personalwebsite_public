import 'package:flutter/material.dart';
import 'package:personal_website/layout/file_explorer/components/file_button_grid_full_screen.dart';
import 'package:personal_website/layout/file_explorer/components/file_explorer_primary_top_bar.dart';
import 'package:personal_website/layout/file_explorer/components/file_explorer_window_border.dart';
import 'package:personal_website/layout/generic/generic_window/generic_secondary_top_bar.dart';
import 'package:personal_website/layout/generic/generic_window/window_border_painter.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:personal_website/providers/selected_file_button_provider.dart';
import 'package:provider/provider.dart';

class FileExplorerFullScreen extends StatelessWidget {
  const FileExplorerFullScreen({super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: WindowBorderPainter(),
    child: const Padding(
      padding: EdgeInsets.all(6),
      child: FileExplorerContentFullScreen(),
    ),
  );
}

class FileExplorerContentFullScreen extends StatelessWidget {
  const FileExplorerContentFullScreen({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      const FileExplorerPrimaryTopBar(),
      const GenericSecondaryTopBar(),
      Consumer<BlogpostProvider>(
        builder:
            (BuildContext context, BlogpostProvider blogpostProvider, _) =>
                Consumer<SelectedFileButtonProvider>(
                  builder:
                      (
                        BuildContext context,
                        SelectedFileButtonProvider fontProvider,
                        _,
                      ) => const Expanded(
                        child: FileExplorerWindowBorder(
                          child: Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: FileButtonGridFullScreen(),
                          ),
                        ),
                      ),
                ),
      ),
    ],
  );
}
