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
  )
]);
