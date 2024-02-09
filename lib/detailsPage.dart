import 'package:flutter/material.dart';
import 'package:petsync/Pet.dart';
import 'package:petsync/pets_data.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.petName, required this.onAdopted}) : super(key: key);

  final String petName;
  final Function(String, bool) onAdopted;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Pet? _pet;

  @override
  void initState() {
    super.initState();
    _pet = _findPet(widget.petName);
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
              _buildDetailRow('Location:', _pet!.location),
              _buildDetailRow('Age:', '${_pet!.age} years'),
              _buildDetailRow('Description:', _pet!.description),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _adoptPet(context);
                },
                child: const Text('Adopt Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Pet _findPet(String petName) {
    return pets.firstWhere((pet) => pet.name == petName);
  }

  void _adoptPet(BuildContext context) {
    // Mark the pet as adopted
    _pet!.adopted = true;

    // Notify the home page that the pet has been adopted
    widget.onAdopted(widget.petName, true);

    // Navigate back to the home page
    Navigator.pop(context);
  }
}
