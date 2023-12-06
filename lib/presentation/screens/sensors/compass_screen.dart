// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';
import 'package:miscelaneos/presentation/screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locatedGranted = ref.watch(permissionsProvider).locationGranted;
    final comprassHeadings$ = ref.watch(compassProvider);
    if (!locatedGranted) {
      return const AskLocationScreen();
    }
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.black,
            title: const Text('Brújula',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300))),
        body: Center(
            child: comprassHeadings$.when(
                data: (data) => Compass(heading: data ?? 0),
                error: (error, stackTrace) => Text('$error'),
                loading: () => const CircularProgressIndicator())));
  }
}

class Compass extends StatefulWidget {
  final double heading;
  const Compass({super.key, required this.heading});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double prevValue = 0.0;
  double turns = 0;

  double getTurns() {
    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction) : direction;

    double diff = direction - prevValue;
    if (diff.abs() > 180) {
      if (prevValue > direction) {
        diff = 360 - (direction - prevValue).abs();
      } else {
        diff = 360 - (prevValue - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    prevValue = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(
        //   '${widget.heading.ceil()}',
        //   style: const TextStyle(
        //       fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),
        // ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/compass/quadrant-1.png'),
            // Transform.rotate(
            //     angle: (widget.heading * (pi / 180) * -1),
            //     child: Image.asset('assets/compass/needle-3.png')),
            AnimatedRotation(
                curve: Curves.easeOut,
                turns: getTurns(),
                duration: const Duration(seconds: 1),
                child: Image.asset('assets/compass/needle-1.png')),
          ],
        )
      ],
    );
  }
}
