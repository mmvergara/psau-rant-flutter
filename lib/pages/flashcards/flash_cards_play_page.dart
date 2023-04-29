import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/pages/flashcards/flashcard.dart';

class PlayFlashCardPage extends StatefulWidget {
  final CardSet cardSet;
  final bool isShuffled;
  final bool termFirst;
  const PlayFlashCardPage(
      {super.key,
      required this.cardSet,
      required this.isShuffled,
      required this.termFirst});

  @override
  State<PlayFlashCardPage> createState() => _PlayFlashCardPageState();
}

class _PlayFlashCardPageState extends State<PlayFlashCardPage> {
  List<CardPiece> _cards = [];

  @override
  void initState() {
    super.initState();
    _cards = List.from(widget.cardSet.cardSetCards);
    if (widget.isShuffled) {
      _cards.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (BuildContext context, int index) {
          final flashCard = _cards[index];
          return FlashCard(
            frontText: widget.termFirst
                ? flashCard.cardTerm
                : flashCard.cardDefinition,
            backText: widget.termFirst
                ? flashCard.cardDefinition
                : flashCard.cardTerm,
          );
        },
      ),
    );
  }
}
