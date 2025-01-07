import 'package:flutter/material.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/pages/widgets/tile_views/list_tile_loaded.dart';

class FavoriteScreen extends StatelessWidget {
  final List<PokeModel> favoritePoke;
  const FavoriteScreen({
    super.key,
    required this.favoritePoke,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: favoritePoke.length,
                itemBuilder: (context, index) {
                  final item = favoritePoke[index];
                  return PokeTileLoaded(
                    name: item.name,
                    type: item.type,
                    isClose: item.isClose,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
