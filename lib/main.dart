import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:personal_website/constants/colors.dart';
import 'package:personal_website/providers/adv_of_code_24_provider.dart';
import 'package:personal_website/providers/api_url_provider.dart';
import 'package:personal_website/providers/blogpost_provider.dart';
import 'package:personal_website/providers/font_provider.dart';
import 'package:personal_website/providers/second_looping_provider.dart';
import 'package:personal_website/providers/selected_file_button_provider.dart';
import 'package:personal_website/routing/pw_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(const PersonalWebsiteApp());
  SemanticsBinding.instance.ensureSemantics();
}

class PersonalWebsiteApp extends StatelessWidget {
  const PersonalWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: <SingleChildWidget>[
      ChangeNotifierProvider<SecondLoopingProvider>(
        create: (BuildContext context) => SecondLoopingProvider(),
      ),
      ChangeNotifierProvider<FontProvider>(
        create: (BuildContext context) => FontProvider(),
      ),
      ChangeNotifierProvider<SelectedFileButtonProvider>(
        create: (BuildContext context) => SelectedFileButtonProvider(),
      ),
      ChangeNotifierProvider<ApiTypeProvider>(
        create: (BuildContext context) => ApiTypeProvider(),
      ),
      ChangeNotifierProvider<BlogpostProvider>(
        create: (BuildContext context) => BlogpostProvider(),
      ),
      ChangeNotifierProvider<AdvOfCode24Provider>(
        create: (BuildContext context) {
          final AdvOfCode24Provider provider = AdvOfCode24Provider();
          unawaited(provider.fetchAdvOfCode24Completions(context));
          return provider;
        },
      ),
    ],
    child: Consumer<FontProvider>(
      builder:
          (BuildContext context, FontProvider fontProvider, _) =>
              MaterialApp.router(
                title: "Briek Goethals' Portfolio",
                routerConfig: router,
                theme: ThemeData(
                  brightness: Brightness.light,
                  fontFamily: fontProvider.fontFamily,
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: highLightedMenuItemColor,
                  ),
                  useMaterial3: true,
                  textTheme: const TextTheme(
                    bodyMedium: TextStyle(fontSize: 18),
                  ),
                ),
              ),
    ),
  );
}
