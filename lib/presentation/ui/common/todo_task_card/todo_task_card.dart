import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/app/extensions.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';
import 'package:todo_app/presentation/resources/styles_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/common/todo_task_card_icon/todo_task_card_icon.dart';
import 'package:todo_app/presentation/ui/common/todo_task_dialog/todo_task_dialog.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class TodoTaskCard extends StatefulWidget {
  final TodoTask todoTask;
  final TodoTaskCardMode mode;
  final TodoTaskCardViewMode viewMode;
  final void Function(String id)? onCardSelect;
  const TodoTaskCard(
      {required this.todoTask,
      this.viewMode = TodoTaskCardViewMode.list,
      this.mode = TodoTaskCardMode.normal,
      this.onCardSelect,
      super.key});

  @override
  State<TodoTaskCard> createState() => _TodoTaskCardState();
}

class _TodoTaskCardState extends State<TodoTaskCard> {
  late bool isCardSelected;
  @override
  void initState() {
    super.initState();
    isCardSelected = widget.todoTask.isDone;
  }

  @override
  void didUpdateWidget(covariant TodoTaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    isCardSelected = widget.todoTask.isDone;
  }

  @override
  Widget build(BuildContext context) => getBody;

  Widget get getBody {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppMarginConstants.m20),
      height: AppSizeConstants.s52,
      child: Row(
        children: [
          if (widget.viewMode == TodoTaskCardViewMode.calender)
            getTimeDotIconWidget,
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (ctx) => TodoTaskDialog(widget.todoTask),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppSizeConstants.s10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getLeadingWidget,
                    const SizedBox(width: AppPaddingConstants.p12),
                    getContentWidget,
                    getTrailingWidget,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get getTimeDotIconWidget => Row(
        children: [
          Text(
            widget.todoTask.getTime,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getBlackStyle(
              fontSize: FontSizeConstants.s14,
              fontFamily: AppFontFamily.lato,
              color: ColorConstants.headerTextColor,
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                left: AppMarginConstants.m9,
                right: AppMarginConstants.m8,
              ),
              child: TodoTaskCardIconDot(widget.todoTask.icon,
                  isDone: isCardSelected)),
        ],
      );

  Widget get getLeadingWidget {
    switch (widget.viewMode) {
      case TodoTaskCardViewMode.list:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(
                    left: AppMarginConstants.m3, top: AppMarginConstants.m3),
                child: TodoTaskCardIconDot(widget.todoTask.icon,
                    isDone: isCardSelected)),
            Center(
              child: Container(
                  margin: const EdgeInsets.only(
                      left: AppMarginConstants.m10, top: AppMarginConstants.m3),
                  child: TodoTaskCardIcon(icon: widget.todoTask.icon)),
            ),
          ],
        );
      case TodoTaskCardViewMode.calender:
        return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(
              left: AppMarginConstants.m10,
            ),
            child: TodoTaskCardIcon(icon: widget.todoTask.icon));
    }
  }

  Widget get getContentWidget => Expanded(
        flex: 5,
        child: Text(
          widget.todoTask.getTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: getRegularStyle(
            fontSize: FontSizeConstants.s14,
            fontFamily: AppFontFamily.lato,
            color: ColorConstants.headerTextColor,
          ),
        ),
      );

  Widget get getTrailingWidget {
    switch (widget.mode) {
      case TodoTaskCardMode.normal:
        {
          if (widget.viewMode == TodoTaskCardViewMode.list) {
            return getDateTimeWidget;
          } else {
            return const SizedBox.shrink();
          }
        }

      case TodoTaskCardMode.selectable:
        return getSelectionWidget;
    }
  }

  Widget get getSelectionWidget => GestureDetector(
        onTap: () {
          setState(() {
            isCardSelected = isCardSelected.toggle();
          });
          if (widget.onCardSelect != null) {
            widget.onCardSelect!(widget.todoTask.id);
          }
        },
        child: Stack(
          children: [
            // for shadow
            Container(
              margin: const EdgeInsets.only(right: AppMarginConstants.m12),
              width: AppSizeConstants.s8,
              height: AppSizeConstants.s8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppSizeConstants.s6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.todoTaskCheckIconBorderShadowColor,
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(11, 15),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
            ),

            // for check icon
            Container(
              margin: const EdgeInsets.only(right: AppMarginConstants.m12),
              width: AppSizeConstants.s27,
              height: AppSizeConstants.s27,
              color: ColorConstants.white,
              child: isCardSelected
                  ? Center(
                      child: SvgPicture.asset(
                        ImageAssets.checkCardIcon,
                        width: AppSizeConstants.s14,
                        height: AppSizeConstants.s11,
                      ),
                    )
                  : null,
            ),

            // for border
            Opacity(
              opacity: 0.2,
              child: Container(
                margin: const EdgeInsets.only(right: AppMarginConstants.m12),
                width: AppSizeConstants.s27,
                height: AppSizeConstants.s27,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: ColorConstants.todoTaskCheckIconBorderColor,
                    width: AppSizeConstants.s1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSizeConstants.s6),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget get getDateTimeWidget => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                widget.todoTask.getDate,
                style: getSemiBoldStyle(
                  fontFamily: AppFontFamily.lato,
                  color: ColorConstants.headerTextColor,
                ),
              ),
            ),
            const SizedBox(height: AppPaddingConstants.p6),
            Text(
              widget.todoTask.getTime,
              style: getLightStyle(
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.headerTextColor,
              ),
            ),
          ],
        ),
      );
}
