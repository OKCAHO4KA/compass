import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/sensors/magnetometer_provider.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometer = ref.watch(magnetometerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Magnetómetro'),
        ),
        body: Center(
            child: magnetometer.when(
                data: (data) => Text(data.x.toString(),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300)),
                error: (error, stackTrace) => Text(
                      '$error',
                    ),
                loading: () => const CircularProgressIndicator())));
  }
}
