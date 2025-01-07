import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokemon_app/cubit/poke_cubit.dart';
import 'package:pokemon_app/data/poke_repository.dart';
import 'package:pokemon_app/pages/logic_page.dart';

//Text(AppLocalizations.of(context)!.helloWorld);
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Pokemon App',
      home: BlocProvider(
        create: (context) => PokeCubit(PokeRepository()),
        child: const LogicPage(),
      ),
    );
  }
}
