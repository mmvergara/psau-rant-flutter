import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/pages/flashcards/flash_cards_play_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:psau_rant_flutter/util/sp_saved_card_sets.dart';

class CardSetPreviewPage extends StatefulWidget {
  final CardSet cardSet;
  const CardSetPreviewPage({super.key, required this.cardSet});

  @override
  State<CardSetPreviewPage> createState() => _CardSetPreviewPageState();
}

class _CardSetPreviewPageState extends State<CardSetPreviewPage> {
  bool isShuffled = true;
  String savingOfflineStatus = "Save Cards for Offline";

  void _playCard(bool termFirst) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlayFlashCardPage(
          cardSet: widget.cardSet,
          isShuffled: isShuffled,
          termFirst: termFirst,
        ),
      ),
    );
  }

  void _savedCardToSP() async {
    if (savingOfflineStatus != "Save Cards for Offline") return;
    setState(() {
      savingOfflineStatus = "Saving...";
    });
    await SavedCardSetsPreferences.addCardSet(widget.cardSet);
    setState(() {
      savingOfflineStatus = "Saved!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsauColors.creamBg,
      appBar: AppBar(
        title: const Text("Card Set Preview"),
        backgroundColor: PsauColors.primaryGreen,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 10),
            child: Text(
              " ${widget.cardSet.cardSetName}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // toggle switch shuffle or not widget with background color
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Shuffled",
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  value: isShuffled,
                  onChanged: (value) {
                    setState(() {
                      isShuffled = value;
                    });
                  },
                  activeTrackColor: PsauColors.primaryGreen,
                  activeColor: Colors.green[800],
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                PsauColors.primaryGreen,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
            ),
            onPressed: () {
              _playCard(true);
            },
            child: const Text("Term First"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                PsauColors.primaryGreen,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
            ),
            onPressed: () {
              _playCard(false);
            },
            child: const Text("Definition First"),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                savingOfflineStatus == "Saved!"
                    ? Colors.green[800]!
                    : PsauColors.primaryGreen,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
            ),
            onPressed: _savedCardToSP,
            child: Text(savingOfflineStatus),
          ),
        ],
      ),
    );
  }
}
