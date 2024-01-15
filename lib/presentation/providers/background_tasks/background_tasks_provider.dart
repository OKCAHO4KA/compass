import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {
  final String processKeyName;

  BackgroundFetchNotifier({required this.processKeyName}) : super(false) {
    checkCurrentStatus();
  }

  checkCurrentStatus() async {
    state = await SharePreferencesPlugin.getBool(processKeyName) ?? false;
  }

  activateProcess() async {
    //la primera vez es inmediata
    await Workmanager().registerPeriodicTask(processKeyName, processKeyName,
        frequency: const Duration(seconds: 10),
        constraints: Constraints(networkType: NetworkType.connected),
        tag: processKeyName);
    await SharePreferencesPlugin.setBool(processKeyName, true);

    // lo cambiara a 15 minutos

    state = true;
  }

  toggleProcess() async {
    if (state == true) {
      deactivateProcess();
    } else {
      activateProcess();
    }
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharePreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }
}

final backgroundPokemonFetchProvider =
    StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(
      processKeyName: fetchPeriodicBackgroundTaskKey);
});
