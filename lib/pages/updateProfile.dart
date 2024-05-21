
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();

  final CollectionReference firestore = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios)),
        title: Text('EditProfile', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              // -- IMAGE with ICON
              /*Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage(''))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.cyan),
                      child: const Icon(Icons.camera, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),*/
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'İsminizi Giriniz'
                            : value!.length < 6 ? 'İsminiz 6 haneden küçük olamaz' : null;
                      },
                      decoration: const InputDecoration(
                          label: Text('Name'),),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                          label: Text('User Name')),
                    ),

                    const SizedBox(height: 20),
                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => updateProfile(context),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text('Edit Profile', style: TextStyle(color:Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // -- Created Date and Delete Button
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: ' ',
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: '',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void updateProfile(BuildContext context){
    if(name.toString().length > 6 && username.toString().length > 6)
    {
      firestore.doc(auth.currentUser!.uid.toString()).update({
        'name' : name.text,
        'username' : username.text
      }).then((value){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kullanıcı Bilgileri Güncellendi'),
          ),
        );
      });
    }
  }
}