import 'package:flutter/material.dart';
import 'package:petsync/Pet.dart';
import 'package:petsync/pets_data.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key, required this.adoptedPets}) : super(key: key);

  final Map<String, bool> adoptedPets;

  @override
  Widget build(BuildContext context) {
    final adoptedPetsList = adoptedPets.entries.where((entry) => entry.value).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Adoption History'),
      ),
      body: ListView.builder(
        itemCount: adoptedPetsList.length,
        itemBuilder: (context, index) {
          final petEntry = adoptedPetsList[index];
          final pet = _findPet(petEntry.key);

          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/${pet.name}.jpeg'),
            ),
            title: Text(pet.name),
            subtitle: Text(pet.description),
          );
        },
      ),
    );
  }

  Pet _findPet(String petName) {
    return pets.firstWhere((pet) => pet.name == petName);
  }
}
