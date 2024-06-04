import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Query dbRef = FirebaseDatabase.instance.ref().child('users');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('users');
  final TextEditingController _searchController = TextEditingController();

  Widget listItem({required Map<String, dynamic> users}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${users['AD'] ?? ''} ${users['SOYAD'] ?? ''}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Pozisyon: ${users['POZİSYON'] ?? ''} | Yaş: ${users['YAŞ'] ?? ''}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              const Text(
                'İstatistikler:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatColumn(Icons.group_add_rounded, 'Maç', users['MAÇ']),
                  _buildStatColumn(Icons.sports_soccer_rounded, 'Gol', users['GOL']),
                  _buildStatColumn(Icons.assistant_direction_outlined, 'Asist', users['ASİST']),
                  _buildStatColumn(Icons.square_rounded, 'Sarı', users['SARI'], iconColor: Colors.yellow),
                  _buildStatColumn(Icons.square_rounded, 'Kırmızı', users['KIRMIZI'], iconColor: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(IconData icon, String label, dynamic value, {Color iconColor = Colors.black}) {
    return Column(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(height: 4),
        Text(
          value?.toString() ?? '',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[200],
    body: Container(
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          final Map<String, dynamic> users = Map<String, dynamic>.from(snapshot.value as Map);
          users['ID'] = snapshot.key;

          return listItem(users: users);
        },
      ),
    ),
  );
}