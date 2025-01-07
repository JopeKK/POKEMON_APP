import 'package:bloc/bloc.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final Repo repo;

  FavoriteCubit(this.repo) : super(const FavoriteInitial()) {
    emit(const FavoriteInitial());
    getList();
  }

  Future<void> getList() async {
    final List<PokeModel> items;
    items = await repo.getFromDB();
    if (items.isEmpty) {
      emit(const FavoriteError());
      return;
    }
    emit(FavoriteList(items));
  }
}
