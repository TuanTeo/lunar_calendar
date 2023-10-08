import 'package:flutter/cupertino.dart';

import '../themes/colors/light_colors.dart';

class CardWidget extends Container {
  CardWidget({super.key, super.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.backgroundCardView,
      ),
      child: child,
    );
  }
}
