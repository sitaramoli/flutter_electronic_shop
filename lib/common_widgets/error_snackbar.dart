import 'package:electronic_shop/app/constants/color_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorSnackBar {
  static Future build({required String message}) {
    return Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.SNACKBAR,
        textColor: ColorConstants.white,
        backgroundColor: ColorConstants.error);
  }
}
