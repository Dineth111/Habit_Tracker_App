import 'package:flutter/material.dart';

class HabitDialog extends StatefulWidget {
  final String? initialName;
  final String title;
  final String confirmText;

  const HabitDialog({
    super.key,
    this.initialName,
    required this.title,
    required this.confirmText,
  });

  @override
  State<HabitDialog> createState() => _HabitDialogState();
}

class _HabitDialogState extends State<HabitDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Habit name',
          hintText: 'e.g., Morning run',
          prefixIcon: const Icon(Icons.edit_outlined),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop<String?>(null),
          child: const Text('Cancel'),
        ),
        FilledButton.tonal(onPressed: _submit, child: Text(widget.confirmText)),
      ],
    );
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    Navigator.of(context).pop<String>(text);
  }
}
