import 'package:flutter/cupertino.dart';

import '../themes/colors/light_colors.dart';

class CardWidget extends Container {
  final double minHeight;
  final String? bgImage;

  CardWidget({super.key, super.child, this.minHeight = 0, this.bgImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.backgroundCardView,
        image: (null != bgImage)
            ? DecorationImage(
          image: AssetImage(bgImage!),
          fit: BoxFit.cover,)
            : null
      ),
      child: child,
    );
  }
}
