import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personal_website/layout/file_explorer/components/file_button.dart';
import 'package:personal_website/layout/file_explorer/components/file_button_small.dart';
import 'package:personal_website/providers/api_url_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

List<Object> _fixedUrlFileButtonData = <Object>[
  <String, Object>{
    "id": 2,
    "bigIconName": "linkedin_logo.png",
    "label": "LinkedIn Profile",
    "onPressedUrl": "https://www.linkedin.com/in/briek-goethals-322111208",
  },
  <String, Object>{
    "id": 3,
    "bigIconName": "github_logo.png",
    "label": "Github Profile",
    "onPressedUrl": "https://github.com/FillerName5000",
  },
];

List<Object> _apiDependantFileButtonData = <Object>[
  <String, Object>{
    "id": 4,
    "bigIconName": "pdf_icon.png",
    "label": "CV (NL)",
    "onPressedUrl": "/files/cv-nl",
  },
  <String, Object>{
    "id": 5,
    "bigIconName": "pdf_icon.png",
    "label": "CV (EN)",
    "onPressedUrl": "/files/cv-en",
  },
];

List<FileButton> baseFileButtons(BuildContext context) => <FileButton>[
  ..._fixedUrlFileButtonData.map((Object data) {
    final Map<String, Object> map = data as Map<String, Object>;
    return FileButton(
      id: map["id"]! as int,
      bigIconName: map["bigIconName"]! as String,
      label: map["label"]! as String,
      onPressed:
          () => unawaited(launchUrl(Uri.parse(map["onPressedUrl"]! as String))),
    );
  }),
  ..._apiDependantFileButtonData.map((Object data) {
    final Map<String, Object> map = data as Map<String, Object>;
    final String fullUrl =
        Provider.of<ApiTypeProvider>(context, listen: false).fullBaseUrl +
        (map["onPressedUrl"]! as String);
    return FileButton(
      id: map["id"]! as int,
      bigIconName: map["bigIconName"]! as String,
      label: map["label"]! as String,
      onPressed: () => unawaited(launchUrl(Uri.parse(fullUrl))),
    );
  }),
];

List<FileButtonSmall> baseFileButtonsSmall(
  BuildContext context,
) => <FileButtonSmall>[
  ..._fixedUrlFileButtonData.map((Object data) {
    final Map<String, Object> map = data as Map<String, Object>;
    return FileButtonSmall(
      id: map["id"]! as int,
      bigIconName: map["bigIconName"]! as String,
      label: map["label"]! as String,
      onPressed:
          () => unawaited(launchUrl(Uri.parse(map["onPressedUrl"]! as String))),
    );
  }),
  ..._apiDependantFileButtonData.map((Object data) {
    final Map<String, Object> map = data as Map<String, Object>;
    final String fullUrl =
        Provider.of<ApiTypeProvider>(context, listen: false).fullBaseUrl +
        (map["onPressedUrl"]! as String);
    return FileButtonSmall(
      id: map["id"]! as int,
      bigIconName: map["bigIconName"]! as String,
      label: map["label"]! as String,
      onPressed: () => unawaited(launchUrl(Uri.parse(fullUrl))),
    );
  }),
];
