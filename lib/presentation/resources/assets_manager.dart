const imagePath = "assets/images";
const jsonPath = "assets/json";

class ImageAssets {
  static const grad = "$imagePath/grad.png";
  static const firstGradient = "$imagePath/first_gradient.svg";
  static const secondGradient = "$imagePath/second_gradient.svg";

  static const shopCardIcon = "$imagePath/shop_card_icon.svg";
  static const ballIcon = "$imagePath/ball_icon.svg";
  static const locationIcon = "$imagePath/location_icon.svg";
  static const glassCupIcon = "$imagePath/glass_cup_icon.svg";
  static const dumbbellIcon = "$imagePath/dumbbell_icon.svg";
  static const moreIcon = "$imagePath/more_icon.svg";
  static const notFoundIcon = "$imagePath/more_icon.svg";
  static const drawerIcon = "$imagePath/drawer_icon.svg";
  static const plusIcon = "$imagePath/plus_icon.svg";
  static const calenderIcon = "$imagePath/calender_icon.svg";
  static const checkIcon = "$imagePath/check_icon.svg";
  static const addNewTaskGradImage = "$imagePath/add_new_task_grad_image.svg";
  static const backButtonIcon = "$imagePath/back_button.svg";
  static const addNewTaskGradient = "$imagePath/add_new_task_gradient.svg";
  static const checkCardIcon = "$imagePath/check_card_icon.svg";
  static const doubleCheckIcon = "$imagePath/double_check_icon.svg";
  static const closeIcon = "$imagePath/close_icon.svg";
  static const listIcon = "$imagePath/list_icon.svg";
  static const checkMarker = "$imagePath/check_marker.svg";
  static const splashImage = "$imagePath/splash_screen.png";
}

enum TodoTaskIcon {
  shopCardIcon(ImageAssets.shopCardIcon),
  ballIcon(ImageAssets.ballIcon),
  locationIcon(ImageAssets.locationIcon),
  glassCupIcon(ImageAssets.glassCupIcon),
  dumbbellIcon(ImageAssets.dumbbellIcon),
  moreIcon(ImageAssets.moreIcon),
  none(ImageAssets.notFoundIcon),
  ;

  final String imagePath;
  const TodoTaskIcon(this.imagePath);

  factory TodoTaskIcon.fromImageString(String image) {
    return values.firstWhere(
      (enumCode) => enumCode.imagePath == image,
      orElse: () => TodoTaskIcon.none,
    );
  }
}

class JsonAssets {
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
  static const String success = "$jsonPath/success.json";
}
