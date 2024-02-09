import 'package:flutter/material.dart';
import 'package:petsync/Pet.dart'; // Import the Pet class from the correct location
import 'package:petsync/historyPage.dart';
import 'package:petsync/home.dart';
import 'package:petsync/pets_data.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.petName}) : super(key: key);

  final String petName;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Pet pet; // Declare pet as late to be initialized later

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the pet object based on its name
    pet = _findPet(widget.petName);
  }

  // Method to find the pet based on its name
  Pet _findPet(String petName) {
    // Example implementation; replace it with your logic to find the pet object
    // based on its name from the list of pets
    return pets.firstWhere((pet) => pet.name == petName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Pet Details'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.petName,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage(
                    'assets/images/${widget.petName}.jpeg',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Description of ${widget.petName}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Location: ${pet.location}', // Access the pet's location property
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Age: ${pet.age}', // Access the pet's age property
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Description: ${pet.description}', // Access the pet's vaccination status property
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber.shade200,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Adoptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HistoryPage()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
      }
    });
  }
}
