import 'package:flutter/material.dart';
import 'package:login_register_app/data/data.dart';
import 'package:search_page/search_page.dart';

class SearchPageExample extends StatelessWidget {
  const SearchPageExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];

          return ListTile(
            leading: Text(person.position),
            title: Text(person.name),
            subtitle: Text(person.surname),
            trailing: Text('Yaş: ${person.age}  Gol: ${person.goal}  Asist: ${person.asist}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatPage(person: person),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Arama',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Person>(
            onQueryUpdate: print,
            items: people,
            searchLabel: 'Arama',
            suggestion: const Text(textAlign: TextAlign.center,
              'Ad, soyad, pozisyon, gol ya da asiste göre arama yapabilirsiniz',
              style: TextStyle(color: Colors.black),
            ),

            failure: const Text(textAlign: TextAlign.center,
              'Aradığınız kriterlere uygun kişi bulunamadı',
              style: TextStyle(color: Colors.black),
            ),

            filter: (person) => [
              person.name,
              person.surname,
              //person.age.toString(),//filtrelemede yaşı kapattık
              person.position,
              person.goal.toString(),
              person.asist.toString(),
            ],
            sort: (a, b) => a.compareTo(b),
            builder: (person) => ListTile(
              leading: Text(person.position),
              title: Text(person.name),
              subtitle: Text(person.surname),
              trailing: Text('Yaş: ${person.age}  Gol: ${person.goal}  Asist: ${person.asist}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatPage(person: person),
                  ),
                );
              },
            ),
            barTheme: ThemeData(
              textTheme: ThemeData.dark().textTheme.copyWith(
                titleLarge: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}

class StatPage extends StatelessWidget {
  final Person person;

  const StatPage({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person.name} ${person.surname}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Icon(Icons.person)),
              Center(child: Text(textAlign: TextAlign.center ,'Adı: ${person.name}')),
              Center(child: Text(textAlign: TextAlign.center ,'Soyadı: ${person.surname}')),
              Center(child: Text(textAlign: TextAlign.center ,'Yaşı: ${person.age}')),
              Center(child: Text(textAlign: TextAlign.center ,'Pozisyonu: ${person.position}')),
              Center(child: Text(textAlign: TextAlign.center ,'Gol: ${person.goal}')),
              Center(child: Text(textAlign: TextAlign.center ,'Asist: ${person.asist}')),
            ],
          ),
        ),
      ),
    );
  }
}