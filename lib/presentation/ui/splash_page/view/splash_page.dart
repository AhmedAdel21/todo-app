import 'package:flutter/material.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SplashPageContent();
  }
}

class _SplashPageContent extends StatefulWidget {
  const _SplashPageContent();

  @override
  State<_SplashPageContent> createState() => __SplashPageContentState();
}

class __SplashPageContentState extends State<_SplashPageContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        ImageAssets.splashImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
