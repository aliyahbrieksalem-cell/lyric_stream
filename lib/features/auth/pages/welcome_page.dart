import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1233), // Warna ungu gelap
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Musik Gede (Kotaknya dihapus sesuai request)
            const Icon(
              Icons.music_note_rounded, 
              color: Colors.deepPurpleAccent, 
              size: 120, // Ukuran lebih gede
            ),
            
            const SizedBox(height: 20),
            
            // Judul LYRIYA
            const Text(
              "LYRIYA",
              style: TextStyle(
                fontSize: 55, // Agak digedein biar mantap
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 10,
              ),
            ),
            
            const Text(
              "FEEL THE LYRICS",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                letterSpacing: 4,
              ),
            ),
            
            const SizedBox(height: 80),
            
            // Tombol GET STARTED
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6222CC), // Ungu tombol
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                elevation: 15,
                shadowColor: Colors.deepPurpleAccent.withOpacity(0.4),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                "GET STARTED",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}