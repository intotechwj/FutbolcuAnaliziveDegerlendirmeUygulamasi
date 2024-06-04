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
        title: Text('Profil Düzenle'
            , style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(height: 50),
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
                        label: Text('İsim'),),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                          label: Text('Username')),
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
                        child: const Text('Profili Düzenle', style: TextStyle(color:Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 10),


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