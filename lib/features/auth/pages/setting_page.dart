import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.hitamUtama,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 20, 64),
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // --- ISI SETTINGS DIMULAI DI SINI ---
      body: ListView(
        children: [
          _sectionHeader("Account"),
          _buildSettingItem(Icons.person_outline, "Edit Profile", () {}),
          _buildSettingItem(Icons.lock_outline, "Change Password", () {}),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.grey, thickness: 0.5),
          ),
          
          _sectionHeader("Audio & Display"),
          _buildSettingItem(Icons.high_quality, "Audio Quality", () {}),
          _buildSettingItem(Icons.dark_mode_outlined, "Theme Mode", () {}),
          
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: Colors.grey, thickness: 0.5),
          ),
          
          _sectionHeader("About"),
          _buildSettingItem(Icons.info_outline, "Version 1.0.0", null),
        ],
      ),
    );
  }

  // Fungsi untuk judul kategori (Account, Audio, dll)
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.lavenderAksen,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Fungsi untuk item menu settings
  Widget _buildSettingItem(IconData icon, String title, VoidCallback? onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: onTap != null 
          ? const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16)
          : null, // Kalau onTap null (kayak di Version), panahnya hilang
      onTap: onTap,
    );
  }
}