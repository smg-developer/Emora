import 'package:emora/models/emotion_entry.dart';
import 'package:flutter/material.dart';

class AddEmotionSheet extends StatefulWidget {
  final Function(EmotionType emotion, int intensity, String? note) onSave;

  const AddEmotionSheet({super.key, required this.onSave});

  @override
  State<AddEmotionSheet> createState() => _AddEmotionSheetState();
}

class _AddEmotionSheetState extends State<AddEmotionSheet> {
  EmotionType? _selectedEmotion;
  double _intensity = 5;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedEmotion == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an emotion')));
      return;
    }

    widget.onSave(_selectedEmotion!, _intensity.round(), _noteController.text);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 24,
        left: 20,
        right: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log How You Feel',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Select Emotion',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: EmotionType.values.map((emotion) {
                final isSelected = _selectedEmotion == emotion;
                return ChoiceChip(
                  label: Text('${emotion.emoji} ${emotion.label}'),
                  selected: isSelected,
                  selectedColor: emotion.color.withOpacity(0.3),
                  onSelected: (selected) {
                    setState(() {
                      _selectedEmotion = selected ? emotion : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Intensity',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${_intensity.round()} / 10',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Slider(
              value: _intensity,
              min: 1,
              max: 10,
              divisions: 9,
              label: _intensity.round().toString(),
              onChanged: (value) => setState(() => _intensity = value),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                hintText: 'What triggered this emotion?',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Save Entry', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
