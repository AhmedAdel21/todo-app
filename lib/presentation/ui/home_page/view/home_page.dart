import 'package:dartz/dartz.dart' show Tuple3, Tuple2;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/presentation/resources/assets_manager.dart';
import 'package:todo_app/presentation/resources/color_manager.dart';
import 'package:todo_app/presentation/resources/font_manager.dart';
import 'package:todo_app/presentation/resources/strings_manager.dart';
import 'package:todo_app/presentation/resources/styles_manager.dart';
import 'package:todo_app/presentation/resources/values_manager.dart';
import 'package:todo_app/presentation/ui/common/app_background/app_background.dart';
import 'package:todo_app/presentation/ui/common/table_calendar/table_calendar.dart';
import 'package:todo_app/presentation/ui/common/todo_task_card/todo_task_card.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';
import 'package:todo_app/presentation/ui/done_task_page/view/done_task_page.dart';
import 'package:todo_app/presentation/ui/home_page/viewmodel/home_page_viewmodel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      builder: ((context, child) {
        return const _HomePageContent();
      }),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => __HomePageContentState();
}

class __HomePageContentState extends State<_HomePageContent> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final HomePageViewModel _viewModel;

  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<HomePageViewModel>(context, listen: false);
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
            key: _scaffoldKey,
            appBar: _getAppBar,
            backgroundColor: Colors.transparent,
            body: AppBackground(
              child: _body,
            ),
            endDrawer: DoneTasksPage(_viewModel.getTodoTasks),
          ),
        ),
      ),
    );
  }

  AppBar get _getAppBar {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Center(
        child: FittedBox(
          child:
              Selector<HomePageViewModel, Tuple2<HomePageViewMode, DateTime>>(
            selector: (_, provider) =>
                Tuple2(provider.homePageViewMode, provider.selectedDay),
            builder: (_, items, __) {
              return Text(
                _viewModel.getTitle,
                style: getRegularStyle(
                    fontSize: FontSizeConstants.s20,
                    fontFamily: AppFontFamily.baloo,
                    color: ColorConstants.headerTextColor),
              );
            },
          ),
          //
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: AppMarginConstants.m21),
          child: GestureDetector(
            onTap: toggleEndDrawer,
            child: SvgPicture.asset(
              ImageAssets.drawerIcon,
              width: 23,
              height: 15,
            ),
          ),
        )
      ],
    );
  }

  Widget get getTodoTasksWidget => Selector<HomePageViewModel,
          Tuple3<TodoTaskCardMode, HomePageViewMode, DateTime>>(
        selector: (_, provider) => Tuple3(provider.todoTaskCardMode,
            provider.homePageViewMode, provider.selectedDay),
        builder: (_, items, __) {
          return Column(
            children: [
              if (items.value2 == HomePageViewMode.calender)
                getCalenderRowWidget(items.value3),
              if (_viewModel.getTodoTasks.isEmpty)
                Expanded(child: getEmptyWidget),
              if (_viewModel.getTodoTasks.isNotEmpty)
                Expanded(
                  child: getTodoList(items.value1),
                )
            ],
          );
        },
      );
  Widget getTodoList(TodoTaskCardMode mode) {
    return ListView(
      children: [
        for (final task in _viewModel.getTodoTasks.values.toList().reversed)
          Container(
              margin: const EdgeInsets.only(bottom: AppMarginConstants.m20),
              child: TodoTaskCard(
                todoTask: task,
                mode: mode,
                viewMode: _viewModel.getCardViewMode,
                onCardSelect: _viewModel.toggleCaredSelection,
              )),
        const SizedBox(height: AppSizeConstants.s60),
      ],
    );
  }

  Widget getCalenderRowWidget(DateTime newSelectedDay) {
    return TableCalendar(
      startingDayOfWeek: StartingDayOfWeek.saturday,
      getDayIcon: (day) => _viewModel.getDayIcon(day),
      headerVisible: false,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: newSelectedDay,
      calendarFormat: CalendarFormat.week,
      rowHeight: AppSizeConstants.s60,
      daysOfWeekHeight: AppSizeConstants.s16,
      onDaySelected: (selectedDay, focusedDay) =>
          _viewModel.setSelectedDay(focusedDay),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: getRegularStyle(
          fontSize: FontSizeConstants.s12,
          fontFamily: AppFontFamily.lato,
          color: ColorConstants.headerTextColor,
        ),
        weekendStyle: getRegularStyle(
          fontSize: FontSizeConstants.s12,
          fontFamily: AppFontFamily.lato,
          color: ColorConstants.headerTextColor,
        ),
      ),
      calendarStyle: CalendarStyle(
        selectedTextStyle: getRegularStyle(
          fontSize: FontSizeConstants.s22,
          fontFamily: AppFontFamily.baloo,
          color: ColorConstants.white,
        ),
        weekendTextStyle: getRegularStyle(
          fontSize: FontSizeConstants.s12,
          fontFamily: AppFontFamily.baloo,
          color: ColorConstants.headerTextColor,
        ),
        isTodayHighlighted: false,
        defaultTextStyle: getRegularStyle(
          fontSize: FontSizeConstants.s16,
          fontFamily: AppFontFamily.baloo,
          color: ColorConstants.headerTextColor,
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(day, newSelectedDay),
      weekendDays: const [DateTime.friday, DateTime.saturday],
    );
  }

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
      screenWidth = boxConstraints.maxWidth;
      return Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(top: AppMarginConstants.m16),
        child: Stack(
          children: [
            StreamBuilder<DataState>(
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
            Positioned(
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  width: boxConstraints.maxWidth,
                  height: AppSizeConstants.s210,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xFFE3F2FD),
                      ],
                    ),
                  ),
                  padding:
                      const EdgeInsets.only(bottom: AppPaddingConstants.p20),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: boxConstraints.maxWidth,
                height: AppSizeConstants.s210,
                child: getBottomButton,
              ),
            )
          ],
        ),
      );
    });
  }

  Widget get getBottomButton {
    return Selector<HomePageViewModel, TodoTaskCardMode>(
      selector: (_, provider) => provider.todoTaskCardMode,
      builder: (_, todoTaskCardMode, __) {
        switch (todoTaskCardMode) {
          case TodoTaskCardMode.normal:
            return getButtonInDefaultMode;

          case TodoTaskCardMode.selectable:
            return getOnSelectionMode;
        }
      },
    );
  }

  Widget get getOnSelectionMode => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getCloseButton,
          getDoubleCheckButton,
        ],
      );
  Widget get getButtonInDefaultMode => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          getCheckButton,
          getMainButton,
          GestureDetector(
            onTap: () => _viewModel.goToAddNewTaskPage(context, screenWidth),
            child: SvgPicture.asset(ImageAssets.plusIcon),
          ),
        ],
      );
  Widget get getCheckButton {
    return GestureDetector(
      onTap: () => _viewModel.toggleTodoTaskCardMode(),
      child: SvgPicture.asset(ImageAssets.checkIcon),
    );
  }

  Widget get getDoubleCheckButton => GestureDetector(
        onTap: () => _viewModel.acceptAllChanges(),
        child: SvgPicture.asset(
          ImageAssets.doubleCheckIcon,
        ),
      );

  Widget get getCloseButton => GestureDetector(
        onTap: () => _viewModel.discardAllChanges(),
        child: SvgPicture.asset(
          ImageAssets.closeIcon,
        ),
      );

  Widget get getMainButton => Selector<HomePageViewModel, HomePageViewMode>(
        selector: (_, provider) => provider.homePageViewMode,
        builder: (_, homePageViewMode, __) {
          final onTap = _viewModel.toggleHomePageViewMode;
          switch (homePageViewMode) {
            case HomePageViewMode.list:
              return GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(ImageAssets.calenderIcon),
              );

            case HomePageViewMode.calender:
              return GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset(ImageAssets.listIcon),
              );
          }
        },
      );
}
