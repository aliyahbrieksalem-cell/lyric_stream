import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String userEmail;
  const HomePage({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1233), // Warna gelap elegan
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            
            // Header User Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hello,", style: TextStyle(color: Colors.grey, fontSize: 16)),
                    Text(
                      userEmail.split('@')[0], 
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                )
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Banner Promo
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Colors.indigo, Colors.deepPurple]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Discover New Music", 
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Explore thousands of lyrics and feel the rhythm of your soul.", 
                    style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {}, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, 
                      foregroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("Go to Library"),
                  )
                ],
              ),
            ),

            const SizedBox(height: 30),
            
            // Section: Popular Artists (Visual sesuai image_9cdfcf.jpg)
            const Text("Popular Artists", 
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildArtistCircle("Nancy Ajram", "assets/Nancy.png"),
                  _buildArtistCircle("Sherine", "assets/Sherine.png"), 
                  _buildArtistCircle("Amr Diab", "assets/amr.jpg"),
                  _buildArtistCircle("Abeer Nehme", "assets/Abeer.jpg"), 
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Section: Top Playlists (Biar makin keren dan penuh)
            const Text("Top Playlists", 
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            _buildSongItem("Chill Vibes", "Relax and enjoy the lyrics", Icons.music_note),
            _buildSongItem("Arabic Pop", "Top hits from Nancy & Amr", Icons.star),

            const SizedBox(height: 30),

            // Recent Activity Section
            const Text("Recent Activity", 
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ListTile(
                leading: Icon(Icons.history, color: Colors.grey),
                title: Text("You recently viewed lirik Nancy Ajram", 
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              ),
            ),
            const SizedBox(height: 100), // Spasi tambahan buat navigasi bawah
          ],
        ),
      ),
    );
  }

  // Fungsi untuk Artist Circle (Assets)
  Widget _buildArtistCircle(String name, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white10,
            backgroundImage: AssetImage(imagePath),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk Playlist Item
  Widget _buildSongItem(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        trailing: const Icon(Icons.play_arrow_rounded, color: Colors.white),
        onTap: () {},
      ),
    );
  }
}