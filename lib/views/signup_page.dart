import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/signup_provider.dart';
import '../widgets/appbar_text.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const AppBarText(title: 'Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width*0.80,
                  child:
                  Image.asset("assets/logo.jpg")
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: Form(
                      key: signUpProvider.formKey,
                      child: Column(
                        children: [
                          buildTextField(
                            // onChange: signUpProvider.moveEyeBall,
                            // onTap: signUpProvider.isCheckField,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            controller: signUpProvider.usernameController,
                            hintText: "Username",
                            icon: Iconsax.user,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter a valid username";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          buildTextField(
                            // onChange: signUpProvider.moveEyeBall,
                            // onTap: signUpProvider.isCheckField,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: signUpProvider.emailController,
                            hintText: "Email",
                            icon: Icons.mail_rounded,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 15),
                          buildTextField(
                            // onChange: signUpProvider.moveEyeBall,
                            // onTap: signUpProvider.hidePassword,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            controller: signUpProvider.passwordController,
                            hintText: "Password",
                            icon: Iconsax.lock,
                            obscureText: !signUpProvider.isPasswordVisible,
                            suffixIcon: IconButton(
                              onPressed:
                              signUpProvider.togglePasswordVisibility,
                              icon:
                              signUpProvider.isPasswordVisible
                                  ? const Icon(Iconsax.eye)
                                  : const Icon(Iconsax.eye_slash),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.deepOrange,
                            ),
                            child: InkWell(
                              onTap:
                                  () => signUpProvider.signUpWithEmail(context),
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Login",
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    Function()? onTap,
    // required Function(String)? onChange,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.deepOrange,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onTap: onTap,
      // onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.quicksand(fontWeight: FontWeight.w500),
        prefixIcon: Icon(icon, color: Colors.deepOrange),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusColor: Colors.deepOrange,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange),
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      validator: validator,
    );
  }
}