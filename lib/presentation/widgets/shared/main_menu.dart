import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(this.title, this.icon, this.route);
}

final menuItems = <MenuItem>[
  MenuItem('Giróscopio', Icons.downloading, '/gyroscope'),
  MenuItem('Acelerómetro', Icons.speed, '/acelerometro'),
  MenuItem('Magnetómetro', Icons.explore_outlined, '/magnetometro'),
  MenuItem('Giróscopio Ball ', Icons.sports_baseball_sharp, '/gyroscopio-ball'),
  MenuItem('Brújula', Icons.explore, '/brujula')
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: menuItems
            .map((e) =>
                HomeMenuItem(title: e.title, route: e.route, icon: e.icon))
            .toList());
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final List<Color> bgColor;
  const HomeMenuItem(
      {super.key,
      required this.title,
      required this.route,
      required this.icon,
      this.bgColor = const [Colors.teal, Colors.tealAccent]});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
                colors: bgColor,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(height: 5),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
