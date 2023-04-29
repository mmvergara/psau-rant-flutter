import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EnterCardIDPage extends StatefulWidget {
  const EnterCardIDPage({super.key});

  @override
  State<EnterCardIDPage> createState() => _EnterCardIDPageState();
}

class _EnterCardIDPageState extends State<EnterCardIDPage> {
  final _textEditingController = TextEditingController();
  String _cardID = "aaa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Card ID"),
      ),
      body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter text',
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
                  onPressed: () {
                    setState(() {
                      _cardID = _textEditingController.text;
                    });
                  },
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
              Text(_cardID)
            ],
          )),
    );
  }
}
