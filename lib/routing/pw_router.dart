import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/extensions/string_extensions.dart';
import 'package:personal_website/screens/add_blogpost_screen.dart';
import 'package:personal_website/screens/empty_screen.dart';
import 'package:personal_website/screens/file_explorer_screen.dart';
import 'package:personal_website/screens/single_blogpost_screen.dart';

const String routeHome = '/';
const String routeAdd = '/add';
const String routeBlogpost = '/blogpost/:title';
const String routeEmpty = '/empty';

final GoRouter router = GoRouter(
  initialLocation: routeHome,
  routes: <RouteBase>[
    GoRoute(
      path: routeHome,
      builder:
          (BuildContext context, GoRouterState state) =>
              const FileExplorerScreen(),
    ),
    GoRoute(
      path: routeAdd,
      builder:
          (BuildContext context, GoRouterState state) =>
              const AddBlogpostScreen(),
    ),
    GoRoute(
      path: routeBlogpost,
      builder: (BuildContext context, GoRouterState state) {
        final String? title = state.pathParameters['title']?.urlDecoded();
        if (title == null || title.isEmpty) {
          context.go(routeHome);
          return const FileExplorerScreen();
        }
        return SingleBlogpostScreen(title: title);
      },
    ),
    GoRoute(
      path: routeEmpty,
      builder:
          (BuildContext context, GoRouterState state) => const EmptyScreen(),
    ),
  ],
);
