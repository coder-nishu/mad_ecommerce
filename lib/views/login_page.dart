import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/login_provider.dart';
import '../routers/app_routers.dart';
import '../widgets/appbar_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(title: AppBarText(title: 'Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width*0.80,
                child:
                Image.asset("assets/logo.jpg",fit: BoxFit.contain),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  child: Form(
                    key: loginProvider.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: loginProvider.emailController,
                          style: const TextStyle(fontSize: 15),
                          cursorColor: Colors.deepOrange,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail_rounded,
                              color: Colors.deepOrange,
                            ),
                            hintText: "Email",
                            hintStyle: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusColor: Colors.deepOrange,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: loginProvider.passwordController,
                          obscureText: !loginProvider.isPasswordVisible,
                          style: const TextStyle(fontSize: 15),
                          cursorColor: Colors.deepOrange,
                          textInputAction: TextInputAction.done,

                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Iconsax.lock,
                              color: Colors.deepOrange,
                            ),
                            hintText: "Password",
                            hintStyle: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            suffixIcon: IconButton(
                              onPressed:
                              loginProvider.togglePasswordVisibility,
                              icon:
                              loginProvider.isPasswordVisible
                                  ? const Icon(Iconsax.eye)
                                  : const Icon(Iconsax.eye_slash),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusColor: Colors.deepOrange,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.deepOrange,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.deepOrange,
                          ),
                          child: InkWell(
                            onTap:
                            loginProvider.isLoading
                                ? null
                                : () => loginProvider.signInWithEmail(
                              context,
                            ),
                            child: Center(
                              child:
                              loginProvider.isLoading
                                  ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              )
                                  : Text(
                                "Login",
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
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed:
                        () => Navigator.pushNamed(context, AppRoutes.signup),
                    child: Text(
                      "Sign Up",
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
}
