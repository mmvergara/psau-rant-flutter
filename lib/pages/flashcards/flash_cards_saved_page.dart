import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class SavedCardsPage extends StatefulWidget {
  const SavedCardsPage({super.key});
  @override
  State<SavedCardsPage> createState() => _SavedCardsPageState();
}

class _SavedCardsPageState extends State<SavedCardsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        ListTile(
          title: Text('Saved Cards'),
          leading: Icon(
            Icons.style,
            color: PsauColors.primaryGreen,
          ),
          subtitle: Text("CARD ID: 1"),
          trailing: Icon(Icons.delete, color: Colors.red),
          tileColor: PsauColors.creamBg,
        ),
      ],
    );
  }
}
