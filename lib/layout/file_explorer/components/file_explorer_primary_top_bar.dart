import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/generic/generic_window/window_buttons.dart';

class FileExplorerPrimaryTopBar extends StatelessWidget {
  const FileExplorerPrimaryTopBar({super.key});

  @override
  Widget build(BuildContext context) => Container(
    color: selectedWindowTopBarColor,
    padding: const EdgeInsets.only(left: 2, right: 1),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage('assets/icons/file_explorer_icon.png'),
                semanticLabel: 'File explorer Icon',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
              SizedBox(width: 5),
              Flexible(
                child: Text(
                  r"Exploring - C:\system32/root/admin\personal_website",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        WindowButtons(),
      ],
    ),
  );
}
