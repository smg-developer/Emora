import 'package:emora/presentation/widgets/daily_chart.dart';
import 'package:flutter/material.dart';
import 'models/emotion_entry.dart';
import 'models/emotion_store.dart';
import 'presentation/widgets/add_emotion_sheet.dart';
import 'presentation/widgets/daily_chart.dart';

void main() {
  runApp(const EmotionTrackerApp());
}

class EmotionTrackerApp extends StatelessWidget {
  const EmotionTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final EmotionStore _store = EmotionStore();

  @override
  void initState() {
    super.initState();
    _store.addListener(() => setState(() {}));
  }

  void _openAddEmotionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddEmotionSheet(
        onSave: (emotion, intensity, note) {
          _store.addEntry(emotion, intensity, note);
        },
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _store.selectedDate,
      firstDate: DateTime(2023, 1, 1),
      lastDate: DateTime.now(), // Prevent future dates
    );
    if (picked != null) {
      _store.setSelectedDate(picked);
    }
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }
    return '${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final entries = _store.selectedDateEntries;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emora Emotion Log'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Select Date',
            onPressed: () => _pickDate(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Navigation Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        _formatDateHeader(_store.selectedDate),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (!_store.isToday)
                    TextButton.icon(
                      onPressed: () => _store.jumpToToday(),
                      icon: const Icon(Icons.today, size: 16),
                      label: const Text('Jump to Today'),
                    )
                  else
                    const Text(
                      'Viewing Today',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Daily Chart
            Text(
              _store.isToday
                  ? "Today's Mood Flow"
                  : "Mood Flow for ${_formatDateHeader(_store.selectedDate)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DailyEmotionChart(isToday: _store.isToday, entries: entries),
            const SizedBox(height: 20),

            // Summary Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MetricTile(
                    label: 'Entries',
                    value: '${_store.selectedDateCount}',
                  ),
                  _MetricTile(
                    label: 'Avg Intensity',
                    value: _store.selectedDateCount > 0
                        ? _store.averageIntensity.toStringAsFixed(1)
                        : '-',
                  ),
                  _MetricTile(
                    label: 'Top Emotion',
                    value: _store.mostFrequentEmotion != null
                        ? '${_store.mostFrequentEmotion!.emoji} ${_store.mostFrequentEmotion!.label}'
                        : '-',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Timeline Entries
            Text(
              _store.isToday
                  ? "Today's Entries"
                  : "Entries on ${_formatDateHeader(_store.selectedDate)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (entries.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text(
                    _store.isToday
                        ? 'No log entries for today yet.'
                        : 'No log entries found for this date.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final item = entries[index];
                  final t = item.timestamp;
                  final timeFormatted =
                      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: item.emotion.color.withOpacity(0.2),
                        child: Text(
                          item.emotion.emoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      title: Text(
                        '${item.emotion.label} (Intensity: ${item.intensity}/10)',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            timeFormatted,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          if (item.note != null && item.note!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(item.note!),
                            ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () => _store.deleteEntry(item.id),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
      floatingActionButton: _store.isToday
          ? FloatingActionButton.extended(
              onPressed: _openAddEmotionSheet,
              icon: const Icon(Icons.add),
              label: const Text('Log Emotion'),
            )
          : null, // Only allow logging for today's date
    );
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;

  const _MetricTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    exports:
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
