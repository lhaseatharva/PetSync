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

  late Map<String, bool> adoptedPets;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the adoptedPets map with all pets set to false (not adopted)
    adoptedPets = {};
    petCategories.values.forEach((petList) {
      petList.forEach((petName) {
        adoptedPets[petName] = false;
      });
    });
  }

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
                final isAdopted = adoptedPets[petName] ?? false;
                return _buildPetCard(petName, isAdopted);
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

  Widget _buildPetCard(String petName, bool isAdopted) {
    return InkWell(
      onTap: isAdopted ? null : () => _navigateToDetailsPage(petName),
      child: Hero(
        tag: petName,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: isAdopted ? 0.0 : 4.0, // Set elevation to 0 if pet is adopted
          color: isAdopted ? Colors.grey : null, // Grey out the card if pet is adopted
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

  void _navigateToDetailsPage(String petName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(petName: petName, onAdopted: _updateAdoptedStatus)),
    );
  }

  void _updateAdoptedStatus(String petName, bool isAdopted) {
    setState(() {
      adoptedPets[petName] = isAdopted;
    });
  }
}
