part of 'favorite_cubit.dart';

abstract class FavoriteState {
  const FavoriteState();
}

final class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

final class FavoriteError extends FavoriteState {
  const FavoriteError();
}

final class FavoriteList extends FavoriteState {
  final List<PokeModel> list;
  const FavoriteList(this.list);

   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteList && other.list == list;
  }

  @override
  int get hashCode => list.hashCode;
}
