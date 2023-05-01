import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/models/card_set_model.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

Widget cardSetCard(
  void Function(CardSet) onTapPlayCardSet,
  void Function(int, CardSet) onTapDeleteCardSet,
  CardSet cardSet,
  int index,
) {
  return Card(
    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      title: GestureDetector(
        onTap: () => onTapPlayCardSet(cardSet),
        child: Text(
          cardSet.cardSetName,
          style: const TextStyle(
            color: PsauColors.primaryGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      leading: GestureDetector(
        onTap: () => onTapPlayCardSet(cardSet),
        child: const Icon(
          Icons.style,
          color: PsauColors.primaryGreen,
          size: 40,
        ),
      ),
      subtitle: GestureDetector(
        onTap: () => onTapPlayCardSet(cardSet),
        child: Text(cardSet.cardSetId),
      ),
      trailing: GestureDetector(
        onTap: () => onTapDeleteCardSet(index, cardSet),
        child: const Icon(
          Icons.delete,
          color: Color.fromARGB(255, 92, 33, 33),
        ),
      ),
    ),
  );
}
