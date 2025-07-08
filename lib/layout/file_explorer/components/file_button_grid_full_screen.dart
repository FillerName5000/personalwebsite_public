import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/data/models/blogposts/blogpost_no_content.dart';
import 'package:personal_website/data/shared/file_button_list.dart';
import 'package:personal_website/layout/file_explorer/components/file_button.dart';
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
  Future<List<BlogpostNoContent>> blogpostsNoContentFuture =
      Future<List<BlogpostNoContent>>.value(<BlogpostNoContent>[]);

  @override
  Widget build(BuildContext context) {
    final BlogpostProvider blogpostProvider = Provider.of<BlogpostProvider>(
      context,
      listen: false,
    );
    blogpostsNoContentFuture = blogpostProvider.fetchBlogpostsNoContent();

    return FutureBuilder<List<BlogpostNoContent>>(
      future: blogpostsNoContentFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<BlogpostNoContent>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LoadingText(additionalText: 'blog posts'));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data'));
        } else {
          final List<FileButton> fileButtons = getJoinedFileButtonLists(
            snapshot.data!,
          );
          return GridView.extent(
            maxCrossAxisExtent: 210,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: fileButtons,
          );
        }
      },
    );
  }

  List<FileButton> getJoinedFileButtonLists(List<BlogpostNoContent> blogposts) {
    final List<String> blogpostsWithoutContent =
        blogposts.map((BlogpostNoContent e) => e.title).toList();
    final int lastBaseListIndex =
        baseFileButtons[(baseFileButtons.length - 1)].id;

    final List<FileButton> blogpostFileButtons = List<FileButton>.generate(
      blogpostsWithoutContent.length,
      (int index) => FileButton(
        id: lastBaseListIndex + index + 1,
        bigIconName: 'blank_file_icon.png',
        label: blogpostsWithoutContent[index],
        onPressed:
            () => GoRouter.of(context).go('/blogpost/${blogposts[index].id}'),
      ),
    );

    return <FileButton>[...baseFileButtons, ...blogpostFileButtons];
  }
}
