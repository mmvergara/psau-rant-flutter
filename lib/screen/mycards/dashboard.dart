import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/screen/flashcards/card_set_preview_page.dart';
import 'package:psau_rant_flutter/services/card_set_service.dart';
import 'package:psau_rant_flutter/shared/cardset_card.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class MyCardsDashboard extends StatefulWidget {
  final String uid;
  const MyCardsDashboard({super.key, required this.uid});

  @override
  State<MyCardsDashboard> createState() => _MyCardsDashboardState();
}

class _MyCardsDashboardState extends State<MyCardsDashboard> {
  bool _isLoading = true;
  List<CardSet> _cardSets = [];

  @override
  void initState() {
    super.initState();
    _loadUserCardSets();
  }

  void _loadUserCardSets() async {
    List<CardSet>? fetchCardSets =
        await CardSetService(uid: widget.uid).fetchUserCardSetsByUserId();
    setState(() {
      _isLoading = false;
    });

    if (fetchCardSets == null) return;
    setState(() {
      _cardSets = fetchCardSets;
    });
  }

  void _playCardSet(CardSet cardSet) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CardSetPreviewPage(
          cardSet: cardSet,
          showSaveOffline: true,
        ),
      ),
    );
  }

  void _deleteCardSet(int index, CardSet cardSet) async {
    bool result = await CardSetService(uid: widget.uid)
        .deleteCardSetById(cardSet.cardSetId);
    if (result == true) {
      setState(() {
        _cardSets.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading && _cardSets.isEmpty
        ? const Center(
            child: Text(
              'No card sets found',
              style: TextStyle(
                color: PsauColors.primaryGreen,
                fontSize: 20,
              ),
            ),
          )
        : Container(
            width: double.infinity,
            color: PsauColors.creamBg,
            child: ListView.builder(
              itemCount: _cardSets.length,
              itemBuilder: (context, index) {
                CardSet cardSet = _cardSets[index];
                return cardSetCard(
                    _playCardSet, _deleteCardSet, cardSet, index);
              },
            ),
          );
  }
}
