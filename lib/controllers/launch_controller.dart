import 'package:cost_admin/widgets/toast_message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:cost_admin/controllers/user_controller.dart';
import 'package:url_launcher/url_launcher.dart';


final LaunchController launchController = Get.find<LaunchController>();

class LaunchController extends GetxController {





  ///LAUNCH PHONE APP TO MAKE PHONE CALL
  Future<void> makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }



  ///LAUNCH EMAIL FOR REPORT AN ISSUE
  launchEmailForReportAnIssue() async{
    String? email = "costsupport@gmail.com";
    String subject = "Report An Issue : User ID : ${userController.profile!.phone}";
    String body = "Please type your issues below this line:\n";
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      showToast("Opening Email App", ToastGravity.CENTER);
    }else{
      showToast("Can not Email App", ToastGravity.CENTER);
    }
  }


  ///LAUNCH EMAIL FOR REPORT AN ISSUE
  launchEmailForHelp() async{
    String? email = "costsupport@gmail.com";
    String subject = "Help / Enquiry :  User ID : ${userController.profile!.phone}";
    String body = "Please type your enquiry below this line:\n";
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      showToast("Opening Email App", ToastGravity.CENTER);
    }else{
      showToast("Can not Email App", ToastGravity.CENTER);
    }
  }




}
