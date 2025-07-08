import 'package:personal_website/layout/file_explorer/components/file_button.dart';
import 'package:personal_website/layout/file_explorer/components/file_button_small.dart';
import 'package:url_launcher/url_launcher.dart';

const List<Object> _fileButtonData = <Object>[
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

final List<FileButton> baseFileButtons = _fileButtonData.map((Object data) {
  final Map<String, Object> map = data as Map<String, Object>;
  return FileButton(
    id: map["id"]! as int,
    bigIconName: map["bigIconName"]! as String,
    label: map["label"]! as String,
    onPressed: () => launchUrl(Uri.parse(map["onPressedUrl"]! as String)),
  );
}).toList();

final List<FileButtonSmall> baseFileButtonsSmall = _fileButtonData.map((Object data) {
  final Map<String, Object> map = data as Map<String, Object>;
  return FileButtonSmall(
    id: map["id"]! as int,
    bigIconName: map["bigIconName"]! as String,
    label: map["label"]! as String,
    onPressed: () => launchUrl(Uri.parse(map["onPressedUrl"]! as String)),
  );
}).toList();
