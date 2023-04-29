import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/screen/flashcards/saved_cardsets_page.dart';
import 'package:psau_rant_flutter/screen/home/home_page.dart';
import 'package:psau_rant_flutter/screen/mycards/mycards_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';
import 'package:psau_rant_flutter/util/sp_saved_card_sets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SavedCardSetsPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  bool authenticated = false;

  static final List<Widget> _pages = <Widget>[
    const HomePage(),
    const MyCardsPage(),
    const SavedCardSetsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PSAU Rant"),
          backgroundColor: PsauColors.primaryGreen,
          actions: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.login),
              label: const Text("Sign In"),
              style: ElevatedButton.styleFrom(
                backgroundColor: PsauColors.primaryGreen,
                foregroundColor: PsauColors.creamBg,
                maximumSize: const Size(100, 100),
                padding: const EdgeInsets.only(right: 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
            )
          ],
        ),
        body: _pages[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedFontSize: 12,
          backgroundColor: PsauColors.primaryGreen,
          fixedColor: Colors.yellow[800],
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          currentIndex: _selectedPage,
          onTap: (value) {
            setState(() {
              _selectedPage = value;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_carousel),
              label: 'My Cards',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.style),
              label: 'Saved Cards',
            ),
          ],
        ));
  }
}
