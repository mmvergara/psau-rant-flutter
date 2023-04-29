import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class FlashCard extends StatefulWidget {
  final String frontText;
  final String backText;

  const FlashCard({super.key, required this.frontText, required this.backText});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;

  bool _isFrontVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);

    _frontRotation = Tween<double>(begin: 0, end: 180).animate(_controller);
    _backRotation = Tween<double>(begin: 180, end: 0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isFrontVisible) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        _isFrontVisible = !_isFrontVisible;
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final double rotationValue =
              _isFrontVisible ? _frontRotation.value : _backRotation.value;
          return Transform(
            transform: Matrix4.rotationY(rotationValue * 0.0174533),
            alignment: Alignment.center,
            child: _isFrontVisible
                ? _buildCard(widget.frontText, 800)
                : _buildCard(widget.backText, 900),
          );
        },
      ),
    );
  }

  Widget _buildCard(String text, int greenShade) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: PsauColors.primaryGreen,
      ),
      padding: const EdgeInsets.all(20),
      constraints: const BoxConstraints(minWidth: 200, minHeight: 200),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
