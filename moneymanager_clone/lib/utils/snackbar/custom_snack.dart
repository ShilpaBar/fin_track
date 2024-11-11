import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'dart:ui';

enum SnackType { warning, success, failed }

class CustomSnack {
  static snack({
    required String msg,
    required SnackType snackBarType,
  }) {
    return SnackBar(
      // behavior: SnackBarBehavior.floating,
      // margin: EdgeInsets.all(20),
      // closeIconColor: AppColor.red,

      // padding: EdgeInsets.all(10),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      // ),
      elevation: 0,
      // showCloseIcon: true,
      backgroundColor: Colors.transparent,
      content: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 50.0,
            sigmaY: 50.0,
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(.4)),
            child: Row(
              children: [
                Icon(
                  snackBarType == SnackType.success
                      ? Icons.check_circle_outline
                      : snackBarType == SnackType.failed
                          ? Icons.cancel_outlined
                          : Icons.warning,
                  // scale: 9,
                  size: 50,
                ),
                const Gap(20),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
