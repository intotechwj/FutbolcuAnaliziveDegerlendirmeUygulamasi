import 'package:flutter/material.dart';
import 'package:login_register_app/pages/first_page.dart';
import 'package:login_register_app/pages/profile.dart';
import 'package:login_register_app/pages/second_page.dart';

import '../services/auth_service.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  


  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child:  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Anasayfa'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 28,
              ),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  ProfileScreen()),
              );
                },
              )
          ],
        centerTitle: true,
        bottom: TabBar(
            tabs: [
            Tab(text: 'Bolum 1'),
            Tab(text: 'Bolum 2'),
            ],
        ),
      ),
        body: TabBarView(
          children: [
            FirstPage(),
            SecondPage(),
          ],
        )
    ),
  );
  }
  void logout()
  {
    AuthService().signOut();
  }

