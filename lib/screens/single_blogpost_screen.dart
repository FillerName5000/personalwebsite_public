import 'package:flutter/material.dart';
import 'package:personal_website/layout/single_blogpost/single_blogpost_full_screen.dart';
import 'package:personal_website/layout/single_blogpost/single_blogpost_small_screen.dart';
import 'package:personal_website/layout/taskbar/taskbar_fullscreen.dart';
import 'package:personal_website/layout/taskbar/taskbar_small_screen.dart';
import 'package:personal_website/screens/components/crt_container.dart';

class SingleBlogpostScreen extends StatelessWidget {
  const SingleBlogpostScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 700 && constraints.maxHeight > 550) {
        return CrtContainer(
          child: Column(
            children: <Widget>[
              Expanded(child: Center(child: SingleBlogpostFullScreen(id: id))),
              const TaskbarFullScreen(),
            ],
          ),
        );
      } else {
        return Scaffold(body: Column(
          children: <Widget>[
            Expanded(child: SingleBlogpostSmallScreen(id: id)),
            const TaskbarSmallScreen(),
          ],
        ));
      }
    },
  );
}
