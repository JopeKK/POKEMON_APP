import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/favorite_cubit.dart';
import 'package:pokemon_app/cubit/poke_cubit.dart';
import 'package:pokemon_app/pages/basic_screen/error_screen.dart';
import 'package:pokemon_app/pages/favorite/favorite_screen.dart';
import 'package:pokemon_app/pages/basic_screen/loading_screen.dart';

class FavoriteLogic extends StatelessWidget {
  const FavoriteLogic({super.key});

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
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is PokeInitial) {
            return const LoadingScreen();
          } else if (state is FavoriteList) {
            return FavoriteScreen(favoritePoke: state.list);
          }
          return const ErrorScreen(errorMessage: 'problem favorite');
        },
      ),
    );
  }
}
