import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/screen/flashcards/enter_cardset_id_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
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
      body: Container(
        width: double.infinity,
        color: PsauColors.creamBg,
        child: Column(
          children: const [
            Text("Flash Cards Dashboard"),
          ],
        ),
      ),
    );
  }
}
