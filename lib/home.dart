// HomePage
import 'package:flutter/material.dart';
import 'package:petsync/detailsPage.dart';
import 'package:petsync/historyPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, List<String>> petCategories = {
    'Cat': ['Fluffy', 'Whiskers', 'Mittens'],
    'Dog': ['Fido', 'Rex', 'Buddy'],
    'Parrot': ['Polly', 'Charlie', 'Rio'],
    // Add more categories as needed
  };

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber, // Match app theme
        title: const Text('Pet Sync'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: petCategories.keys.map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: _selectedIndex == petCategories.keys.toList().indexOf(category),
                onSelected: (bool selected) {
                  setState(() {
                    _selectedIndex = petCategories.keys.toList().indexOf(category);
                  });
                },
                backgroundColor: _selectedIndex == petCategories.keys.toList().indexOf(category) ? Colors.amber : Colors.blueGrey.shade200,
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: petCategories.values.elementAt(_selectedIndex).length,
              itemBuilder: (context, index) {
                final petName = petCategories.values.elementAt(_selectedIndex)[index];
                return _buildPetCard(petName);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryPage()),
          );
        },
        child: const Icon(Icons.history),
      ),
    );
  }

  Widget _buildPetCard(String petName) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(petName: petName)),
        );
      },
      child: Hero(
        tag: petName,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    'assets/images/$petName.jpeg',
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  petName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
