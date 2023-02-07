import 'package:fluttertoast/fluttertoast.dart';
import 'package:cost_admin/const/app_colors.dart';

showToast(String message, ToastGravity gravity) {
  return Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppColor.primaryColor,
    gravity: gravity,
    textColor: AppColor.white,
    fontSize: 15,
    toastLength: Toast.LENGTH_SHORT,
  );
}
