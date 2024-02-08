import 'package:flutter/material.dart';
import 'package:petsync/detailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key); // Corrected syntax

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Pet Sync'),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DetailsPage()),
            );
          },
          child: const Text('View Details'),
        ),
        // Implement your home page UI here
      ),
    );
  }
}
