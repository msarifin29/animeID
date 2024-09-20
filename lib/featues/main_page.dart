import 'package:app/config/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'genres/genres.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final genres = getIt<GenreCollectionCubit>();

  @override
  void initState() {
    genres.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => genres,
      child: Scaffold(
        appBar: AppBar(title: const Text('Anime ID')),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              GenresWidget(genres: genres),
            ],
          ),
        ),
      ),
    );
  }
}
