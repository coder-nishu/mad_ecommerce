import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  // Update Address
  Future<void> updateAddress(String address) async {
    if (_auth.currentUser == null) return;

    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'address': address,
    });
  }

  Future<String?> getAddress() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data()?['address'];
  }

  // Upload Profile Image and Save URL
  Future<String> uploadProfileImage(File imageFile) async {
    if (_auth.currentUser == null) throw Exception("User not logged in");

    final ref = _storage
        .ref()
        .child('profile_images')
        .child('${_auth.currentUser!.uid}.jpg');

    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  // Update profile image URL in Firestore
  Future<void> updateProfileImage(String imageUrl) async {
    if (_auth.currentUser == null) return;

    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'profileImage': imageUrl,
    });
  }
}