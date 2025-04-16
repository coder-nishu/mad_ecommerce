import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toastification/toastification.dart';

import '../routers/app_routers.dart';
import '../widgets/toast.dart';

class LoginProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();



  bool isPasswordVisible = false;
  bool isLoading = false;


  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;


    notifyListeners();
  }

  // Signout function
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      showToast(
        context,
        "Logout Failed",
        e.toString(),
        ToastificationType.error,
      );
    }
  }

  Future<bool> signInWithEmail(BuildContext context) async {

    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      showToast(
        context,
        "Login Successful",
        'Congratulations! You have successfully logged in.',
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
      return true;
    } on FirebaseAuthException catch (e) {
      // trigFail?.change(true);

      showToast(
        context,
        "Login Failed",
        e.message ?? 'Login failed',
        ToastificationType.error,
      );

      print("Login Error: ${e.code} - ${e.message}");

      return false;
    } finally {
      // isChecking?.change(false);
      // isHandsUp?.change(false);
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}