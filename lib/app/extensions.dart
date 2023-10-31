import 'package:todo_app/app/constants/global_constants.dart';

extension NonNullString on String? {
  String get orEmpty {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int get orMinusOne {
    if (this == null) {
      return Constants.minusOne;
    } else {
      return this!;
    }
  }
}

extension Toggle on bool? {
  bool toggle() {
    if (this == null) {
      return false;
    } else {
      return !this!;
    }
  }
}
