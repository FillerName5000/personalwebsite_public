import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/screens/add_blogpost_screen.dart';
import 'package:personal_website/screens/file_explorer_screen.dart';
import 'package:personal_website/screens/single_blogpost_screen.dart';

const String routeHome = '/';
const String routeAdd = '/add';
const String routeBlogpost = '/blogpost/:id';

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
        final String? idStr = state.pathParameters['id'];
        final int? id = int.tryParse(idStr ?? 'noId');
        if (id == null) {
          if (kDebugMode) {
            print('Invalid blogpost ID: $idStr');
          }
          context.go(routeHome);
          return const FileExplorerScreen();
        }
        return SingleBlogpostScreen(id: id);
      },
    ),
  ],
);
