import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/cubit/tile_cubit.dart';
import 'package:pokemon_app/data/model/poke.dart';
import 'package:pokemon_app/pages/basic_screen/error_screen.dart';
import 'package:pokemon_app/pages/map_screen.dart';
import 'package:pokemon_app/pages/widgets/tile_views/list_tile_blanc.dart';
import 'package:pokemon_app/pages/widgets/tile_views/list_tile_loaded.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PokeListTile extends StatefulWidget {
  final PokeModel pokemon;
  const PokeListTile({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokeListTile> createState() => _PokeListTileState();
}

class _PokeListTileState extends State<PokeListTile>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapScreen(
            name: widget.pokemon.name,
            lat: widget.pokemon.lat,
            lng: widget.pokemon.lng,
            photo: widget.pokemon.photo,
          ),
        ),
      ),
      child: BlocBuilder<TileCubit, TileState>(
        builder: (context, state) {
          if (state is TileInitial) {
            return PokeTileBlanc(name: widget.pokemon.name);
          } else if (state is TileLoaded) {
            return PokeTileLoaded(
              name: state.name,
              type: state.type,
              isClose: widget.pokemon.isClose,
            );
          } else if (state is TileError) {
            return PokeTileBlanc(name: widget.pokemon.name);
          }
          return ErrorScreen(
              errorMessage: AppLocalizations.of(context)!.errorTile);
        },
      ),
    );
  }
}
