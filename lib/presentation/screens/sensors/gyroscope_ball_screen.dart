import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gyroscope$ = ref.watch(gyroscopeProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gyroscope Ball'),
        ),
        body: SizedBox.expand(
          child: gyroscope$.when(
              data: (data) => MovingBall(x: data.x, y: data.y),
              error: ((error, stackTrace) => Text('$error')),
              loading: () => const CircularProgressIndicator()),
        ));
  }
}

class MovingBall extends StatelessWidget {
  final double x;
  final double y;

  const MovingBall({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double screenWidth = size.width;
    double screenHeight = size.height;

    double currentXPos = x * 200;
    double currentYPos = y * 200;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Text(
        //   ''' x: $x, y: $y ''',
        //   style: const TextStyle(fontSize: 50),
        // ),
        AnimatedPositioned(
            top: (currentXPos - 25) + screenHeight / 2,
            left: (currentYPos - 25) + screenWidth / 2,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1000),
            child: const Ball(
              colorBall: Colors.orange,
              radius: 50,
            )),
        AnimatedPositioned(
            top: (currentXPos - 25) + screenHeight / 3,
            left: (currentYPos - 25) + screenWidth / 2,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 1000),
            child: const Ball(colorBall: Colors.blue, radius: 80)),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  final Color colorBall;
  final double radius;
  const Ball({super.key, required this.colorBall, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        color: colorBall,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}
