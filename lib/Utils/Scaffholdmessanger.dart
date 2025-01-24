import 'package:flutter/material.dart';
import 'package:newautobox/Utils/Colors.dart';
import 'package:newautobox/Utils/Const/FontStyle.dart';

void showSnackBar(
  String msg,
  BuildContext context, {
  bool showAction = false,
  Function? onPressedAction,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        msg,
        textAlign: showAction ? TextAlign.start : TextAlign.center,
        style: TextStyle(
          color: AppColors.Kwhite,
          fontWeight: FontWeights.regular,
          fontSize: 16,
        ),
      ),
      behavior: SnackBarBehavior.fixed,
      duration: duration ?? const Duration(seconds: 2),
      backgroundColor: AppColors.PRIMARY_COLOR,
      action: showAction
          ? SnackBarAction(
              label: 'Retry',
              onPressed: onPressedAction! as void Function(),
              textColor: Theme.of(context).colorScheme.surface,
            )
          : null,
      elevation: 2,
    ),
  );
}
