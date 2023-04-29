import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/screen/flashcards/flashcard.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class PlayFlashCardsPage extends StatefulWidget {
  final CardSet cardSet;
  final bool isShuffled;
  final bool termFirst;
  const PlayFlashCardsPage(
      {super.key,
      required this.cardSet,
      required this.isShuffled,
      required this.termFirst});

  @override
  State<PlayFlashCardsPage> createState() => _PlayFlashCardsPageState();
}

class _PlayFlashCardsPageState extends State<PlayFlashCardsPage> {
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
        appBar: AppBar(
          title: Text(widget.cardSet.cardSetName),
          backgroundColor: PsauColors.primaryGreen,
        ),
        body: Container(
          color: PsauColors.creamBg,
          child: ListView.builder(
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
        ));
  }
}
