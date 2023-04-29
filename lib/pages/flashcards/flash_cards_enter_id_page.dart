import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/pages/flashcards/flash_cards_preview_page.dart';
import 'package:psau_rant_flutter/services/cards_service.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class EnterCardIDPage extends StatefulWidget {
  const EnterCardIDPage({super.key});

  @override
  State<EnterCardIDPage> createState() => _EnterCardIDPageState();
}

class _EnterCardIDPageState extends State<EnterCardIDPage> {
  final _textEditingController = TextEditingController();
  String status = "";
  final CardSService cservice = CardSService(uid: "");

  void _onSubmit() async {
    setState(() {
      status = "Loading...";
    });
    String cardID = _textEditingController.text;
    CardSet? cardSet = await cservice.fetchCardSetById(cardID);
    if (cardSet == null) {
      setState(() {
        status = "Card ID not found \n or \n Something wen't wrong";
        _textEditingController.text = "";
      });
      return;
    }
    setState(() {
      status = "";
      _textEditingController.text = "";
    });

    if (!mounted) return;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PsauColors.primaryGreen,
        title: const Text("Enter Card ID"),
      ),
      body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Card ID',
                    constraints: BoxConstraints(maxWidth: 200)),
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    final clipboardData = await Clipboard.getData('text/plain');
                    if (clipboardData != null && clipboardData.text != null) {
                      _textEditingController.text = clipboardData.text!;
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.content_paste_go),
                      SizedBox(width: 5),
                      Text(
                        'Paste from Clipboard',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 200,
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        PsauColors.primaryGreen),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.send),
                      SizedBox(width: 5),
                      Text(
                        'Submit Card ID',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
