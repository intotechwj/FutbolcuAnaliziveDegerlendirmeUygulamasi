import 'package:flutter/material.dart';
import 'package:login_register_app/pages/first_page.dart';
import 'package:login_register_app/pages/profile.dart';
import 'package:login_register_app/pages/search_page.dart';
import 'package:login_register_app/pages/second_page.dart';
import 'package:login_register_app/pages/third_page.dart';
import 'package:search_page/search_page.dart';

import '../services/auth_service.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});



  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 4,
    child:  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Anasayfa'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.message_rounded)),
            Tab(icon: Icon(Icons.person)),
            Tab(icon: Icon(Icons.search)),
            Tab(icon: Icon(Icons.newspaper_rounded)),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          FirstPage(),
          SecondPage(),
          SearchPageExample(),
          ThirdPage(),
        ],
      ),
    ),
  );
}
void logout()
{
  AuthService().signOut();
}