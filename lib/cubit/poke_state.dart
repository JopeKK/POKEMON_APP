part of 'poke_cubit.dart';

abstract class PokeState {
  const PokeState();
}

final class PokeInitial extends PokeState {
  const PokeInitial();
}

final class PokeLoading extends PokeState {
  const PokeLoading();
}

final class PokeError extends PokeState {
  const PokeError();
}

final class PokeMainScreen extends PokeState {
  final List<PokeModel> pokemonList;
  final List<PokeModel> flitredPokemonList;

  const PokeMainScreen(
    this.pokemonList,
    this.flitredPokemonList,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokeMainScreen &&
        other.pokemonList == pokemonList &&
        other.flitredPokemonList == flitredPokemonList;
  }

  @override
  int get hashCode => Object.hash(pokemonList, flitredPokemonList);
}

final class PokeFavoriteScreen extends PokeState {
  final List<PokeModel> pokemonList;

  const PokeFavoriteScreen(
    this.pokemonList,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokeMainScreen && other.pokemonList == pokemonList;
  }

  @override
  int get hashCode => pokemonList.hashCode;
}
