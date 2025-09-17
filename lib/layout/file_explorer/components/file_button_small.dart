import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/providers/selected_file_button_provider.dart';
import 'package:provider/provider.dart';

const String bigIconBasePath = 'assets/big_icons/';

class FileButtonSmall extends StatefulWidget {
  const FileButtonSmall({
    required this.id,
    required this.bigIconName,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final int id;
  final String bigIconName;
  final String label;
  final VoidCallback onPressed;

  @override
  State<FileButtonSmall> createState() => _FileButtonSmallState();
}

class _FileButtonSmallState extends State<FileButtonSmall> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final int? selectedButtonIndex =
        Provider.of<SelectedFileButtonProvider>(
          context,
          listen: true,
        ).selectedFileButtonIndex;
    isSelected = selectedButtonIndex == widget.id;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          isSelected
              ? widget.onPressed()
              : Provider.of<SelectedFileButtonProvider>(
                context,
                listen: false,
              ).setSelectedFileButtonIndex(widget.id);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ColoredBox(
                color:
                    isSelected ? selectedFileButtonColor : Colors.transparent,
                child: Image.asset(
                  bigIconBasePath + widget.bigIconName,
                  width: 35,
                  height: 35,
                ),
              ),
              const SizedBox(height: 6),
              Center(
                child: ColoredBox(
                  color:
                      isSelected ? selectedFileButtonColor : Colors.transparent,
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize:
                          (Theme.of(context).textTheme.bodySmall?.fontSize ??
                              10) *
                          0.8,
                      color: isSelected ? contrastTextColor : menuTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
