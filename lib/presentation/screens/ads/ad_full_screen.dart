import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/ads/admob_providers.dart';

class AdFullScreen extends ConsumerWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final adInterstitialAsync = ref.watch(adInterstitialProvider);

    ref.listen(adInterstitialProvider, (previous, next) {
      if (!next.hasValue) return;
      if (next.value == null) return;
      next.value!.show();
    });
    if (adInterstitialAsync.isLoading) {
      return const Scaffold(
        body: Center(
          child: Text('Cargando ad'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Full Screen'),
      ),
      body: const Center(
        child: Text('Ya puedes ver esta pantalla'),
      ),
    );
  }
}
