import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/screen/flashcards/card_set_preview_page.dart';
import 'package:psau_rant_flutter/shared/cardset_card.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:psau_rant_flutter/util/sp_saved_card_sets.dart';

class SavedCardSetsPage extends StatefulWidget {
  const SavedCardSetsPage({super.key});
  @override
  State<SavedCardSetsPage> createState() => _SavedCardSetsPageState();
}

class _SavedCardSetsPageState extends State<SavedCardSetsPage> {
  List<CardSet> cardSets = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCardSets();
  }

  void _loadSavedCardSets() async {
    List<CardSet> savedCardSets =
        await SavedCardSetsPreferences.getAllCardSets();
    setState(() {
      cardSets = savedCardSets;
    });
  }

  void _playCardSet(CardSet cardSet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardSetPreviewPage(
          cardSet: cardSet,
          showSaveOffline: false,
        ),
      ),
    );
  }

  void _removeCardSet(int index, CardSet cardSet) async {
    await SavedCardSetsPreferences.removeCardSet(cardSet);
    setState(() {
      cardSets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PsauColors.creamBg,
      child: ListView.builder(
          itemBuilder: (context, index) {
            CardSet cardSet = cardSets[index];
            return cardSetCard(_playCardSet, _removeCardSet, cardSet, index);
          },
          itemCount: cardSets.length),
    );
  }
}
