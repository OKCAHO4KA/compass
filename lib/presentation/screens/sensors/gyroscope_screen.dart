import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Giroscópio'),
        ),
        body: Center(
            child: gyroscope$.when(
                data: (data) => Text(data.toString(),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w300)),
                error: (error, stackTrace) => Text('$error'),
                loading: () => const CircularProgressIndicator())));
  }
}
