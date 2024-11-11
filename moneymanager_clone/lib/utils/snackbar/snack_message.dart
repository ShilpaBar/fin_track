// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager_clone/utils/snackbar/custom_snack.dart';
import '../../../main.dart';

class SnackMessage {
  static succesMessgae({required String msg}) {
    return ScaffoldMessenger.of(navigationKey.currentState!.context)
        .showSnackBar(CustomSnack.snack(
      msg: msg,
      snackBarType: SnackType.success,
    ));
  }

  static faildMessage({required String msg}) {
    return ScaffoldMessenger.of(navigationKey.currentState!.context)
        .showSnackBar(CustomSnack.snack(
      msg: msg,
      snackBarType: SnackType.failed,
    ));
  }

  static warningMessage({required String msg, Duration? duration}) {
    return ScaffoldMessenger.of(navigationKey.currentState!.context)
        .showSnackBar(CustomSnack.snack(
      msg: msg,
      snackBarType: SnackType.warning,
    ));
  }

  static void faildMessageWithErrorData({required Map data}) {
    String msg = "";
    for (int i = 0; i < data.keys.length; i++) {
      msg += "${data.values.toList()[i][0]} \n";
    }
    ScaffoldMessenger.of(navigationKey.currentState!.context)
        .showSnackBar(CustomSnack.snack(
      msg: msg,
      snackBarType: SnackType.warning,
    ));
    // final snackBar = SnackBar(
    //   padding: EdgeInsets.all(20),
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Error!',
    //     message: msg,
    //     inMaterialBanner: true,
    //     contentType: ContentType.failure,
    //   ),
    // );
    // snackKey.currentState!
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }
}
