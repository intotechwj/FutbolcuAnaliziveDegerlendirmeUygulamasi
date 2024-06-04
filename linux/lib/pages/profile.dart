import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_register_app/pages/updateProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String name = "";
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      CollectionReference users = _firestore.collection('users');
      DocumentSnapshot document =
      await users.doc(_auth.currentUser?.uid.toString()).get();

      Map<String, dynamic>? userData =
      document.data() as Map<String, dynamic>?;

      if (userData != null) {
        setState(() {
          name = userData['name'].toString();
          username = userData['username'].toString();
          email = userData['email'].toString();
        });
      } else {
        print('Kullanıcı verisi bulunamadı.');
      }
    } catch (e) {
      print('Hata oluştu:$e');
    }
  }

  Widget profileTextField({required String label, required String text}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100, // Etiket genişliği
            child: Text(
              label,
              style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                text,
                style: const TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('Profil', style: Theme.of(context).textTheme.headline6),
        backgroundColor: isDark ? Colors.black : Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'), // Profil resmi için örnek bir placeholder
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),
              profileTextField(label: 'İsim', text: name),
              profileTextField(label: 'Username', text: username),
              profileTextField(label: 'Email', text: email),
              const SizedBox(height: 30),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Profili Düzenle', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}