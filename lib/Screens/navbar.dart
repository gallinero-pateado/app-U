import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final BuildContext context;

  const CustomNavigationBar({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.lightBlue, // Cambia el color de fondo a celeste
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              color: Colors.white, // Cambia el color del icono a blanco
              onPressed: () {
                Navigator.pushNamed(this.context, '/mainScreen');
              },
            ),
            IconButton(
              icon: const Icon(Icons.description),
              color: Colors.white, // Cambia el color del icono a blanco
              onPressed: () {
                Navigator.pushNamed(this.context, '/DescriptionPage');
              },
            ),
            IconButton(
              icon: const Icon(Icons.list),
              color: Colors.white, // Cambia el color del icono a blanco
              onPressed: () {
                Navigator.pushNamed(this.context, '/ListPage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
