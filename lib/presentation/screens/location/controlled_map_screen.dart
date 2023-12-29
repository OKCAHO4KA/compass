import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class ControlledMapScreen extends ConsumerWidget {
  const ControlledMapScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final watchUserLocation = ref.watch(watchLocationProvider);
    return Scaffold(
        body: watchUserLocation.when(
            data: (data) =>
                MapAndControls(latitude: data.$1, longitude: data.$2),
            error: ((error, stackTrace) => Text('$error')),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}

class MapAndControls extends ConsumerWidget {
  final double latitude;
  final double longitude;

  const MapAndControls(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context, ref) {
    final mapControllerState = ref.watch(mapControllerProvider);
    return Stack(
      children: [
        _MapView(initialLat: latitude, initialLng: longitude),
        //Boton para salir
        Positioned(
            top: 40,
            left: 20,
            child: IconButton.filledTonal(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back))),

        //ir a la posicion del usuario
        Positioned(
            bottom: 40,
            left: 20,
            child: IconButton.filledTonal(
                onPressed: () {
                  ref
                      .read(mapControllerProvider.notifier)
                      .goToLocation(latitude, longitude);
                },
                icon: const Icon(Icons.location_searching))),

        //empesar/parar a seguir usuario
        Positioned(
            bottom: 90,
            left: 20,
            child: IconButton.filledTonal(
                onPressed: () {
                  ref.read(mapControllerProvider.notifier).toggleFolowUser();
                },
                icon: Icon(mapControllerState.followUser
                    ? Icons.directions_run
                    : Icons.accessibility_new_outlined))),

        // icon: const Icon(Icons.directions_run))),
        //crear marcador
        Positioned(
            bottom: 140,
            left: 20,
            child: IconButton.filledTonal(
                onPressed: () {
                  ref
                      .read(mapControllerProvider.notifier)
                      // .addMarker(lat, lng, name: 'Por aqui pasó el usuario');
                      .addMarkerCurrentPosition();
                },
                icon: const Icon(Icons.pin_drop))),
      ],
    );
  }
}

class _MapView extends ConsumerStatefulWidget {
  final double initialLat;
  final double initialLng;

  const _MapView({required this.initialLat, required this.initialLng});

  @override
  ConsumerState<_MapView> createState() => __MapViewState();
}

class __MapViewState extends ConsumerState<_MapView> {
  @override
  Widget build(BuildContext context) {
    final mapController = ref.watch(mapControllerProvider);
    return GoogleMap(
      onLongPress: (argument) {
        ref
            .read(mapControllerProvider.notifier)
            .addMarker(argument.latitude, argument.longitude);
      },
      markers: mapController.markersSet,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: LatLng(widget.initialLat, widget.initialLng),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        // _controller.complete(controller);
        ref.read(mapControllerProvider.notifier).setMapController(controller);
      },
    );
  }
}
