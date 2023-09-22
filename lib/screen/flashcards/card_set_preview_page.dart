import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/screen/flashcards/play_flash_cards_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:psau_rant_flutter/util/sp_saved_card_sets.dart';

class CardSetPreviewPage extends StatefulWidget {
  final CardSet cardSet;
  final bool showSaveOffline;
  const CardSetPreviewPage({
    super.key,
    required this.cardSet,
    required this.showSaveOffline,
  });

  @override
  State<CardSetPreviewPage> createState() => _CardSetPreviewPageState();
}

class _CardSetPreviewPageState extends State<CardSetPreviewPage> {
  bool isShuffled = true;
  bool copiedToClipboard = false;
  String savingOfflineStatus = "Save Cards for Offline";

  void _playCard(bool questionFirst) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PlayFlashCardsPage(
          cardSet: widget.cardSet,
          isShuffled: isShuffled,
          questionFirst: questionFirst,
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

  void _copyToClipboard() {
    Clipboard.setData(
      ClipboardData(
        text: widget.cardSet.cardSetId,
      ),
    );
    setState(() {
      copiedToClipboard = true;
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // toggle switch shuffle or not widget with background color
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: PsauColors.primaryGreen,
                padding:
                    const EdgeInsets.only(top: 15.4, bottom: 15.4, left: 10),
                child: const Text(
                  "Shuffled",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                color: PsauColors.primaryGreen,
                child: Switch(
                  value: isShuffled,
                  onChanged: (value) {
                    setState(() {
                      isShuffled = value;
                    });
                  },
                  activeTrackColor: const Color.fromARGB(255, 245, 168, 45),
                  activeColor: Colors.yellow[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                PsauColors.ivory,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
            ),
            onPressed: () {},
            label: const Text("Flash Cards",
                style: TextStyle(color: Colors.black)),
            icon: const Icon(
              Icons.style_outlined,
              color: PsauColors.primaryGreen,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "decides which side of the card to show first",
            style: TextStyle(fontSize: 12, color: PsauColors.primaryGreen),
          ),
          const SizedBox(height: 5),
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
            child: const Text("Question First"),
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
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                PsauColors.ivory,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
            ),
            onPressed: () {},
            label: const Text("More Options",
                style: TextStyle(color: Colors.black)),
            icon: const Icon(
              Icons.tune,
              color: PsauColors.primaryGreen,
            ),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                copiedToClipboard
                    ? Colors.green[800]!
                    : PsauColors.primaryGreen,
              ),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
            ),
            onPressed: _copyToClipboard,
            label: Text(
              copiedToClipboard ? "Copied!" : "Copy Card ID to clipboard",
            ),
            icon: Icon(copiedToClipboard ? Icons.copy_all_outlined : Icons.copy,
                size: 16),
          ),
          widget.showSaveOffline
              ? ElevatedButton.icon(
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
                  label: Text(savingOfflineStatus),
                  icon: Icon(
                    savingOfflineStatus == "Saved!"
                        ? Icons.check
                        : Icons.download,
                    size: 16,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
