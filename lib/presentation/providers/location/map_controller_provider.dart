// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool isReady;
  final bool followUser;
  final List<Marker> markers;
  final GoogleMapController? controller;

  MapState(
      {this.isReady = false,
      this.followUser = false,
      this.markers = const [],
      this.controller});

  Set<Marker> get markersSet {
    return Set.from(markers);
  }

  MapState copyWith({
    bool? isReady,
    bool? followUser,
    List<Marker>? markers,
    GoogleMapController? controller,
  }) {
    return MapState(
      isReady: isReady ?? this.isReady,
      followUser: followUser ?? this.followUser,
      markers: markers ?? this.markers,
      controller: controller ?? this.controller,
    );
  }
}

class MapNotifier extends StateNotifier<MapState> {
  StreamSubscription? userLocationSuscription;
  (double, double)? lastKnowLocation;
  MapNotifier() : super(MapState()) {
    trackUser().listen((event) {
      lastKnowLocation = (event.$1, event.$2);
    });
  }

  void setMapController(GoogleMapController ctr) {
    state = state.copyWith(controller: ctr, isReady: true);
  }

  goToLocation(double latitude, double longitude) {
    final newPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 15);
    state.controller
        ?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  Stream<(double, double)> trackUser() async* {
    await for (final pos in Geolocator.getPositionStream()) {
      yield (pos.latitude, pos.longitude);
    }
  }

  toggleFolowUser() {
    state = state.copyWith(followUser: !state.followUser);

    if (state.followUser) {
      findUser();
      userLocationSuscription = trackUser().listen((event) {
        goToLocation(event.$1, event.$2);
      });
    } else {
      userLocationSuscription?.cancel();
    }
  }

  findUser() {
    if (lastKnowLocation == null) return;
    final (double latitude, double longitude) = lastKnowLocation!;
    // trackUser().take(1).listen((event) {
    // goToLocation(event.$1, event.$2);
    goToLocation(latitude, longitude);
  }

  void addMarker(double lat, double lng,
      {String name = 'No name', String body = ''}) {
    final newMarker = Marker(
        markerId: MarkerId('${state.markers.length}'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
            title: name, snippet: 'Esto es el snippet del info window'));

    state = state.copyWith(markers: [...state.markers, newMarker]);
  }

  void addMarkerCurrentPosition() {
    if (lastKnowLocation == null) return;
    final (latitude, longitude) = lastKnowLocation!;
    addMarker(latitude, longitude, name: 'Por aquí');
  }
}

final mapControllerProvider =
    StateNotifierProvider.autoDispose<MapNotifier, MapState>(
        (ref) => MapNotifier());
