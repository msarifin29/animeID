import 'package:app/core/core.dart';
import 'package:app/featues/genres/genres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({super.key, required this.genres});
  final GenreCollectionCubit genres;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: genres,
      child: SizedBox(
        width: double.infinity,
        height: kToolbarHeight,
        child: BlocBuilder<GenreCollectionCubit, GenreCollectionState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              failure: (message) =>
                  Center(child: RefreshButton(onPressed: () => genres.init())),
              success: (data) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.genreCollection.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Chip(
                        label: Text(data.genreCollection[i]),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
