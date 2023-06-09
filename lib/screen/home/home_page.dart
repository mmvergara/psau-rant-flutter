import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psau_rant_flutter/models/rant_model.dart';
import 'package:psau_rant_flutter/screen/home/create_rant.dart';
import 'package:psau_rant_flutter/screen/home/rant.dart';
import 'package:psau_rant_flutter/services/rant_service.dart';
import 'package:psau_rant_flutter/shared/please_sign_in.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Rant> rants = [];

  @override
  void initState() {
    super.initState();
    _loadRants();
  }

  void _loadRants() async {
    List<Rant> fetchedRants = await RantService.getMostRecentRants(10);
    setState(() {
      rants = fetchedRants;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);

    return Scaffold(
      body: user != null
          ? Container(
              color: PsauColors.creamBg,
              child: ListView.builder(
                itemCount: rants.length,
                itemBuilder: (context, index) {
                  Rant rant = rants[index];
                  return RantPiece(
                    rant: rant,
                    uid: user.uid,
                  );
                },
              ),
            )
          : Container(
              color: PsauColors.creamBg,
              child: pleaseSignInUI(context, "Please sign in to view rants.")),
      floatingActionButton: user != null
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateRantPage()),
                );
              },
              label: const Text("Create Rant"),
              icon: const Icon(Icons.campaign),
              backgroundColor: PsauColors.primaryGreen,
            )
          : Container(),
    );
  }
}
