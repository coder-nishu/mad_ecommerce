import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../services/auth_services.dart';
import '../widgets/appbar_text.dart';
import '../widgets/have_to_login.dart';
import '../widgets/heading.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/scratcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController();
    final LoginProvider loginProvider = Provider.of<LoginProvider>(context);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.deepOrange),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.red[400],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarText(title: 'My Profile'),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: ListView(
                children: [
                  ProfileImagePicker(),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Change Your Profile Picture',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  HHeading(
                    title: 'Profile Information',
                    isSeeAll: false,
                    titleFontSize: 20,
                  ),
                  SizedBox(height: 18),
                  profileInformation(context, addressController),
                  Divider(color: Colors.grey[300], thickness: 1, height: 50),
                  HHeading(
                    title: 'Other Information',
                    isSeeAll: false,
                    titleFontSize: 20,
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Iconsax.logout_copy),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onTap: () {
                      PanaraConfirmDialog.show(
                        context,
                        title: "Are you sure?",
                        message: "Do you want to logout?",
                        confirmButtonText: "Logout",
                        cancelButtonText: "Cancel",
                        onTapCancel: () => Navigator.pop(context),
                        onTapConfirm: () {
                          loginProvider.logout(context);
                          Navigator.pop(context);
                        },
                        panaraDialogType: PanaraDialogType.error,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return HaveToLogin(text: ' to see your profile');
        }
      },
    );
  }

  Column profileInformation(
      BuildContext context,
      TextEditingController addressController,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 12,
      children: [
        FutureBuilder<Map<String, dynamic>?>(
          future: AuthService().getUserProfile(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Text(
                'Failed to load user data',
                style: GoogleFonts.montserrat(fontSize: 16),
              );
            }

            final data = snapshot.data!;
            final name = data['username'] ?? 'No Name';
            final email = data['email'] ?? 'No Email';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        'Name:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        'Email:',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        email,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                'Address:',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: FutureBuilder<String?>(
                future: AuthService().getAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError ||
                      !snapshot.hasData ||
                      snapshot.data!.isEmpty) {
                    return Text(
                      'No address found',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }

                  return Text(
                    snapshot.data!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),

            Spacer(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      height: 230,
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            HHeading(
                              title: 'Change Address',
                              isSeeAll: false,
                              titleFontSize: 20,
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              controller: addressController,
                              style: const TextStyle(fontSize: 15),
                              cursorColor: Colors.deepOrange,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Iconsax.safe_home,
                                  color: Colors.deepOrange,
                                ),
                                hintText: "Enter your delivery address",
                                hintStyle: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusColor: Colors.teal,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.teal,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a valid address";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Flexible(
                                  child: InkWell(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Cancel',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Flexible(
                                  child: InkWell(
                                    onTap: () {
                                      AuthService().updateAddress(
                                        addressController.text,
                                      );
                                      addressController.clear();
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Address changed successfully',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(32),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Save',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Text(
                  'CHANGE',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}