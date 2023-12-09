import 'package:flutter/material.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';

import '../../theme/app_colors.dart';

class AppDefaultButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  final Color color;

  const AppDefaultButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(color),
        foregroundColor:
            MaterialStatePropertyAll<Color>(radioScreenBackgroundColor.value),
        shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

class AppDisabledDefaultButton extends StatelessWidget {
  final Widget child;

  const AppDisabledDefaultButton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll<Color>(Colors.white.withOpacity(0.5)),
        foregroundColor:
            MaterialStatePropertyAll<Color>(radioScreenBackgroundColor.value),
        shadowColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      ),
      onPressed: () {},
      child: child,
    );
  }
}
