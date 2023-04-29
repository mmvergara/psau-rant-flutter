import 'package:flutter/material.dart';

class FlashCardsDashboardPage extends StatefulWidget {
  const FlashCardsDashboardPage({super.key});

  @override
  State<FlashCardsDashboardPage> createState() =>
      _FlashCardsDashboardPageState();
}

class _FlashCardsDashboardPageState extends State<FlashCardsDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.style_outlined),
        label: const Text("Play Card by ID"),
        backgroundColor: Colors.amber[700],
        onPressed: () {},
      ),
      body: Column(
        children: const [
          Text("Flash Cards Dashboard"),
        ],
      ),
    );
  }
}
