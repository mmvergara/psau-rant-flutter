import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

class MyCardsDashboard extends StatefulWidget {
  const MyCardsDashboard({super.key});

  @override
  State<MyCardsDashboard> createState() => _MyCardsDashboardState();
}

class _MyCardsDashboardState extends State<MyCardsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: PsauColors.creamBg,
      child: Column(
        children: const [
          Text("Flash Cards Dashboard"),
        ],
      ),
    );
  }
}
