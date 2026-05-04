import 'package:flutter/material.dart';
import 'home_page.dart';
import 'explorer_page.dart'; // 1. Pastikan nama filenya benar (explore_page.dart)
import 'library_page.dart';
// import 'profile_page.dart'; // Aktifkan kalau file profile_page.dart sudah ada

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(userEmail: "aliyah@lyriya.com"), 
    const ExplorePage(), // 2. SESUAIKAN: Pakai ExplorePage() bukan ExplorerPage()
    const LibraryPage(),
    const Scaffold(body: Center(child: Text("Profile Page", style: TextStyle(color: Colors.white)))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0D0C0C),
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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