import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  void sendEmail() async {
    if (emailC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        await auth.sendPasswordResetEmail(email: emailC.text);
        Get.snackbar(
            'Berhasil dikirim', 'Silakan Check Email diinbox atau diSpam');
      } catch (e) {
        Get.snackbar(
            'Terjadi Kesalahan', 'Tidak Dapat Mengirim Email Reset Password');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
