import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/data/models/blogposts/blogpost_no_content.dart';
import 'package:personal_website/data/shared/file_button_list.dart';
import 'package:personal_website/layout/file_explorer/components/file_button_small.dart';
import 'package:personal_website/layout/generic/generic_loading/loading_text.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:provider/provider.dart';

class FileButtonGridSmallScreen extends StatefulWidget {
  const FileButtonGridSmallScreen({super.key});

  @override
  State<FileButtonGridSmallScreen> createState() =>
      _FileButtonGridSmallScreenState();
}

class _FileButtonGridSmallScreenState extends State<FileButtonGridSmallScreen> {
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
          final List<FileButtonSmall> fileButtons = getJoinedFileButtonLists(
            snapshot.data!,
          );
          return GridView.extent(
            maxCrossAxisExtent: 180,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: fileButtons,
          );
        }
      },
    );
  }

  List<FileButtonSmall> getJoinedFileButtonLists(List<BlogpostNoContent> blogposts) {
    final List<String> blogpostsWithoutContent =
        blogposts.map((BlogpostNoContent e) => e.title).toList();
    final int lastBaseListIndex =
        baseFileButtonsSmall[(baseFileButtons.length - 1)].id;

    final List<FileButtonSmall> blogpostFileButtons = List<FileButtonSmall>.generate(
      blogpostsWithoutContent.length,
      (int index) => FileButtonSmall(
        id: lastBaseListIndex + index + 1,
        bigIconName: 'blank_file_icon.png',
        label: blogpostsWithoutContent[index],
        onPressed:
            () => GoRouter.of(context).go('/blogpost/${blogposts[index].id}'),
      ),
    );

    return <FileButtonSmall>[...baseFileButtonsSmall, ...blogpostFileButtons];
  }
}
