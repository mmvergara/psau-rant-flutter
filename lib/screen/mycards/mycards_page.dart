import 'package:flutter/material.dart';
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
        child: StreamBuilder(
          stream: AuthService().userStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something wen't wrong"));
            }
            if (snapshot.hasData) {
              return const MyCardsDashboard();
            }
            return SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Please Sign In to view your cards"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignInPage()),
                      );
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
