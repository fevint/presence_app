import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:presence/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  TextEditingController newPassC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  void newPassword() async {
    if (newPassC.text.isNotEmpty) {
      if (newPassC.text != "password") {
        try {
          String email = auth.currentUser!.email!;

          await auth.currentUser!.updatePassword(newPassC.text);

          await auth.signOut();

          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassC.text,
          );
          Get.offAllNamed(Routes.HOME);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'wrong-password') {
            Get.snackbar('Terjadi Kesalahan',
                'Password terlalu lemah, setidak password berisi 6 kerakter.');
          }
        } catch (e) {
          Get.snackbar('Terjadi Kesalahan',
              'Tidak Dapat membuat password baru. Hubungi CS/Admin');
        }
      } else {
        Get.snackbar('Terjadi Kesalahan',
            'Password baru harus diubah tidak dapat menggunakan password sebelumnya');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Password Baru Harus Diisi');
    }
  }
}
