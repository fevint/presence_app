import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presence/app/routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> login() async {
    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailC.text,
          password: passwordC.text,
        );
        print(userCredential);
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;
            if (passwordC.text == 'password') {
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: 'Belum Vertifikasi',
              middleText:
                  'Kamu vertifikasi akun ini. lakukan vertifikasi email terlebih dahulu',
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = true;
                    Get.back();
                  },
                  //Tombol Kembali atau nutup notifikasi
                  child: Text('Kembali'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                          'Berhasil', 'Silakan Cek Email diInbok atau diSpam');
                    } catch (e) {
                      Get.snackbar('Terjadi Kesalahan',
                          'Belum Dapat Mengirim Vertifikasi ke Gmail. Coba Hubungi CS.');
                    }
                  }, //Tombol Kembali atau nutup notifikasi
                  child: Text('Vertifikasi Ulang'),
                ),
              ],
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        if (e.code == 'user-not-found') {
          Get.snackbar('Terjadi Kesalahan', 'Email tidak terdaftar');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Terjadi Kesalahan', 'Password Salah');
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Terjadi Kesalahan', 'Tidak Dapat Login');
      }
    } else {
      Get.snackbar('Terjadi Kesalahan', 'Email dan Password Wajib diisi');
    }
  }
}
