part of 'tile_cubit.dart';

abstract class TileState {
  const TileState();
}

final class TileInitial extends TileState {}

final class TileError extends TileState{
}

final class TileLoaded extends TileState {
  final String name;
  final String type;

  const TileLoaded(
    this.name,
    this.type,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TileLoaded && other.name == name && other.type == type;
  }

  @override
  int get hashCode => Object.hash(
        name,
        type,
      );
}
