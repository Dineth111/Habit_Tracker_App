import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          Text(
            'Personalize your experience',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.palette,
                    color: scheme.primary,
                  ),
                  title: const Text('Theme'),
                  subtitle: const Text('Light / Dark (coming soon)'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: Icon(
                    Icons.notifications_active_outlined,
                    color: scheme.primary,
                  ),
                  title: const Text('Reminders'),
                  subtitle: const Text('Daily habit reminders'),
                  trailing: Switch(
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.backup,
                    color: scheme.primary,
                  ),
                  title: const Text('Backup'),
                  subtitle: const Text('Export or import your habit data'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: scheme.primary,
                  ),
                  title: const Text('About'),
                  subtitle: const Text('Version 1.0'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Habit Tracker',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black45,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
