import 'package:flutter/material.dart';

enum EmotionType {
  happy('Happy', '😊', Colors.amber),
  grateful('Grateful', '🙏', Colors.orange),
  relieved('Relieved', '😌', Colors.teal),
  calm('Calm', '🧘', Colors.blue),
  excited('Excited', '🤩', Colors.pink),
  sad('Sad', '😢', Colors.indigo),
  anxious('Anxious', '😰', Colors.purple),
  stressed('Stressed', '😬', Colors.deepOrange),
  angry('Angry', '😡', Colors.red),
  frustrated('Frustrated', '😤', Colors.brown);

  final String label;
  final String emoji;
  final Color color;

  const EmotionType(this.label, this.emoji, this.color);
}

class EmotionEntry {
  final String id;
  final EmotionType emotion;
  final int intensity; // 1 to 10
  final DateTime timestamp;
  final String? note;

  EmotionEntry({
    required this.id,
    required this.emotion,
    required this.intensity,
    required this.timestamp,
    this.note,
  });
}
