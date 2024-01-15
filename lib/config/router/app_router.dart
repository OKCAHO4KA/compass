import 'package:go_router/go_router.dart';

import '../../presentation/screens.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/permissions',
    builder: (context, state) => const PermissionsScreen(),
  ),
  GoRoute(
    path: '/gyroscope',
    builder: (context, state) => const GyroscopeScreen(),
  ),
  GoRoute(
    path: '/acelerometro',
    builder: (context, state) => const AccelerometerScreen(),
  ),
  GoRoute(
    path: '/magnetometro',
    builder: (context, state) => const MagnetometerScreen(),
  ),
  GoRoute(
    path: '/gyroscopio-ball',
    builder: (context, state) => const GyroscopeBallScreen(),
  ),
  GoRoute(
    path: '/brujula',
    builder: (context, state) => const CompassScreen(),
  ),
  GoRoute(
    path: '/biometric',
    builder: (context, state) => const BiometricScreen(),
  ),
  GoRoute(
      path: '/pokemons',
      builder: (context, state) => const PokemonsScreen(),
      routes: [
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '1';

            return PokemonScreen(pokemonId: id);
          },
        )
      ]),
  GoRoute(
    path: '/location',
    builder: (context, state) => const LocationScreen(),
  ),
  GoRoute(
    path: '/maps',
    builder: (context, state) => const MapScreen(),
  ),
  GoRoute(
    path: '/controlled-map',
    builder: (context, state) => const ControlledMapScreen(),
  ),
  GoRoute(
    path: '/badge',
    builder: (context, state) => const BadgeScreen(),
  ),
  GoRoute(
    path: '/ad-full',
    builder: (context, state) => const AdFullScreen(),
  ),
  GoRoute(
    path: '/ad-rewarded',
    builder: (context, state) => const AdRewardedScreen(),
  ),
  GoRoute(
    path: '/db-pokemons',
    builder: (context, state) => const DbPokemonsScreen(),
  ),
]);
