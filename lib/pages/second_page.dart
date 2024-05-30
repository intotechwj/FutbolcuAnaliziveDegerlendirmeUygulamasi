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
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ad: ' + (users['AD']?.toString() ?? ''),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Soyad: ' + (users['SOYAD']?.toString() ?? ''),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Pozisyon: ' + (users['POZİSYON']?.toString() ?? ''),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                'Yaş: ' + (users['YAŞ']?.toString() ?? ''),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'İstatistikler: ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.group_add_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      users['MAÇ']?.toString() ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.sports_soccer_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      users['GOL']?.toString() ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.assistant_direction_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      users['ASİST']?.toString() ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.square_rounded,
                      color: Colors.yellow,
                    ),
                    title: Text(
                      users['SARI']?.toString() ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.square_rounded,
                      color: Colors.red,
                    ),
                    title: Text(
                      users['KIRMIZI']?.toString() ?? '',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 6,
                  ),
                ],
              )
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
