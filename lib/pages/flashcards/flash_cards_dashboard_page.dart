import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/pages/flashcards/flash_cards_enter_id_page.dart';

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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EnterCardIDPage()),
          );
        },
      ),
      body: Column(
        children: const [
          Text("Flash Cards Dashboard"),
        ],
      ),
    );
  }
}
