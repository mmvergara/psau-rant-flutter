import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/services/card_set_service.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class MyCardsDashboard extends StatefulWidget {
  final String uid;
  const MyCardsDashboard({super.key, required this.uid});

  @override
  State<MyCardsDashboard> createState() => _MyCardsDashboardState();
}

class _MyCardsDashboardState extends State<MyCardsDashboard> {
  bool _isLoading = true;
  List<CardSet> _cardSets = [];

  @override
  void initState() {
    super.initState();
    _loadUserCardSets();
  }

  void _loadUserCardSets() async {
    List<CardSet>? fetchCardSets =
        await CardSetService(uid: widget.uid).fetchUserCardSetsByUserId();
    setState(() {
      _isLoading = false;
    });

    if (fetchCardSets == null) return;
    setState(() {
      _cardSets = fetchCardSets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PsauColors.creamBg,
      child: Column(
        children: [
          const Text("Flash Cards Dashboard"),
          Text(_cardSets.length.toString())
        ],
      ),
    );
  }
}
