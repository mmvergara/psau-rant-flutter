import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psau_rant_flutter/models/rant_model.dart';
import 'package:psau_rant_flutter/services/rant_service.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class RantPiece extends StatefulWidget {
  final Rant rant;
  final String? uid;
  const RantPiece({super.key, required this.rant, this.uid});

  @override
  State<RantPiece> createState() => RantPieceState();
}

class RantPieceState extends State<RantPiece> {
  bool isLiked = false;
  int likesLength = 0;
  bool isVisible = true;

  Future<void> handleLikeClick() async {
    if (widget.uid == null) return;
    bool res = await RantService.handleLikeRant(
        widget.rant.rantId, isLiked, widget.uid!);
    if (!res) return;
    if (isLiked) {
      setState(() {
        isLiked = false;
        likesLength--;
      });
    } else {
      setState(() {
        isLiked = true;
        likesLength++;
      });
    }
  }

  Future<void> handleDeleteRant() async {
    if (widget.uid == null) return;
    bool res = await RantService.deleteRant(widget.rant.rantId);
    if (!res) return;
    setState(() {
      isVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    likesLength = widget.rant.rantLikes.length;
    isLiked = widget.rant.rantLikes.containsValue(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    bool isOwner = user?.uid == widget.rant.rantAuthorId;

    if (!isVisible) return Container();

    return Card(
      elevation: 3,
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
              color: PsauColors.primaryGreen,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.rant.rantTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                // Delete Rant Button
                Visibility(
                  visible: isOwner,
                  child: GestureDetector(
                    onTap: handleDeleteRant,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(3)),
              color: PsauColors.sleekGreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    widget.rant.rantContent,
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.rant.rantDate,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        onPressed: handleLikeClick,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.red[800]!,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 20),
                            const SizedBox(width: 5),
                            Text(likesLength.toString()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
