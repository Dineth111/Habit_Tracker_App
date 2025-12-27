import 'package:flutter/material.dart';
import 'package:habitapp/models/habit.dart';
import 'package:habitapp/widgets/habit_tile.dart';
import 'package:habitapp/widgets/habit_dialog.dart';
import 'package:habitapp/pages/habit_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Habit> _habits = [
    Habit(name: 'Morning run'),
    Habit(name: 'Drink 2L water'),
    Habit(name: '30 min reading'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: _habits.isEmpty
            ? _EmptyState(onAddPressed: _addHabit)
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(context),
                          const SizedBox(height: 20),
                          _buildProgressHeader(colorScheme),
                          const SizedBox(height: 16),
                          Text(
                            'Today\'s habits',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black87,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final habit = _habits[index];
                          return Dismissible(
                            key: Key(habit.name + index.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) => _deleteHabit(index),
                            background: Container(
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 24),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: HabitTile(
                                habitName: habit.name,
                                isCompleted: habit.isCompletedToday,
                                streak: habit.streak,
                                onToggle: (value) =>
                                    _toggleHabit(index, value ?? false),
                                onEdit: () => _editHabit(index),
                                onDelete: () => _deleteHabit(index),
                                onLongPress: () =>
                                    _showHabitOptions(context, index),
                              ),
                            ),
                          );
                        },
                        childCount: _habits.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 92),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addHabit,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add'),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final date = DateTime.now();
    final dayName = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
    ][date.weekday % 7];
    final day = date.day.toString().padLeft(2, '0');
    final monthNames = [
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
    final month = monthNames[date.month - 1];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '$dayName, $day $month',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressHeader(ColorScheme scheme) {
    final completed = _habits.where((h) => h.isCompletedToday).length;
    final total = _habits.length;
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primary,
            scheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good job',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You completed $completed of $total habits today',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: scheme.onPrimary.withValues(alpha: 0.9),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 78,
            height: 78,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 78,
                  height: 78,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor:
                        scheme.onPrimary.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      scheme.onPrimary,
                    ),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scheme.onPrimary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleHabit(int index, bool newValue) {
    setState(() {
      final habit = _habits[index];
      if (newValue && !habit.isCompletedToday) {
        habit.streak += 1;
      } else if (!newValue && habit.isCompletedToday) {
        habit.streak = habit.streak > 0 ? habit.streak - 1 : 0;
      }
      habit.isCompletedToday = newValue;
    });
  }

  Future<void> _addHabit() async {
    final name = await showDialog<String?>(
      context: context,
      builder: (_) =>
          const HabitDialog(title: 'New habit', confirmText: 'Create'),
    );
    if (name == null) return;
    setState(() => _habits.insert(0, Habit(name: name)));
  }

  Future<void> _editHabit(int index) async {
    final current = _habits[index];
    final name = await showDialog<String?>(
      context: context,
      builder: (_) => HabitDialog(
        title: 'Edit habit',
        confirmText: 'Save',
        initialName: current.name,
      ),
    );
    if (name == null) return;
    setState(() => _habits[index].name = name);
  }

  void _deleteHabit(int index) {
    final removed = _habits.removeAt(index);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${removed.name}"'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() => _habits.insert(index, removed));
          },
        ),
      ),
    );
  }

  void _showHabitOptions(BuildContext context, int index) {
    final habit = _habits[index];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  _editHabit(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _deleteHabit(index);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Details'),
                subtitle: Text('Streak: ${habit.streak} days'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HabitDetailPage(habit: habit),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAddPressed;

  const _EmptyState({required this.onAddPressed});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_today_rounded, size: 64, color: scheme.primary),
            const SizedBox(height: 16),
            Text(
              'No habits yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first habit to start building momentum.',
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add habit'),
            ),
          ],
        ),
      ),
    );
  }
}
