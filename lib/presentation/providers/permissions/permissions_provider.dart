import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
//state notifier provider

//notifier

final permissionsProvider =
    StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});

class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState()) {
    // checkPermissions();
  }
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.release': build.version.release,
    };
  }

  Future<void> checkPermissions() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    final and = _readAndroidBuildData(await deviceInfo.androidInfo);
    final int versionAnd = int.parse(and['version.release']);
    final bool isMenorDe12 = versionAnd <= 12;
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.location.status,
      Permission.locationWhenInUse.status,
      Permission.locationAlways.status,
      Permission.sensors.status,
      (isMenorDe12) ? Permission.storage.status : Permission.photos.status,
    ]);
    state = state.copyWith(
        camera: permissionsArray[0],
        location: permissionsArray[1],
        locationAlways: permissionsArray[3],
        locationWhenInUse: permissionsArray[2],
        sensors: permissionsArray[4],
        photoLibrary: permissionsArray[5]);
  }

  requestCameraAccess() async {
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  requestGaleryAccess() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      final and = _readAndroidBuildData(await deviceInfo.androidInfo);
      final int versionAnd = int.parse(and['version.release']);
      final bool isMenorDe12 = versionAnd <= 12;

      if (isMenorDe12) {
        final status = await Permission.storage.request();
        state = state.copyWith(photoLibrary: status);
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      } else {
        final status = await Permission.photos.request();
        state = state.copyWith(photoLibrary: status);
        if (status == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
      }
    }
  }

  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);
    if (status == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}

//начнем с State

class PermissionsState {
  final PermissionStatus camera;
  final PermissionStatus location;
  final PermissionStatus locationAlways;
  final PermissionStatus locationWhenInUse;
  final PermissionStatus sensors;
  final PermissionStatus photoLibrary;

  PermissionsState(
      {this.camera = PermissionStatus.denied,
      this.location = PermissionStatus.denied,
      this.locationAlways = PermissionStatus.denied,
      this.locationWhenInUse = PermissionStatus.denied,
      this.sensors = PermissionStatus.denied,
      this.photoLibrary = PermissionStatus.denied});

  PermissionsState copyWith(
          {PermissionStatus? camera,
          PermissionStatus? location,
          PermissionStatus? locationAlways,
          PermissionStatus? locationWhenInUse,
          PermissionStatus? sensors,
          PermissionStatus? photoLibrary}) =>
      PermissionsState(
          camera: camera ?? this.camera,
          location: location ?? this.location,
          locationAlways: locationAlways ?? this.locationAlways,
          locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse,
          sensors: sensors ?? this.sensors,
          photoLibrary: photoLibrary ?? this.photoLibrary);

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get photoLibraryGranted {
    return photoLibrary == PermissionStatus.granted;
  }
}
