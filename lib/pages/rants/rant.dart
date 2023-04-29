import 'package:flutter/material.dart';

class RantPiece extends StatefulWidget {
  const RantPiece({super.key});

  @override
  State<RantPiece> createState() => RantPieceState();
}

class RantPieceState extends State<RantPiece> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(3)),
                color: Colors.green[800],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Autha",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              )),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: const Text(
                    "lorem sadas asd sad sa d",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "12/12/2021",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    IconButton(
                      onPressed: () {},
                      color: Colors.red[800],
                      padding: const EdgeInsets.all(0),
                      constraints: const BoxConstraints(),
                      iconSize: 20,
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
