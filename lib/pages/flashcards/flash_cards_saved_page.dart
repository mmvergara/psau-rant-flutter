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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          CardSet cardSet = cardSets[index];
          return ListTile(
            title: Text(cardSet.cardSetName),
            leading: const Icon(
              Icons.style,
              color: PsauColors.primaryGreen,
            ),
            subtitle: Text(cardSet.cardSetId),
            trailing: const Icon(Icons.delete, color: Colors.red),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return CardSetPreviewPage(cardSet: cardSet);
              }));
            },
            tileColor: PsauColors.creamBg,
          );
        },
        itemCount: cardSets.length);
  }
}
