import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';

class TodoTaskCardIcon extends StatelessWidget {
  final TodoTaskIcon icon;
  const TodoTaskCardIcon({required this.icon, super.key});
  final width = AppSizeConstants.s28;
  final height = AppSizeConstants.s28;
  @override
  Widget build(BuildContext context) {
    switch (icon) {
      case TodoTaskIcon.shopCardIcon:
        return SvgPicture.asset(
          ImageAssets.shopCardIcon,
          width: width,
          height: height,
        );

      case TodoTaskIcon.ballIcon:
        return SvgPicture.asset(
          ImageAssets.ballIcon,
          width: width,
          height: height,
        );

      case TodoTaskIcon.locationIcon:
        return SvgPicture.asset(
          ImageAssets.locationIcon,
          width: width,
          height: height,
        );

      case TodoTaskIcon.glassCupIcon:
        return SvgPicture.asset(
          ImageAssets.glassCupIcon,
          width: width,
          height: height,
        );

      case TodoTaskIcon.dumbbellIcon:
        return SvgPicture.asset(
          ImageAssets.dumbbellIcon,
          width: width,
          height: height,
        );

      case TodoTaskIcon.moreIcon:
        return SvgPicture.asset(
          ImageAssets.moreIcon,
          width: width,
          height: height,
        );
      case TodoTaskIcon.none:
        return const Icon(
          Icons.question_mark_rounded,
          size: AppSizeConstants.s28,
          color: ColorConstants.black,
        );
    }
  }
}

class TodoTaskCardIconDot extends StatelessWidget {
  final TodoTaskIcon icon;
  final bool isDone;
  final double width;
  final double height;
  const TodoTaskCardIconDot(
    this.icon, {
    super.key,
    this.isDone = false,
    this.width = AppSizeConstants.s28,
    this.height = AppSizeConstants.s28,
  });

  @override
  Widget build(BuildContext context) {
    switch (icon) {
      case TodoTaskIcon.shopCardIcon:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.shopCardIconDotColor,
            );
          } else {
            return const Icon(
              Icons.circle_rounded,
              size: AppSizeConstants.s7,
              color: ColorConstants.shopCardIconDotColor,
            );
          }
        }
      case TodoTaskIcon.ballIcon:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.ballIconDotColor,
            );
          } else {
            return const Icon(
              Icons.circle_rounded,
              size: AppSizeConstants.s7,
              color: ColorConstants.ballIconDotColor,
            );
          }
        }
      case TodoTaskIcon.locationIcon:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.locationIconDotColor,
            );
          } else {
            return const Icon(
              Icons.circle_rounded,
              size: AppSizeConstants.s7,
              color: ColorConstants.locationIconDotColor,
            );
          }
        }
      case TodoTaskIcon.glassCupIcon:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.glassCupIconDotColor,
            );
          } else {
            return const Icon(
              Icons.circle_rounded,
              size: AppSizeConstants.s7,
              color: ColorConstants.glassCupIconDotColor,
            );
          }
        }
      case TodoTaskIcon.dumbbellIcon:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.dumbbellIconDotColor,
            );
          } else {
            return const Icon(
              Icons.circle_rounded,
              size: AppSizeConstants.s7,
              color: ColorConstants.dumbbellIconDotColor,
            );
          }
        }
      case TodoTaskIcon.moreIcon:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.moreIconDotColor,
            );
          } else {
            return const Icon(
              Icons.circle_rounded,
              size: AppSizeConstants.s7,
              color: ColorConstants.moreIconDotColor,
            );
          }
        }
      case TodoTaskIcon.none:
        {
          if (isDone) {
            return SvgPicture.asset(
              ImageAssets.checkMarker,
              color: ColorConstants.black,
            );
          } else {
            return const Icon(
              Icons.question_mark_rounded,
              size: AppSizeConstants.s28,
              color: ColorConstants.black,
            );
          }
        }
    }
  }
}
