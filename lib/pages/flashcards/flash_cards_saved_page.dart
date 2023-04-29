import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/pages/flashcards/flash_cards_preview_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:psau_rant_flutter/util/sp_saved_card_sets.dart';

class SavedCardsPage extends StatefulWidget {
  const SavedCardsPage({super.key});
  @override
  State<SavedCardsPage> createState() => _SavedCardsPageState();
}

class _SavedCardsPageState extends State<SavedCardsPage> {
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          CardSet cardSet = cardSets[index];
          return ListTile(
            title: GestureDetector(
              onTap: () => _playCardSet(cardSet),
              child: Text(cardSet.cardSetName),
            ),
            leading: GestureDetector(
                onTap: () => _playCardSet(cardSet),
                child: const Icon(
                  Icons.style,
                  color: PsauColors.primaryGreen,
                )),
            subtitle: GestureDetector(
              onTap: () => _playCardSet(cardSet),
              child: Text(cardSet.cardSetId),
            ),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  cardSets.removeAt(index);
                });
                SavedCardSetsPreferences.removeCardSet(cardSet);
              },
              child: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 92, 33, 33),
              ),
            ),
            tileColor: PsauColors.creamBg,
          );
        },
        itemCount: cardSets.length);
  }
}
