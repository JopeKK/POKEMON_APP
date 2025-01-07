import 'package:flutter/material.dart';

class CatchingScreen extends StatefulWidget {
  final String name;
  final double posx;
  final double posy;
  final String type;
  final String photo;
  final double posTop;
  final double posLeft;

  const CatchingScreen({
    super.key,
    required this.name,
    required this.posx,
    required this.posy,
    required this.type,
    required this.photo,
    required this.posLeft,
    required this.posTop,
  });

  @override
  State<CatchingScreen> createState() => _CatchingScreenState();
}

class _CatchingScreenState extends State<CatchingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: photoPicker(widget.type),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              top: widget.posy,
              left: widget.posx,
              child: Image.asset(
                'assets/images/ball.png',
                width: 40,
                height: 40,
              ),
            ),
            Positioned(
              top: widget.posTop,
              left: widget.posLeft,
              child: Image.network(
                widget.photo,
                width: 125,
                height: 125,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

photoPicker(type) {
  if (type == 'grass') {
    return const AssetImage('assets/images/grass_background.jpg');
  } else if (type == 'fire') {
    return const AssetImage('assets/images/fire_background.png');
  }

  return const AssetImage('assets/images/white.avif');
}
