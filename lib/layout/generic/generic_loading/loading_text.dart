import 'package:flutter/material.dart';

class LoadingText extends StatelessWidget {
  const LoadingText({super.key, required this.additionalText});
  final String additionalText;

  @override
  Widget build(BuildContext context) => StreamBuilder<String>(
    stream: Stream<String>.periodic(const Duration(milliseconds: 100), (
      int count,
    ) {
      final String dots = '.' * ((count % 10) + 1);
      return 'Loading $additionalText$dots';
    }),
    builder:
        (BuildContext context, AsyncSnapshot<String> snapshot) =>
            Text(snapshot.data ?? 'Loading $additionalText...'),
  );
}
