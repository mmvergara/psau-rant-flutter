import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/pages/flashcards/flashcard.dart';
import 'package:psau_rant_flutter/pages/rants/rant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        FlashCard(backText: "UUOOUO", frontText: "OOUOUO FRONT"),
        FlashCard(backText: "UUOOUO", frontText: "OOUOUO FRONT"),
        FlashCard(backText: "UUOOUO", frontText: "OOUOUO FRONT"),
        FlashCard(backText: "UUOOUO", frontText: "OOUOUO FRONT"),
        FlashCard(backText: "UUOOUO", frontText: "OOUOUO FRONT"),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
        RantPiece(),
      ]),
    );
  }
}
