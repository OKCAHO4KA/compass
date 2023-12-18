import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLocationAsync = ref.watch(userLocationProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('LocationScreen')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Ubicación actual: '),
            userLocationAsync.when(
              data: ((double, double) data) => Text('$data'),
              error: (Object error, StackTrace stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator(),
            ),
            const SizedBox(height: 30),
            const Text('Seguimiento de ubicación'),
          ],
        )));
  }
}
