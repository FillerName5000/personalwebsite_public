import 'package:flutter/material.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/providers/selected_file_button_provider.dart';
import 'package:provider/provider.dart';

const String bigIconBasePath = 'assets/big_icons/';

class FileButton extends StatefulWidget {
  const FileButton({
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
  State<FileButton> createState() => _FileButtonState();
}

class _FileButtonState extends State<FileButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final int? selectedButtonIndex =
        Provider.of<SelectedFileButtonProvider>(
          context,
          listen: true,
        ).selectedFileButtonIndex;
    isSelected = selectedButtonIndex == widget.id;
    final double? baseFontSize = Theme.of(context).textTheme.bodyMedium?.fontSize;
    final double labelFontSize = baseFontSize != null ? baseFontSize - 2 : 14;

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
                  width: 46,
                  height: 46,
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ColoredBox(
                  color:
                      isSelected ? selectedFileButtonColor : Colors.transparent,
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: labelFontSize,
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
