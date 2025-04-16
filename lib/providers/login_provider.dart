import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toastification/toastification.dart';

import '../routers/app_routers.dart';
import '../widgets/toast.dart';

class LoginProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // SMIInput<bool>? isChecking;
  // SMIInput<bool>? isHandsUp;
  // SMIInput<bool>? trigSuccess;
  // SMIInput<bool>? trigFail;
  // SMINumber? numLook;
  // StateMachineController? stateMachineController;

  bool isPasswordVisible = false;
  bool isLoading = false;

  // void initializeRive(Artboard artBoard) {
  //   stateMachineController = StateMachineController.fromArtboard(
  //     artBoard,
  //     "Login Machine",
  //   );
  //   if (stateMachineController == null) return;
  //   artBoard.addController(stateMachineController!);
  //
  //   isChecking = stateMachineController?.findInput("isChecking");
  //   isHandsUp = stateMachineController?.findInput("isHandsUp");
  //   trigSuccess = stateMachineController?.findInput("trigSuccess");
  //   trigFail = stateMachineController?.findInput("trigFail");
  //   numLook = stateMachineController?.findSMI("numLook");
  // }

  // void isCheckField() {
  //   isHandsUp?.change(false);
  //   isChecking?.change(true);
  //   numLook?.change(0);
  // }

  // void moveEyeBall(String val) {
  //   numLook?.change(val.length.toDouble());
  // }

  // void hidePassword() {
  //   isPasswordVisible ? isChecking?.change(true) : isHandsUp?.change(true);
  // }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;

    // if (isPasswordVisible) {
    //   isChecking?.change(true);
    //   isHandsUp?.change(false);
    // } else {
    //   isChecking?.change(false);
    //   isHandsUp?.change(true);
    // }

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
    // if (!formKey.currentState!.validate()) {
    //   trigFail?.change(true);
    //   return false;
    // }

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