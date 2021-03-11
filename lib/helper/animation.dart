import 'package:flutter/cupertino.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class DeepthPageTransformer extends PageTransformer {
  DeepthPageTransformer() : super(reverse: false);

  @override
  Widget transform(Widget child, TransformInfo info) {
    double position = info.position;
    if (position <= 0) {
      return new Opacity(
        opacity: 1.0,
        child: new Transform.translate(
          offset: new Offset(0.0, 0.0),
          child: new Transform.scale(
            scale: 1.0,
            child: child,
          ),
        ),
      );
    } else if (position <= 1) {
      const double MIN_SCALE = 0.90;
      // Scale the page down (between MIN_SCALE and 1)
      double scaleFactor = MIN_SCALE + (1 - MIN_SCALE) * (1 - position);

      return new Opacity(
        opacity: 1.0 - position,
        child: new Transform.translate(
          offset: new Offset(
              0.0, -position * info.height), // info.width * -position
          child: new Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}
