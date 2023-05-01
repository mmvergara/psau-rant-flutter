import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psau_rant_flutter/services/auth_service.dart';
import 'package:psau_rant_flutter/services/rant_service.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateRantPage extends StatefulWidget {
  const CreateRantPage({super.key});

  @override
  State<CreateRantPage> createState() => _CreateRantPageState();
}

class _CreateRantPageState extends State<CreateRantPage> {
  final _titleInputController = TextEditingController();
  final _contentInputController = TextEditingController();

  String _status = "";
  bool _loading = false;

  Future<void> _submitRant(String? uid) async {
    if (_loading) return;
    if (uid == null) return;

    // Validate fields
    String title = _titleInputController.text;
    String content = _contentInputController.text;
    if (title.isEmpty ||
        content.isEmpty ||
        title.length > 50 ||
        content.length > 500 ||
        title.length < 5 ||
        content.length < 5) {
      setState(() => {
            _status = "Invalid fields",
            _loading = false,
          });
      return;
    }

    // Begin Loading State
    setState(() {
      _status = "Creating rant...";
      _loading = true;
    });

    // Fetch Username from uid
    String? username = await AuthService().fetchUsernameByUid(uid);
    if (username == null) {
      setState(() => {
            _status = "Error | Username not set",
            _loading = false,
          });
      return;
    }

    // Create Rant
    bool res = await RantService.createRant(title, content, uid, username);
    setState(() => {
          _status = res ? "Rant created!" : "Error creating rant",
          _loading = false,
        });

    // Pop Page if successful
    if (!res) return;
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("PSAU Rant"),
        backgroundColor: PsauColors.primaryGreen,
      ),
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            const Text(
              "Create Rant 😐",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: PsauColors.primaryGreen,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16.0),
            TextField(
              controller: _titleInputController,
              decoration: const InputDecoration(
                labelText: 'Rant Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentInputController,
              decoration: const InputDecoration(
                labelText: 'Rant 💢',
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _submitRant(user?.uid),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _loading ? Colors.grey : PsauColors.primaryGreen,
                fixedSize: const Size(200, 30),
              ),
              label: const Text('Submit Rant'),
              icon: const Icon(Icons.campaign),
            ),
            Text(_status),
            Visibility(
              visible: _status == 'Error | Username not set',
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text:
                      "Please set one by signing in the Web version of PSAU Rant ",
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Uri url =
                          Uri.parse("https://psaurant.vercel.app/auth/signin");
                      launchUrl(url);
                    },
                  text: "psaurant.vercel.app",
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
