import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_website/extensions/string_extensions.dart';
import 'package:personal_website/providers/adv_of_code_24_provider.dart';
import 'package:personal_website/screens/add_blogpost_screen.dart';
import 'package:personal_website/screens/adv_of_code_24.dart';
import 'package:personal_website/screens/empty_screen.dart';
import 'package:personal_website/screens/file_explorer_screen.dart';
import 'package:personal_website/screens/single_blogpost_screen.dart';
import 'package:provider/provider.dart';

const String routeHome = '/';
const String routeAdd = '/add';
const String routeBlogpost = '/blogpost/:title';
const String routeEmpty = '/empty';
const String routeAdvOfCode24 = '/adv-of-code/24';
const int longTransitionMs = 250;
const int shortTransitionMs = 100;

final GoRouter router = GoRouter(
  initialLocation: routeHome,
  routes: <RouteBase>[
    GoRoute(
      path: routeHome,
      pageBuilder:
          (BuildContext context, GoRouterState state) =>
              CustomTransitionPage<void>(
                child: const FileExplorerScreen(),
                transitionsBuilder:
                    (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) => FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(
                  milliseconds: longTransitionMs,
                ),
              ),
    ),
    GoRoute(
      path: routeAdd,
      builder:
          (BuildContext context, GoRouterState state) =>
              const AddBlogpostScreen(),
    ),
    GoRoute(
      path: routeBlogpost,
      pageBuilder: (BuildContext context, GoRouterState state) {
        final String? title = state.pathParameters['title']?.urlDecoded();
        if (title == null || title.isEmpty) {
          context.push(routeHome);
          return CustomTransitionPage<void>(
            child: const FileExplorerScreen(),
            transitionsBuilder:
                (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) => FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: shortTransitionMs),
          );
        }
        return CustomTransitionPage<void>(
          child: SingleBlogpostScreen(title: title),
          transitionsBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) => FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: shortTransitionMs),
        );
      },
    ),
    GoRoute(
      path: routeEmpty,
      pageBuilder:
          (BuildContext context, GoRouterState state) =>
              CustomTransitionPage<void>(
                child: const EmptyScreen(),
                transitionsBuilder:
                    (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) => FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(
                  milliseconds: shortTransitionMs,
                ),
              ),
    ),
    GoRoute(
      path: routeAdvOfCode24,
      pageBuilder:
          (BuildContext context, GoRouterState state) =>
              CustomTransitionPage<void>(
                child: Consumer<AdvOfCode24Provider>(
                  builder:
                      (
                        BuildContext context,
                        AdvOfCode24Provider provider,
                        Widget? child,
                      ) => const AdvOfCode24Screen(),
                ),
                transitionsBuilder:
                    (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) => FadeTransition(opacity: animation, child: child),
                transitionDuration: const Duration(
                  milliseconds: longTransitionMs,
                ),
              ),
    ),
  ],
);
