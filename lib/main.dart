import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lyric_stream/core/app_colors.dart';
import 'package:lyric_stream/features/auth/pages/home_page.dart';
import 'package:lyric_stream/features/auth/pages/explorer_page.dart';
import 'package:lyric_stream/features/auth/pages/library_page.dart';
import 'package:lyric_stream/features/auth/pages/profile_page.dart';
import 'package:lyric_stream/features/auth/pages/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // 1. Tambahkan ini
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Tambahkan inisialisasi ini
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Lyriya',
    home: MainPage(userEmail: "user@lyriya.com"),
  ));
}

class MainPage extends StatefulWidget {
  final String userEmail;
  const MainPage({super.key, required this.userEmail});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(userEmail: widget.userEmail), 
      ExplorePage(), 
      LibraryPage(),
      ProfilePage(userEmail: widget.userEmail), 
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.hitamUtama,
        selectedItemColor: AppColors.lavenderAksen,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.library_music), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
