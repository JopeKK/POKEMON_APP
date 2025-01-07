part of 'catch_pokemon_cubit.dart';

abstract class CatchPokemonState {
  const CatchPokemonState();
}

final class CatchInitial extends CatchPokemonState {
  const CatchInitial();
}

final class CatchSreen extends CatchPokemonState {
  final String name;
  final String type;
  final double posx;
  final double posy;
  final double posTop;
  final double posLeft;

  const CatchSreen(
      this.name, this.posx, this.posy, this.type, this.posLeft, this.posTop);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CatchSreen &&
        other.posx == posx &&
        other.posy == posy &&
        other.name == name &&
        other.type == type &&
        other.posLeft == posLeft &&
        other.posTop == posTop;
  }

  @override
  int get hashCode => Object.hash(name, posx, posy, type, posTop, posLeft);
}

final class IGotHim extends CatchPokemonState {
  final String name;

  const IGotHim(this.name);

  @override
  int get hashCode => name.hashCode;
}
