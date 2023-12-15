// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/config/config.dart';

final canCheckBiometricsProvider = FutureProvider<bool>((ref) async {
  return await LocalAuthPlugin.canCheckBiometrics();
});

enum LocalAuthtatus { autenticated, notAuthenticated, authenticating }

class LocalAuthState {
  final bool didAuthenticate;
  final LocalAuthtatus status;
  final String message;

  LocalAuthState(
      {this.didAuthenticate = false,
      this.status = LocalAuthtatus.notAuthenticated,
      this.message = ''});

  LocalAuthState copyWith({
    bool? didAuthenticate,
    LocalAuthtatus? status,
    String? message,
  }) =>
      LocalAuthState(
        didAuthenticate: didAuthenticate ?? this.didAuthenticate,
        status: status ?? this.status,
        message: message ?? this.message,
      );
  @override
  String toString() {
    return '''

didAuthenticate : $didAuthenticate
status : $status
message : $message
''';
  }
}

class LocalAuthNotifier extends StateNotifier<LocalAuthState> {
  LocalAuthNotifier() : super(LocalAuthState());

  Future<(bool, String)> authenticatedUser() async {
    final (didAuthenticate, mesaje) =
        await LocalAuthPlugin.authenticate(biometricOnly: true);
    state = state.copyWith(
        didAuthenticate: didAuthenticate,
        message: mesaje,
        status: didAuthenticate
            ? LocalAuthtatus.autenticated
            : LocalAuthtatus.notAuthenticated);

    return (didAuthenticate, mesaje);
  }
}

final localAuthProvider =
    StateNotifierProvider<LocalAuthNotifier, LocalAuthState>((ref) {
  return LocalAuthNotifier();
});
