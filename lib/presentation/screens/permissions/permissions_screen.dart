import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
      body: _PermissionView(),
    );
  }
}

class _PermissionView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionsProvider);
    return ListView(
      children: [
        CheckboxListTile(
            value: permissions.cameraGranted,
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestCameraAccess();
            },
            title: const Text('Camera'),
            subtitle: Text('${permissions.camera}')),
        CheckboxListTile(
            value: permissions.photoLibraryGranted,
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestGaleryAccess();
            },
            title: const Text('Galería de fotos'),
            subtitle: Text('${permissions.photoLibrary}')),
        CheckboxListTile(
            value: permissions.locationGranted,
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestLocationAccess();
            },
            title: const Text('Ubicación'),
            subtitle: Text('${permissions.location}')),
        CheckboxListTile(
            value: permissions.sensorsGranted,
            onChanged: (value) {
              ref.read(permissionsProvider.notifier).requestSensorsAccess();
            },
            title: const Text('Sensores'),
            subtitle: Text('${permissions.sensors}')),
      ],
    );
  }
}
