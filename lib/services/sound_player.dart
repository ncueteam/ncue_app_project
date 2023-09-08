import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SoundPlayer {
  Future<void> playLocalAudio(String path) async {
    try {
      final AudioPlayer player = AudioPlayer();
      final ByteData data = await rootBundle.load(path);
      final Uint8List bytes = data.buffer.asUint8List();
      await player.setSourceBytes(bytes);
      await player.resume();
    } catch (e) {
      debugPrint("Error playing local audio: $e");
    }
  }
}
