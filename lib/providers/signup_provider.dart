
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toastification/toastification.dart';

import '../routers/app_routers.dart';
import '../widgets/toast.dart';

class SignUpProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  Future<void> signUpWithEmail(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      // trigFail?.change(true);
      return;
    }

    try {

      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Save additional user info to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'uid': credential.user!.uid,
        'email': emailController.text.trim(),
        'username': usernameController.text.trim(),
        'address': '',
        'profileImage': '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      showToast(
        context,
        "Signup Successful",
        'Congratulations! You have successfully signed up.',
        ToastificationType.success,
      );

      // Then navigate to home
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
            (route) => false,
      );

      emailController.clear();
      passwordController.clear();
      usernameController.clear();
    } on FirebaseAuthException catch (e) {
      print("Firebase SignUp Error: ${e.code} - ${e.message}");
      showToast(
        context,
        "Signup Failed",
        e.message ?? 'Signup failed',
        ToastificationType.error,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}