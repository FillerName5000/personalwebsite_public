import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/data/models/blogposts/blogpost_no_content.dart';
import 'package:personal_website/data/shared/file_button_list.dart';
import 'package:personal_website/extensions/string_extensions.dart';
import 'package:personal_website/layout/file_explorer/components/file_button.dart';
import 'package:personal_website/layout/generic/generic_buttons/non_depressed_button.dart';
import 'package:personal_website/layout/generic/generic_loading/loading_text.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:provider/provider.dart';

class FileButtonGridFullScreen extends StatefulWidget {
  const FileButtonGridFullScreen({super.key});

  @override
  State<FileButtonGridFullScreen> createState() =>
      _FileButtonGridFullScreenState();
}

class _FileButtonGridFullScreenState extends State<FileButtonGridFullScreen> {
  Future<List<BlogpostNoContent>?> blogpostsNoContentFuture =
      Future<List<BlogpostNoContent>?>.value(<BlogpostNoContent>[]);

  @override
  Widget build(BuildContext context) {
    final BlogpostProvider blogpostProvider = Provider.of<BlogpostProvider>(
      context,
      listen: false,
    );
    blogpostsNoContentFuture = blogpostProvider.fetchBlogpostsNoContent(
      context,
    );

    return FutureBuilder<List<BlogpostNoContent>?>(
      future: blogpostsNoContentFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<BlogpostNoContent>?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingText(additionalText: 'blog posts'));
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Something went wrong.'),
                const SizedBox(height: 16),
                IntrinsicWidth(
                  child: NonDepressedButton(
                    child: const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Image(
                              image: AssetImage('assets/icons/refresh.png'),
                              semanticLabel: 'Refresh button',
                              width: 26,
                            ),
                          ),
                          Text(
                            'Refresh',
                            style: TextStyle(
                              color: menuTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        blogpostsNoContentFuture = blogpostProvider
                            .fetchBlogpostsNoContent(context);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          final List<FileButton> fileButtons = getJoinedFileButtonLists(
            context,
            snapshot.data!,
          );
          return GridView.extent(
            maxCrossAxisExtent: 240,
            children: fileButtons,
          );
        }
      },
    );
  }

  List<FileButton> getJoinedFileButtonLists(
    BuildContext context,
    List<BlogpostNoContent> blogposts,
  ) {
    final List<String> blogpostsWithoutContent =
        blogposts.map((BlogpostNoContent e) => e.title).toList();
    final int lastBaseListIndex =
        baseFileButtons(context)[(baseFileButtons(context).length - 1)].id;

    final List<FileButton> blogpostFileButtons = List<FileButton>.generate(
      blogpostsWithoutContent.length,
      (int index) => FileButton(
        id: lastBaseListIndex + index + 1,
        bigIconName: 'blank_file_icon.png',
        label: blogpostsWithoutContent[index],
        onPressed:
            () => GoRouter.of(
              context,
            ).go('/blogpost/${blogposts[index].title.urlEncoded()}'),
      ),
    );

    return <FileButton>[...baseFileButtons(context), ...blogpostFileButtons];
  }
}
