import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/plugins/app_badge_plugin.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final badgeCounter = ref.watch(badgeCounterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Badge(
              alignment: Alignment.lerp(
                  Alignment.topRight, Alignment.bottomRight, 0.2),
              label: Text('$badgeCounter'),
              child: Text('$badgeCounter',
                  style: const TextStyle(
                      fontSize: 150, fontWeight: FontWeight.w300)),
            ),
            FilledButton.tonal(
                onPressed: () {
                  ref.invalidate(badgeCounterProvider);
                  AppBadgePlugin.removeBadge();
                },
                child: const Text('Borrar badge'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newCount = ref
              .read(badgeCounterProvider.notifier)
              .update((state) => state + 1);
          AppBadgePlugin.updateBadgerCount(newCount);
        },
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
