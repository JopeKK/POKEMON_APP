import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/catch_pokemon_cubit.dart';
import 'package:pokemon_app/pages/basic_screen/error_screen.dart';
import 'package:pokemon_app/pages/basic_screen/loading_screen.dart';
import 'package:pokemon_app/pages/catch_screen/catching_screen.dart';
import 'package:pokemon_app/pages/catch_screen/win_screen.dart';

class CatchLogic extends StatefulWidget {
  final String name;

  const CatchLogic({
    super.key,
    required this.name,
  });

  @override
  State<CatchLogic> createState() => _CatchLogicState();
}

class _CatchLogicState extends State<CatchLogic> {
  @override
  void initState() {
    super.initState();
    startGame(context, widget.name);
  }

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
      body: BlocBuilder<CatchPokemonCubit, CatchPokemonState>(
        builder: (context, state) {
          if (state is CatchInitial) {
            return const LoadingScreen();
          } else if (state is CatchSreen) {
            return CatchingScreen(
              name: widget.name,
              posx: state.posx,
              posy: state.posy,
              type: state.name,
              photo: state.type,
              posLeft: state.posLeft,
              posTop: state.posTop,
            );
          } else if (state is IGotHim) {
            return WinScreen(name: state.name);
          }
          return const ErrorScreen(errorMessage: 'problem catch');
        },
      ),
    );
  }

  void startGame(BuildContext context, String name) {
    final catchPokemonCubit = BlocProvider.of<CatchPokemonCubit>(context);
    catchPokemonCubit.test(name);
  }
}
