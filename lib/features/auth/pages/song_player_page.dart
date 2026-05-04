import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

class SongPlayerPage extends StatefulWidget {
  final QueryDocumentSnapshot songData;
  const SongPlayerPage({super.key, required this.songData});

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) setState(() => isPlaying = state == PlayerState.playing);
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) setState(() => duration = newDuration);
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) setState(() => position = newPosition);
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      String rawPath = widget.songData['songUrl'];
      String cleanPath = rawPath.replaceFirst('assets/', ''); 
      await _audioPlayer.play(AssetSource(cleanPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 30, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              widget.songData['isFavorite'] ? Icons.favorite : Icons.favorite_border,
              color: widget.songData['isFavorite'] ? Colors.red : Colors.white,
            ),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('songs')
                  .doc(widget.songData.id)
                  .update({'isFavorite': !widget.songData['isFavorite']});
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF30197D), Color(0xFF000000)], // Gradient ungu gelap ke hitam
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            // Ikon atau Foto Artis
            const Icon(Icons.music_note, size: 80, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              widget.songData['title'],
              style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Text("Lyrics", style: TextStyle(color: Colors.white54, fontSize: 14)),
            
            const SizedBox(height: 30),
            
            // AREA LIRIK (Bisa di-scroll)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  widget.songData['lyrics'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18, height: 2.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),

            // KONTROL PLAYER DI BAWAH
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Slider(
                    min: 0,
                    max: duration.inSeconds.toDouble() > 0 ? duration.inSeconds.toDouble() : 1.0,
                    value: position.inSeconds.toDouble(),
                    activeColor: Colors.deepPurpleAccent,
                    onChanged: (value) async {
                      await _audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40), onPressed: () {}),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: _togglePlay,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          child: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 45, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(icon: const Icon(Icons.skip_next, color: Colors.white, size: 40), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}