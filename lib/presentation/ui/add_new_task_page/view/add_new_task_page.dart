import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/domain/usecase/add_todo_task_usecase.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/resources/styles_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/add_new_task_page/viewmodel/add_new_task_page_viewmodel.dart';
import 'package:todo_app/presentation/ui/common/todo_task_card_icon/todo_task_card_icon.dart';

class AddNewTaskPage extends StatelessWidget {
  final AddTodoTaskUseCase useCase;
  const AddNewTaskPage(this.useCase, {super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddNewTaskPageViewModel>(
      create: (context) => AddNewTaskPageViewModel(useCase),
      builder: ((context, child) {
        return const _AddNewTaskPageContent();
      }),
    );
  }
}

class _AddNewTaskPageContent extends StatefulWidget {
  const _AddNewTaskPageContent();

  @override
  State<_AddNewTaskPageContent> createState() => __AddNewTaskPageContentState();
}

class __AddNewTaskPageContentState extends State<_AddNewTaskPageContent> {
  final TextEditingController _taskNameTEC = TextEditingController();
  final TextEditingController _taskDescriptionTEC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late AddNewTaskPageViewModel _viewModel;
  void _bind() {
    _viewModel = Provider.of<AddNewTaskPageViewModel>(context, listen: false);
    _viewModel.start();
    _taskNameTEC.addListener(() => _viewModel.setTaskName(_taskNameTEC.text));
    _taskDescriptionTEC.addListener(
        () => _viewModel.setTaskDescription(_taskDescriptionTEC.text));
  }

  @override
  void initState() {
    super.initState();
    _bind();
  }

  @override
  void dispose() {
    _viewModel.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrain) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.5,
                  child: SizedBox(
                    width: constrain.maxWidth,
                    height: constrain.maxHeight - AppSizeConstants.s20,
                    child: SvgPicture.asset(
                      ImageAssets.addNewTaskGradient,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  // appBar: _getAppBar,
                  body: _getBackground(_getBody),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getBackground(Widget child) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: AppMarginConstants.m21),
          alignment: Alignment.centerLeft,
          child: Text(
            AppStrings.newTask,
            style: getRegularStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.headerTextColor),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                bottom: -500,
                right: -150,
                child: Opacity(
                  opacity: 0.3,
                  child: SvgPicture.asset(
                    ImageAssets.addNewTaskGradImage,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ],
    );
  }

  Widget get _getBody {
    return CustomScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: <Widget>[
        Form(
          key: formKey,
          child: SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: const EdgeInsets.only(
                  right: AppMarginConstants.m18,
                  left: AppMarginConstants.m20,
                  top: AppMarginConstants.m30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _getRowIcons,
                  _getNameTF,
                  _getDescriptionTF,
                  _getDate,
                  _getTime,
                  _getAddButton,
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget get _getRowIcons {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.icon,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s10),
        Selector<AddNewTaskPageViewModel, TodoTaskIcon>(
          selector: (_, provider) => provider.defaultIcon,
          builder: (_, defaultIcon, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: TodoTaskIcon.values.map((icon) {
                if (icon != TodoTaskIcon.none) {
                  return GestureDetector(
                    onTap: () => _viewModel.setTaskIcon(icon),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (defaultIcon == icon) TodoTaskCardIconDot(icon),
                        SvgPicture.asset(
                          icon.imagePath,
                          width: AppSizeConstants.s28,
                          height: AppSizeConstants.s28,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget get _getNameTF {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.name,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s6),
        StreamBuilder<String?>(
          stream: _viewModel.outputErrorTaskNameMessage,
          builder: (context, snapshot) {
            return TextFormField(
              controller: _taskNameTEC,
              validator: _viewModel.taskNameValidator,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                errorText: snapshot.data,
                hintText: AppStrings.addNewTaskNameHintText,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
              style: getRegularStyle(
                  fontSize: FontSizeConstants.s20,
                  fontFamily: AppFontFamily.lato,
                  color: ColorConstants.header2TextColor),
              obscureText: false,
            );
          },
        ),
      ],
    );
  }

  Widget get _getDescriptionTF {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.description,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s10),
        StreamBuilder<String?>(
          stream: _viewModel.outputErrorTaskDescriptionMessage,
          builder: (context, snapshot) {
            return TextFormField(
              validator: _viewModel.taskDescriptionValidator,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              controller: _taskDescriptionTEC,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                errorText: snapshot.data,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              style: getRegularStyle(
                  fontSize: FontSizeConstants.s20,
                  fontFamily: AppFontFamily.lato,
                  color: ColorConstants.header2TextColor),
              obscureText: false,
            );
          },
        ),
      ],
    );
  }

  Widget get _getDate {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.date,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s6),
        GestureDetector(
          onTap: _openDatePicker,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
            ),
            child: Row(
              children: [
                Selector<AddNewTaskPageViewModel, DateTime>(
                    selector: (_, provider) => provider.defaultDate,
                    builder: (_, defaultDate, __) {
                      return Expanded(
                          child: Text(
                        _viewModel.getDate,
                        style: getRegularStyle(
                            fontSize: FontSizeConstants.s18,
                            fontFamily: AppFontFamily.lato,
                            color: ColorConstants.headerTextColor),
                      ));
                    }),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget get _getTime {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: 0.2,
          child: Text(
            AppStrings.time,
            style: getBoldStyle(
                fontSize: FontSizeConstants.s20,
                fontFamily: AppFontFamily.baloo,
                color: ColorConstants.header2TextColor),
          ),
        ),
        const SizedBox(height: AppSizeConstants.s6),
        GestureDetector(
          onTap: _openTimePicket,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: AppSizeConstants.s2,
                ),
              ),
            ),
            child: Row(
              children: [
                Selector<AddNewTaskPageViewModel, TimeOfDay>(
                    selector: (_, provider) => provider.defaultTime,
                    builder: (_, defaultTime, __) {
                      return Expanded(
                          child: Text.rich(TextSpan(children: [
                        TextSpan(
                          text: _viewModel.getTime,
                          style: getRegularStyle(
                              fontSize: FontSizeConstants.s18,
                              fontFamily: AppFontFamily.lato,
                              color: ColorConstants.headerTextColor),
                        ),
                        const WidgetSpan(
                            child: SizedBox(width: AppMarginConstants.m8)),
                        TextSpan(
                          text: _viewModel.getTimeSuffix,
                          style: getBoldStyle(
                              fontSize: FontSizeConstants.s18,
                              fontFamily: AppFontFamily.lato,
                              color: ColorConstants.grayLikeColor),
                        ),
                      ])));
                    }),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget get _getAddButton {
    return Container(
      margin: const EdgeInsets.only(
          left: AppMarginConstants.m20, bottom: AppMarginConstants.m20),
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
      child: StreamBuilder<bool>(
          stream: _viewModel.outputAreAllInputsValid,
          builder: (context, snapshot) {
            callBackFunc() => _viewModel.addNewTask(context, formKey);

            return ElevatedButton(
                onPressed: callBackFunc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  AppStrings.add,
                  style: getRegularStyle(
                      fontSize: FontSizeConstants.s16,
                      fontFamily: AppFontFamily.lato,
                      color: ColorConstants.white),
                )));
          }),
    );
  }

  void _openTimePicket() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _viewModel.defaultTime,
    );
    if (pickedTime != null) {
      _viewModel.setTime(pickedTime);
    }
  }

  void _openDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _viewModel.defaultDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
    if (pickedDate != null) {
      _viewModel.setDate(pickedDate);
    }
  }
}
