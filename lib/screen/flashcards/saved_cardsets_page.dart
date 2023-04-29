import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/screen/flashcards/card_set_preview_page.dart';
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
