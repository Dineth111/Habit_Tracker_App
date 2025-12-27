import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatTile(
                      label: 'Habits',
                      value: '3',
                      color: scheme.primary,
                    ),
                    _StatTile(
                      label: 'Current streak',
                      value: '7',
                      color: scheme.secondary,
                    ),
                    _StatTile(
                      label: 'Best streak',
                      value: '21',
                      color: scheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 24),
          Text(
            'History',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, i) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        scheme.primary.withValues(alpha: 0.12),
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(color: scheme.primary),
                    ),
                  ),
                  title: Text('Sample habit ${i + 1}'),
                  subtitle: Text('Completed ${i + 3} times'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatTile({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: color)),
        const SizedBox(height: 6),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
