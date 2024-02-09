// HomePage
import 'package:flutter/material.dart';
import 'package:petsync/detailsPage.dart';
import 'package:petsync/historyPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Map<String, List<String>> petCategories = {
    'Cat': ['Fluffy', 'Whiskers', 'Mittens'],
    'Dog': ['Fido', 'Rex', 'Buddy'],
    'Parrot': ['Polly', 'Charlie', 'Rio'],
    // Add more categories as needed
  };

  int _selectedIndex = 0;
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Adjust duration here
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Adjust animation curve if needed
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(petName: petName)),
          );
        },
        child: ScaleTransition(
          scale: _animation,
          child: Hero(
            tag: petName,
            child: SizedBox(
              height: 200,
              child: Image.asset(
                'assets/images/$petName.jpeg', // Assuming images are stored in assets folder with pet name as file name
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
