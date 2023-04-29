import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/cardset_model.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class CardSetPreviewPage extends StatefulWidget {
  final CardSet cardSet;
  const CardSetPreviewPage({super.key, required this.cardSet});

  @override
  State<CardSetPreviewPage> createState() => _CardSetPreviewPageState();
}

class _CardSetPreviewPageState extends State<CardSetPreviewPage> {
  bool isShuffled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PsauColors.creamBg,
      appBar: AppBar(
        title: const Text("Card Set Preview"),
        backgroundColor: PsauColors.primaryGreen,
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 50, bottom: 20),
          color: Colors.lightGreen[600],
          child: Text(
            "Card Set \n ${widget.cardSet.cardSetName} lorem lorem me mem ",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ]),
    );
  }
}
