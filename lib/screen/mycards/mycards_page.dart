import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psau_rant_flutter/screen/auth/signin_page.dart';
import 'package:psau_rant_flutter/screen/flashcards/enter_cardset_id_page.dart';
import 'package:psau_rant_flutter/screen/mycards/dashboard.dart';
import 'package:psau_rant_flutter/services/auth_service.dart';
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
            : SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "Please sign in to view your cards. ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: PsauColors.primaryGreen,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignInPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PsauColors.primaryGreen,
                        fixedSize: const Size(215, 30),
                      ),
                      child: const Text("Sign In 👑"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
