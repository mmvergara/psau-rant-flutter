import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/pages/flashcards/flashcard.dart';

class PlayFlashCardPage extends StatefulWidget {
  final List<Map<String, String>> flashCards;
  const PlayFlashCardPage({super.key, required this.flashCards});

  @override
  State<PlayFlashCardPage> createState() => _PlayFlashCardPageState();
}

class _PlayFlashCardPageState extends State<PlayFlashCardPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.flashCards.length,
        itemBuilder: (BuildContext context, int index) {
          final flashCard = widget.flashCards[index];
          return FlashCard(
            frontText: flashCard['front'].toString(),
            backText: flashCard['back'].toString(),
          );
        });
  }
}
