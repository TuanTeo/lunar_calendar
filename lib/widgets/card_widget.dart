import 'package:flutter/cupertino.dart';

import '../themes/colors/light_colors.dart';

class CardWidget extends Container {
  final double minHeight;
  final String? bgImage;
  final Color? bgColor;

  CardWidget({super.key, super.child, this.minHeight = 0, this.bgImage, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: minHeight
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor ?? ColorConstants.backgroundCardView,
        image: (null != bgImage)
            ? DecorationImage(
          image: AssetImage(bgImage!),
          fit: BoxFit.fill,)
            : null
      ),
      child: child,
    );
  }
}
