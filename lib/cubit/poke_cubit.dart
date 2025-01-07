import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';
import 'package:geolocator/geolocator.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'poke_state.dart';

class PokeCubit extends Cubit<PokeState> {
  final Repo repo;

  Timer? intervalTimer;

  PokeCubit(this.repo) : super(const PokeInitial()) {
    emit(const PokeLoading());
    initialLoadingData();
    generateLocation();
    loopLocationGenerator();
    moveToMainScreen();
  }

  Future<void> wyjazd() async {
    final SharedPreferences db = await SharedPreferences.getInstance();
    db.clear();
  }

  Future<void> initialLoadingData() async {
    final List<PokeModel> pokemonList = await repo.getAllNamesApi();
    if (pokemonList == []) {
      emit(const PokeError());
      return;
    }

    await repo.saveAllPokeToLocal(pokemonList);
  }

  Future<void> moveToMainScreen() async {
    //https://pokeapi.co/api/v2/pokemon

    List<PokeModel> pokemonList = await repo.loadAllPokeFromLocal();
    emit(PokeMainScreen(pokemonList, pokemonList));
  }

  Future<void> searchingPokemon(
    String search,
    List<PokeModel> pokemonList,
  ) async {
    List<PokeModel> filterdList = [];

    if (search.isEmpty) {
      emit(PokeMainScreen(pokemonList, pokemonList));
      return;
    }

    filterdList = pokemonList
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    emit(PokeMainScreen(pokemonList, filterdList));
  }

  Future<void> loopLocationGenerator() async {
    intervalTimer = Timer.periodic(const Duration(seconds: 10), (tick) {
      generateLocation();
    });
  }

  Future<void> generateLocation() async {
    final List<PokeModel> items = await repo.loadAllPokeFromLocal();

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('no service');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('no permition');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position locationData = await Geolocator.getCurrentPosition();

    double distanceClose = 2;

    for (var i = 0; i < items.length; i++) {
      //polska
      // double lat = 49.0 + (54.8 - 49.0) * Random().nextDouble();
      // double lng = 14.1 + (24.2 - 14.1) * Random().nextDouble();

      //usa
      double lat = 37.6544 + (42.0022 - 37.6544) * Random().nextDouble();
      double lng = -101.4781 + (-95.6810 - (-101.4781)) * Random().nextDouble();
      if (distance(
            lat,
            lng,
            locationData.latitude,
            locationData.longitude,
          ) <
          distanceClose) {
        items[i] = PokeModel(
          name: items[i].name,
          type: items[i].type,
          lat: lat,
          lng: lng,
          photo: items[i].photo,
          isClose: true,
        );
      } else {
        items[i] = PokeModel(
          name: items[i].name,
          type: items[i].type,
          lat: lat,
          lng: lng,
          photo: items[i].photo,
          isClose: false,
        );
      }
    }

    items.sort((a, b) => b.isClose ? 1 : 0 - (a.isClose ? 1 : 0));
    repo.saveAllPokeToLocal(items);
    emit(PokeMainScreen(items, items));
  }

  Future<void> addToFavorite(String name) async {
    final List<PokeModel> testList = await repo.getFromDB();
    for (var i = 0; i < testList.length; i++) {
      if (testList[i].name == name) {
        return;
      }
    }

    final List<PokeModel> items = await repo.loadAllPokeFromLocal();
    for (var i = 0; i < items.length; i++) {
      if (items[i].name == name) {
        repo.saveToDB(items[i]);
        break;
      }
    }
  }

  @override
  Future<void> close() {
    intervalTimer?.cancel();
    return super.close();
  }

  double distance(double lat1, double lon1, double? lat2, double? lon2) {
    return sqrt(pow(lat2! - lat1, 2) + pow(lon2! - lon1, 2));
  }
}
