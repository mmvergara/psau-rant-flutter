import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:psau_rant_flutter/pages/flashcards/flash_cards_dashboard_page.dart';
import 'package:psau_rant_flutter/pages/homepage/home_page.dart';
import 'package:psau_rant_flutter/pages/saved_cards_page.dart';
import 'package:psau_rant_flutter/theme/psau_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    const FlashCardsDashboardPage(),
    const SavedCards(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PSAU Rant"),
          backgroundColor: PsauColors.primaryGreen,
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
              // if (!(!authenticated && value == 1)) {
              _selectedPage = value;
              // }
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
