import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/tile_cubit.dart';

class PokeTileBlanc extends StatefulWidget {
  final String name;

  const PokeTileBlanc({
    super.key,
    required this.name,
  });

  @override
  State<PokeTileBlanc> createState() => _PokeTileBlancState();
}

class _PokeTileBlancState extends State<PokeTileBlanc> {
  @override
  void initState() {
    super.initState();
    loadTile(context, widget.name);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  //tutaj sized box
                  //no i bez tych samych nazw
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void loadTile(BuildContext context, String name) {
    final tileCubit = BlocProvider.of<TileCubit>(context);
    tileCubit.loadTile(name);
  }
}
