import 'package:flutter/material.dart';
import 'package:personal_website/layout/file_explorer/file_explorer_full_screen.dart';
import 'package:personal_website/layout/file_explorer/file_explorer_small_screen.dart';
import 'package:personal_website/layout/taskbar/taskbar_fullscreen.dart';
import 'package:personal_website/layout/taskbar/taskbar_small_screen.dart';
import 'package:personal_website/screens/components/crt_container.dart';

class FileExplorerScreen extends StatelessWidget {
  const FileExplorerScreen({super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 700 && constraints.maxHeight > 550) {
        return const CrtContainer(
          child: Column(
            children: <Widget>[
              Expanded(child: Center(child: FileExplorerFullScreen())),
              TaskbarFullScreen(),
            ],
          ),
        );
      } else {
        return const Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(child: FileExplorerSmallScreen()),
              TaskbarSmallScreen(),
            ],
          ),
        );
      }
    },
  );
}
