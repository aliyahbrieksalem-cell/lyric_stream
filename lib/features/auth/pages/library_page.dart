import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'song_player_page.dart'; 

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), 
      appBar: AppBar(
        title: const Text(
          "Lyriya Library", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('songs')
            .where('isFavorite', isEqualTo: true) 
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.deepPurple));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.library_music_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "Your library is empty.", 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Add your favorite songs from Explore!", 
                    style: TextStyle(color: Colors.grey)
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemBuilder: (context, index) {
              var song = snapshot.data!.docs[index];
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.music_note, color: Colors.white),
                  ),
                  title: Text(
                    song['title'], 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                  subtitle: Text(
                    song['artist'], 
                    style: const TextStyle(color: Colors.grey)
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      // Menghapus dari library
                      FirebaseFirestore.instance
                          .collection('songs')
                          .doc(song.id)
                          .update({'isFavorite': false});
                    },
                  ),
                  onTap: () {
                    // Masuk ke halaman Player
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongPlayerPage(songData: song),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}