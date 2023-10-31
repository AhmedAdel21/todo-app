import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/resources/styles_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/common/todo_task_card_icon/todo_task_card_icon.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class TodoTaskDialog extends StatelessWidget {
  final TodoTask todoTask;
  const TodoTaskDialog(this.todoTask, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizeConstants.s14),
      ),
      elevation: AppSizeConstants.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSizeConstants.s320,
        decoration: BoxDecoration(
            color: ColorConstants.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSizeConstants.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: double.infinity,
                color: ColorConstants.grayLikeColor2,
                padding: const EdgeInsets.symmetric(
                    vertical: AppPaddingConstants.p18),
                child: Column(children: [
                  Container(
                      margin:
                          const EdgeInsets.only(bottom: AppMarginConstants.m17),
                      child: TodoTaskCardIcon(icon: todoTask.icon)),
                  Container(
                      margin:
                          const EdgeInsets.only(bottom: AppMarginConstants.m5),
                      child: Text(
                        todoTask.getTitle,
                        style: getBoldStyle(
                          fontSize: FontSizeConstants.s16,
                          fontFamily: AppFontFamily.lato,
                          color: ColorConstants.headerTextColor,
                        ),
                      )),
                  Container(
                      margin:
                          const EdgeInsets.only(bottom: AppMarginConstants.m5),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: todoTask.getDate,
                          style: getBlackStyle(
                            fontSize: FontSizeConstants.s12,
                            fontFamily: AppFontFamily.lato,
                            color: ColorConstants.headerTextColor,
                          ),
                        ),
                        const WidgetSpan(
                            child: SizedBox(width: AppSizeConstants.s5)),
                        TextSpan(
                          text: todoTask.getTime,
                          style: getRegularStyle(
                            fontSize: FontSizeConstants.s12,
                            fontFamily: AppFontFamily.lato,
                            color: ColorConstants.headerTextColor,
                          ),
                        )
                      ])))
                ])),
            Container(
              padding: const EdgeInsets.only(
                  top: AppPaddingConstants.p17,
                  bottom: AppPaddingConstants.p28),
              child: Column(children: [
                Text(
                  AppStrings.description,
                  style: getBlackStyle(
                    fontSize: FontSizeConstants.s12,
                    fontFamily: AppFontFamily.lato,
                    color: ColorConstants.headerTextColor,
                  ),
                ),
                const SizedBox(height: AppSizeConstants.s18),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: AppMarginConstants.m20),
                  height: AppSizeConstants.s107,
                  child: SingleChildScrollView(
                    child: Text(
                      todoTask.description,
                      style: getRegularStyle(
                        fontSize: FontSizeConstants.s12,
                        fontFamily: AppFontFamily.lato,
                        color: ColorConstants.bodyDescriptionTextColor,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: AppMarginConstants.m20),
              width: AppSizeConstants.s132,
              height: AppSizeConstants.s46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorConstants.blue,
                    ColorConstants.blue,
                    Color(0xFF42A5F5),
                    Color.fromRGBO(0, 255, 255, 0.783),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    AppStrings.done,
                    style: getRegularStyle(
                        fontSize: FontSizeConstants.s16,
                        fontFamily: AppFontFamily.lato,
                        color: ColorConstants.white),
                  ))),
            )
          ],
        ),
      ),
    );
  }
}
