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
  void initState()
  {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<void> fetchDataFromFirestore() async {
    try {

      CollectionReference users = _firestore.collection('users');
      DocumentSnapshot document = await users.doc(_auth.currentUser?.uid.toString()).get();

      Map<String, dynamic>? userData = document.data() as Map<String, dynamic>?;

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
  Widget textfield({@required String? text}) {
    return
      Container(
        padding: EdgeInsets.all(16.0),
        width: 350.0, // Kutu genişliği
        height: 60.0, // Kutu yüksekliği
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blue, // Border rengi
            width: 2.0, // Border kalınlığı
          ),
          borderRadius: BorderRadius.circular(50.0), // Köşe yuvarlama
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(fontSize: 19.0),
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
        title: Text('Profile', style: Theme.of(context).textTheme.headline4),

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [

              /*Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage(''))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.blue),
                      child: const Icon(
                        Icons.mode_edit,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),*/

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 20),
              textfield(text: name),
              const SizedBox(height: 20),

              textfield(text: username),
              const SizedBox(height: 20),

              textfield(text: email),


              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text('EditProfile', style: TextStyle(color: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
