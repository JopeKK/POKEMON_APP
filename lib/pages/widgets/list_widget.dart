import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/tile_cubit.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';
import 'package:pokemon_app/pages/widgets/tile_views/list_tile.dart';

class ListWidget extends StatelessWidget {
  final List<PokeModel> pokemonList;
  const ListWidget({
    super.key,
    required this.pokemonList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemonList.length,
      itemBuilder: (context, index) {
        final item = pokemonList[index];
        return BlocProvider(
          key: Key(item.name),
          create: (context) => TileCubit(PokeRepository()),
          child: PokeListTile(pokemon: item),
        );
      },
    );
  }
}
