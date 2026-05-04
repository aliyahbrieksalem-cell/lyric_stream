import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../auth/pages/login_page.dart';
import 'setting_page.dart'; 

class ProfilePage extends StatelessWidget {
  final String userEmail;

  const ProfilePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna background utama aplikasi kamu
      backgroundColor: AppColors.hitamUtama, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // --- HEADER: FOTO PROFIL ---
            Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.lavenderAksen, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFF2A1643),
                      child: Icon(Icons.person, size: 70, color: Colors.white),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.lavenderAksen,
                      child: const Icon(Icons.edit, size: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // --- INFO USER ---
            const Text(
              'User Lyriya',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              userEmail,
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            
            const SizedBox(height: 40),

            // --- MENU LIST ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E), // Box agak terang dikit
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _buildProfileMenu(Icons.settings_outlined, "Settings", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsPage()),
                    );
                  }),
                  const Divider(color: Colors.grey, height: 1),
                  _buildProfileMenu(Icons.favorite_border, "My Favorites", () {
                     ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Silakan buka tab Library!"),
                        backgroundColor: AppColors.deepPurple,
                      ),
                    );
                  }),
                  const Divider(color: Colors.grey, height: 1),
                  _buildProfileMenu(Icons.info_outline, "About Lyriya", () {}),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // --- TOMBOL LOGOUT ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Tambahkan konfirmasi logout jika perlu
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('LOGOUT', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withOpacity(0.1),
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu(IconData icon, String title, VoidCallback onClick) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.lavenderAksen.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.lavenderAksen, size: 22),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
      onTap: onClick,
    );
  }
}