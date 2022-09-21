import 'package:electronic_shop/app/core/constants/color_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorSnackBar {
  static Future build({required String message, required bool error}) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.SNACKBAR,
        textColor: ColorManager.WHITE,
        backgroundColor: error ? ColorManager.ERROR : ColorManager.SUCCESS);
  }
}
