import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/layout/generic/generic_popups/default_snackbar.dart';
import 'package:personal_website/layout/generic/generic_window/generic_secondary_link_button.dart';
import 'package:personal_website/providers/font_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

SnackBar editSnackBar = DefaultSnackbar('Use Inspect Element to edit');
SnackBar helpSnackBar = DefaultSnackbar('Press the Home Button on the taskbar to return to the home page');

class GenericSecondaryTopBar extends StatelessWidget {
  const GenericSecondaryTopBar({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: menuBackgroundColor,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GenericSecondaryLinkButton(
          onPressed: () {
            unawaited(launchUrl(Uri.parse("https://github.com/FillerName5000"))); //TODO add a new file button every time
          },
          text: 'Files',
        ),
        GenericSecondaryLinkButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(editSnackBar);
          },
          text: 'Edit',
        ),
        GenericSecondaryLinkButton(
          onPressed: () {
            Provider.of<FontProvider>(
              context,
              listen: false,
            ).changeFontFamily();
          },
          text: 'Font',
        ),
        GenericSecondaryLinkButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(helpSnackBar);
          },
          text: 'Help',
        ),
      ],
    ),
  );
}
