import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/favorite_cubit.dart';
import 'package:pokemon_app/cubit/poke_cubit.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';
import 'package:pokemon_app/pages/favorite/favorite_logic.dart';
import 'package:pokemon_app/pages/widgets/list_widget.dart';
import 'package:pokemon_app/pages/widgets/text_field.dart';

class MainScreen extends StatefulWidget {
  final List<PokeModel> pokemonList;
  final List<PokeModel> filtredPokemonList;

  const MainScreen({
    super.key,
    required this.pokemonList,
    required this.filtredPokemonList,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 315,
                child: TextFieldWidget(
                  myHintText: 'bulbasaur',
                  onChange: (value) => searchPokemons(
                    context,
                    value,
                    widget.pokemonList,
                  ),
                ),
              ),
              IconButton(
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => FavoriteCubit(PokeRepository()),
                            child: const FavoriteLogic(),
                          ),
                        ),
                      ),
                  icon: const Icon(Icons.favorite)),
            ],
          ),
          Expanded(child: ListWidget(pokemonList: widget.filtredPokemonList)),
        ],
      ),
    );
  }
}

void searchPokemons(BuildContext context, String value, List<PokeModel> list) {
  final pokeCubit = BlocProvider.of<PokeCubit>(context);
  pokeCubit.searchingPokemon(value, list);
}
