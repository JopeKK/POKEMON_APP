import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/poke_cubit.dart';
import 'package:pokemon_app/pages/basic_screen/error_screen.dart';
import 'package:pokemon_app/pages/basic_screen/initial_screen.dart';
import 'package:pokemon_app/pages/basic_screen/loading_screen.dart';
import 'package:pokemon_app/pages/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogicPage extends StatelessWidget {
  const LogicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Pokemon',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        scrolledUnderElevation: 3,
      ),
      body: BlocBuilder<PokeCubit, PokeState>(
        builder: (context, state) {
          if (state is PokeInitial) {
            return const InitialScreen();
          } else if (state is PokeError) {
            return  ErrorScreen(errorMessage: AppLocalizations.of(context)!.errorMainLogic);
          } else if (state is PokeLoading) {
            return const LoadingScreen();
          } else if (state is PokeMainScreen) {
            return MainScreen(
              pokemonList: state.pokemonList,
              filtredPokemonList: state.flitredPokemonList,
            );
          } 
          return ErrorScreen(errorMessage: AppLocalizations.of(context)!.errorMainLogic);
        },
      ),
    );
  }
}
