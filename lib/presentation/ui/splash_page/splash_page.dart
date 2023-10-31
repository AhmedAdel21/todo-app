import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/app/di.dart';
import 'package:todo_app/data/data_source/local_data_source/permanent_data_source/app_cache.dart';
import 'package:todo_app/presentation/navigation/app_router.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/constants_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/common/app_background/app_background.dart';

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
  Timer? _timer;

  void _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  void _goNext() {
    // Navigator.pushReplacementNamed(context, Routes.mainRoute);
    bool isUserLoggedIn =
        DI.getItInstance<AppSharedPrefs>().getIsUserLoggedIn();
    if (isUserLoggedIn) {
      // navigate to home page
      context.pushReplacementNamed(RoutesName.home);
    } else {
      // navigate to login page
      context.pushReplacementNamed(RoutesName.login);
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizeConstants.s502,
      color: Colors.white,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
                Color.fromARGB(255, 247, 252, 255),
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: AppBackground(
              child: _body,
            ),
          ),
        ),
      ),
    );
  }

  Widget get _body {
    return Center(
      child: _getLogo,
    );
  }

  Widget get _getLogo => Image.asset(
        ImageAssets.splashImage,
        width: AppSizeConstants.s160,
        height: AppSizeConstants.s160,
      );
}
