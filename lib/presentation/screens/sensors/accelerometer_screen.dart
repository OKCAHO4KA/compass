import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/accelerometer_providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometer$ = ref.watch(accelerometeGravityrProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Accelerómetro')),
      body: Center(
          child: accelerometer$.when(
              data: (data) => Text(data.toString(),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w300)),
              error: (error, stackTrace) => Text('$error'),
              loading: () => const CircularProgressIndicator())),
    );
  }
}
