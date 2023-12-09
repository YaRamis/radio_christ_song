import 'package:flutter/material.dart';
import 'package:radio_christ_song/theme/app_colors.dart';
import 'package:radio_christ_song/theme/app_gradients.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}

class AppDefaultBlueIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const AppDefaultBlueIcon({
    super.key,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: AppColors.blue,
    );
  }
}

class AppDefaultBlackIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const AppDefaultBlackIcon({
    super.key,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: Colors.black,
    );
  }
}

// class AppDefaultGradientIcon extends StatelessWidget {
//   final IconData icon;
//   final double size;
//
//   const AppDefaultGradientIcon({
//     super.key,
//     required this.icon,
//     required this.size,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GradientIcon(
//       icon: icon,
//       size: size,
//       gradient: AppGradients.defaultGradient,
//     );
//   }
// }
