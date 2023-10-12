import 'package:flutter/cupertino.dart';

import '../themes/colors/light_colors.dart';

class CardWidget extends Container {
  final double minHeight;
  CardWidget({super.key, super.child, this.minHeight = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.backgroundCardView,
      ),
      child: child,
    );
  }
}
