import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/rant_model.dart';
import 'package:psau_rant_flutter/screen/rants/rant.dart';
import 'package:psau_rant_flutter/services/rant_service.dart';
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
    return Scaffold(
      body: Container(
        color: PsauColors.creamBg,
        child: ListView.builder(
          itemCount: rants.length,
          itemBuilder: (context, index) {
            Rant rant = rants[index];
            return RantPiece(rant: rant);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Create Rant"),
        icon: const Icon(Icons.campaign),
        backgroundColor: PsauColors.primaryGreen,
      ),
    );
  }
}
