import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/screen/auth/signin_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

Widget pleaseSignInUI(BuildContext context, String message) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      children: [
        const SizedBox(height: 40),
        Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PsauColors.primaryGreen,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SignInPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PsauColors.primaryGreen,
            fixedSize: const Size(215, 30),
          ),
          child: const Text("Sign In 👑"),
        ),
      ],
    ),
  );
}
