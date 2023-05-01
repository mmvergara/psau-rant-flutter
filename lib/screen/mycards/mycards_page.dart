import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psau_rant_flutter/screen/flashcards/enter_cardset_id_page.dart';
import 'package:psau_rant_flutter/screen/mycards/dashboard.dart';
import 'package:psau_rant_flutter/shared/please_sign_in.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class MyCardsPage extends StatefulWidget {
  const MyCardsPage({super.key});

  @override
  State<MyCardsPage> createState() => _MyCardsPageState();
}

class _MyCardsPageState extends State<MyCardsPage> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.style_outlined),
        label: const Text("Play Card by ID"),
        backgroundColor: Colors.amber[700],
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EnterCardIDPage()),
          );
        },
      ),
      body: Container(
        color: PsauColors.creamBg,
        child: user != null
            ? MyCardsDashboard(uid: user.uid)
            : pleaseSignInUI(context, "Please sign in to view your cards.")
      ),
    );
  }
}
