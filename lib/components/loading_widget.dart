import 'package:flutter/material.dart';
import 'package:frontend_tambakku/util/styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Loading widget in user details page
Widget loadingWidget() {
  return Container(
    // width: MediaQuery.of(context).size.width,
    // height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      boxShadow: const [CustomColors.boxShadow],
    ),
    child: Center(
      child: LoadingAnimationWidget.discreteCircle(
          color: CustomColors.primary, size: 40.0),
    ),
  );
}
