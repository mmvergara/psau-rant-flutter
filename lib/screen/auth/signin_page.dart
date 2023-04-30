import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:psau_rant_flutter/services/auth_service.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  _signInWithGoogle() async {
    await AuthService().firebaseGoogleLogin();
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PSAU Rant"),
        backgroundColor: PsauColors.primaryGreen,
      ),
      // create sign in ui
      body: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: PsauColors.primaryGreen,
              ),
            ),
            const Divider(),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: PsauColors.primaryGreen,
                fixedSize: const Size(215, 30),
              ),
              child: const Text('Sign In'),
            ),
            SignInButton(Buttons.GoogleDark, onPressed: _signInWithGoogle),
            const SizedBox(height: 15),
            const Divider(),
            TextButton(
              onPressed: () async {
                Uri url = Uri.parse("https://psaurant.vercel.app/auth/signup");
                try {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                } catch (e) {
                  return;
                }
              },
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(PsauColors.primaryGreen),
              ),
              child: const Text("Don't have an account? Sign up here"),
            )
          ],
        ),
      ),
    );
  }
}
