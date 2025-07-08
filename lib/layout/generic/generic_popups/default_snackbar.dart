import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class DefaultSnackbar extends SnackBar {
  DefaultSnackbar(String text, {super.key})
    : super(
        content: Text(text),
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(milliseconds: 1800),
        showCloseIcon: false,
        animation: CurvedAnimation(
          parent: AnimationController(
            duration: const Duration(milliseconds: 200),
            vsync: const _NoTickerProvider(),
          ),
          curve: _RiseAndDropCurve(),
        ),
      );
}

class _RiseAndDropCurve extends Curve {
  @override
  double transform(double t) {
    if (t < 0.5) {
      return 2 * t * t;
    } else {
      return 1 - (2 * (t - 1) * (t - 1));
    }
  }
}

class _NoTickerProvider extends StatelessWidget implements TickerProvider {
  const _NoTickerProvider();
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
