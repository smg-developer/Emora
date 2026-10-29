import 'package:flutter/foundation.dart';
import '../data/database/app_database.dart';
import 'emotion_entry.dart';

class EmotionStore extends ChangeNotifier {
  final AppDatabase _db = AppDatabase();
  List<EmotionEntry> _entries = [];
  bool isLoaded = false;

  // Selected date for viewing history (defaults to today, normalized to midnight)
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  EmotionStore() {
    _initStream();
  }

  void _initStream() {
    _db.watchAllEntries().listen((entries) {
      _entries = entries;
      isLoaded = true;
      notifyListeners();
    });
  }

  List<EmotionEntry> get entries => List.unmodifiable(_entries);

  DateTime get selectedDate => _selectedDate;

  bool get isToday {
    final now = DateTime.now();
    return _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  void jumpToToday() {
    final now = DateTime.now();
    setSelectedDate(DateTime(now.year, now.month, now.day));
  }

  // Entries filtered by the currently selected date
  List<EmotionEntry> get selectedDateEntries {
    return _entries.where((entry) {
      return entry.timestamp.year == _selectedDate.year &&
          entry.timestamp.month == _selectedDate.month &&
          entry.timestamp.day == _selectedDate.day;
    }).toList()..sort(
      (a, b) => b.timestamp.compareTo(a.timestamp),
    ); // Reverse chronological
  }

  Future<void> addEntry(
    EmotionType emotion,
    int intensity,
    String? note,
  ) async {
    final entry = EmotionEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      emotion: emotion,
      intensity: intensity,
      timestamp: DateTime.now(), // Recorded at current time
      note: note?.trim().isEmpty ?? true ? null : note?.trim(),
    );
    await _db.insertEntry(entry);
  }

  Future<void> deleteEntry(String id) async {
    await _db.deleteEntry(id);
  }

  // Summary Metrics for the Selected Date
  int get selectedDateCount => selectedDateEntries.length;

  double get averageIntensity {
    if (selectedDateEntries.isEmpty) return 0.0;
    final total = selectedDateEntries.fold<int>(
      0,
      (sum, e) => sum + e.intensity,
    );
    return total / selectedDateEntries.length;
  }

  EmotionType? get mostFrequentEmotion {
    if (selectedDateEntries.isEmpty) return null;
    final counts = <EmotionType, int>{};
    for (var entry in selectedDateEntries) {
      counts[entry.emotion] = (counts[entry.emotion] ?? 0) + 1;
    }
    return counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }
}
