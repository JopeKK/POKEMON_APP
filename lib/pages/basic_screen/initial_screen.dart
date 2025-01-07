import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/poke_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                AppLocalizations.of(context)!.welcomeText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () => moveToMain(context),
                child: Text(AppLocalizations.of(context)!.hopIn,
                    style: const TextStyle(color: Colors.black)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void moveToMain(BuildContext context) {
  final pokeCubit = BlocProvider.of<PokeCubit>(context);
  pokeCubit.moveToMainScreen();
}
