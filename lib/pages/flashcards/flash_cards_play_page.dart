import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/cardset_model.dart';
import 'package:psau_rant_flutter/pages/flashcards/flashcard.dart';

class PlayFlashCardPage extends StatefulWidget {
  final CardSet cardSet;
  const PlayFlashCardPage({super.key, required this.cardSet});

  @override
  State<PlayFlashCardPage> createState() => _PlayFlashCardPageState();
}

class _PlayFlashCardPageState extends State<PlayFlashCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: widget.cardSet.cardSetCards.length,
        itemBuilder: (BuildContext context, int index) {
          final flashCard = widget.cardSet.cardSetCards[index];
          return FlashCard(
            frontText: flashCard.cardDefinition,
            backText: flashCard.cardTerm,
          );
        },
      ),
    );
  }
}
