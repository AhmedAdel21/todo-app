import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/resources/styles_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/common/app_background/app_background.dart';
import 'package:todo_app/presentation/ui/common/todo_task_card/todo_task_card.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';
import 'package:todo_app/presentation/ui/done_task_page/viewmodel/done_task_page_viewmodel.dart';

class DoneTasksPage extends StatelessWidget {
  final Map<String, TodoTask> allTodoTaskMap;
  const DoneTasksPage(this.allTodoTaskMap, {super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoneTasksPageViewModel>(
      create: (context) => DoneTasksPageViewModel(allTodoTaskMap),
      builder: ((context, child) {
        return const _DoneTasksPageContent();
      }),
    );
  }
}

class _DoneTasksPageContent extends StatefulWidget {
  const _DoneTasksPageContent();

  @override
  State<_DoneTasksPageContent> createState() => __DoneTasksPageContentState();
}

class __DoneTasksPageContentState extends State<_DoneTasksPageContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final DoneTasksPageViewModel _viewModel;
  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<DoneTasksPageViewModel>(context, listen: false);
    _viewModel.start();
  }

  bool isDrawerOpen = false;
  void toggleEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();

    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            key: _scaffoldKey,
            appBar: _getAppBar,
            backgroundColor: Colors.transparent,
            body: AppBackground(
              child: _body,
            ),
          ),
        ),
      ),
    );
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          ImageAssets.backButtonIcon,
          fit: BoxFit.fitHeight,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: FittedBox(
          child: Text(
        _viewModel.getTitle,
        style: getRegularStyle(
            fontSize: FontSizeConstants.s20,
            fontFamily: AppFontFamily.baloo,
            color: ColorConstants.headerTextColor),
      )),
    );
  }

  Widget get getTodoTasksWidget => ListView(
        children: [
          for (final task in _viewModel.getTodoTasks.values.toList().reversed)
            Container(
                margin: const EdgeInsets.only(bottom: AppMarginConstants.m20),
                child: TodoTaskCard(
                  todoTask: task,
                )),
          const SizedBox(height: AppSizeConstants.s60),
        ],
      );
  Widget get getEmptyWidget => Center(
          child: Text(
        AppStrings.noTasksFound,
        style: getBlackStyle(
          fontSize: FontSizeConstants.s22,
          fontFamily: AppFontFamily.lato,
          color: ColorConstants.headerTextColor,
        ),
      ));
  Widget get getWaitingWidget =>
      const Center(child: CircularProgressIndicator());
  Widget getErrorWidget(String error) => Center(
          child: Text(
        error,
        style: getRegularStyle(
          fontFamily: AppFontFamily.lato,
          color: ColorConstants.header2TextColor,
        ),
      ));
  Widget get _body {
    return LayoutBuilder(builder: (_, boxConstraints) {
      return Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: AppMarginConstants.m16),
        child: StreamBuilder<DataState>(
          stream: _viewModel.onDataStateChanged,
          initialData: DataState.loading,
          builder: (context, AsyncSnapshot<DataState> snapshot) {
            switch (snapshot.data) {
              case DataState.loading:
                return getWaitingWidget;
              case DataState.data:
                return getTodoTasksWidget;
              case DataState.empty:
                return getEmptyWidget;
              case DataState.error:
                return getErrorWidget(
                    snapshot.error?.toString() ?? AppStrings.errorHappened);
              default:
                return getWaitingWidget;
            }
          },
        ),
      );
    });
  }
}
