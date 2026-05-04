import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LyricsPage extends StatelessWidget {
  final String title;
  final String lyrics;
  final String docId; // Tambahkan ini untuk identitas lagu di Firebase

  const LyricsPage({
    super.key, 
    required this.title, 
    required this.lyrics, 
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1233),
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        actions: [
          // TOMBOL FAVORIT DI POJOK KANAN ATAS
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('songs').doc(docId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              
              bool isFavorite = false;
              try {
                isFavorite = snapshot.data!.get('isFavorite') ?? false;
              } catch (e) {
                isFavorite = false; // Kalau field-nya belum ada, anggap saja false (nggak error)
              }

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  // Update status favorit di Firebase
                  FirebaseFirestore.instance.collection('songs').doc(docId).update({
                    'isFavorite': !isFavorite,
                  });

                  // Notifikasi kecil
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(!isFavorite ? "Added to Library" : "Removed from Library"),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              );
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Center(
              child: Icon(Icons.music_note, size: 80, color: Colors.deepPurpleAccent),
            ),
            const SizedBox(height: 20),
            
            // Judul Lagu
            Text(
              title, 
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 10),
            const Text(
              "Lyrics", 
              style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.w500),
            ),
            
            const Divider(color: Colors.white24, height: 40, thickness: 1),
            
            // Teks Lirik
            Text(
              lyrics, 
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70, 
                fontSize: 18, 
                height: 1.8, // Jarak antar baris biar enak dibaca
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}