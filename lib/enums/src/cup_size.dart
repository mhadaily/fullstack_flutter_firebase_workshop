import 'package:json_annotation/json_annotation.dart';

enum CoffeeCupSize {
  small,
  medium,
  large,
}

extension CoffeeCupSizeExtension on CoffeeCupSize {
  double get iconSize {
    switch (this) {
      case CoffeeCupSize.small:
        return 24;
      case CoffeeCupSize.medium:
        return 30;
      case CoffeeCupSize.large:
        return 36;
      default:
        return 24;
    }
  }
}
