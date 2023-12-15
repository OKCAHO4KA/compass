import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometrics'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  ref.read(localAuthProvider.notifier).authenticatedUser();
                },
                child: const Text('Autenticar')),
            canCheckBiometrics.when(
                data: (bool data) {
                  return Text('Puede revisar biométricos: $data');
                },
                error: (Object error, StackTrace stackTrace) {
                  return Text('e: $error');
                },
                loading: () => const CircularProgressIndicator()),
            Text('Estado del biometrico: ${localAuthState.status}'),
            Text('Estado : ${localAuthState.didAuthenticate}'),
            Text('Message:${localAuthState.message}')
          ],
        ),
      ),
    );
  }
}
