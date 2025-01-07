import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/data/poke_repository.dart';
import 'package:sensors_plus/sensors_plus.dart';

part 'catch_pokemon_state.dart';

class CatchPokemonCubit extends Cubit<CatchPokemonState> {
  final Repo repo;

  CatchPokemonCubit(this.repo) : super(const CatchInitial()) {}

  Future<void> test(String name) async {
    var random = Random();
    String pokeType;
    String pokePhoto;
    double posTop = random.nextInt(401) + 100;
    double posLeft = random.nextInt(151) + 100;

    [pokeType, pokePhoto] = await repo.getItemsLocal(name);

    final Stream<AccelerometerEvent> test = accelerometerEventStream();
    double posx = 300;
    double posy = 200;
    double gyroX;
    double gyroY;
    bool gotHim = false;
    emit(CatchSreen(pokeType, posx, posy, pokePhoto, posLeft, posTop));

    test.listen((AccelerometerEvent event) {
      gyroX = event.x;
      gyroY = event.y;
      if (gyroY < -2 && !gotHim) {
        posy = posy + 10;
      }
      if (gyroY > 3 && !gotHim) {
        posy = posy - 10;
      }
      if (gyroX < -3 && !gotHim) {
        posx = posx + 10;
      }
      if (gyroX > 3 && !gotHim) {
        posx = posx - 10;
      }
      if ((posy - posTop).abs() <= 20 && (posx - posLeft).abs() <= 30) {
        if (!gotHim) {
          gotHim = true;
          addToFirebase(name);
        }
        emit(IGotHim(name));
        return;
      } else {
        emit(CatchSreen(pokeType, posx, posy, pokePhoto, posLeft, posTop));
      }
    });
  }

  Future<void> addToFirebase(String name) async {
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
}
