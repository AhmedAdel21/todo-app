import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: -8,
          right: -80,
          child: Opacity(
            opacity: 0.7,
            child: SvgPicture.asset(
              ImageAssets.firstGradient,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: SvgPicture.asset(
            ImageAssets.secondGradient,
            fit: BoxFit.fitWidth,
          ),
        ),
        child,
      ],
    );
  }
}
