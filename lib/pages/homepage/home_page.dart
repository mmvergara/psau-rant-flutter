import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/rant_model.dart';
import 'package:psau_rant_flutter/pages/rants/rant.dart';
import 'package:psau_rant_flutter/services/rant_service.dart';

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
        body: ListView.builder(
      itemCount: rants.length,
      itemBuilder: (context, index) {
        Rant rant = rants[index];
        return RantPiece(rant: rant);
      },
    ));
  }
}
