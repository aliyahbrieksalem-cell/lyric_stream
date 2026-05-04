import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'song_player_page.dart'; 

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1233),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Explore New Music", 
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),

            // Search Bar
            TextField(
              onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search songs...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurpleAccent),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), 
                  borderSide: BorderSide.none
                ),
              ),
            ),
            const SizedBox(height: 20),

            // StreamBuilder: Mengambil data real-time dari Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('songs').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                  // Filter lagu berdasarkan search query
                  var docs = snapshot.data!.docs.where((doc) {
                    return doc['title'].toString().toLowerCase().contains(searchQuery);
                  }).toList();

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      childAspectRatio: 0.8, 
                      crossAxisSpacing: 15, 
                      mainAxisSpacing: 15,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var song = docs[index];
                      return _buildSongCard(context, song);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget kartu lagu dengan background foto artis
  Widget _buildSongCard(BuildContext context, QueryDocumentSnapshot doc) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongPlayerPage(songData: doc),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            // Mengambil path gambar dari Firebase (imageUrl)
            image: AssetImage(doc['imageUrl']), 
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // Lapisan gradien supaya teks terbaca jelas di atas gambar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.8), // Gelap di bagian bawah
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  doc['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                  ),
                ),
              ),
              Text(
                doc['artist'],
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}