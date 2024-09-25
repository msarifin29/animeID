// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:app/config/injector.dart';
import 'package:app/featues/series/series.dart';
import 'package:app/featues/series/ui/browse_series_widget.dart';

import 'genres/genres.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final series = getIt<BrowseSeriesCubit>();
  final genres = getIt<GenreCollectionCubit>();
  final currentpage = ValueNotifier<int>(1);
  final input = TextEditingController();

  final _pagingController = PagingController<int, Media>(firstPageKey: 0);

  BrowseSeriesRepositoriesParam param = const BrowseSeriesRepositoriesParam();

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;

      series.init(param.copyWith(page: currentpage.value));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => genres),
        BlocProvider(create: (context) => series),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('Anime ID')),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  BrowseSeriesInputWidget(
                    controller: input,
                    onFieldSubmitted: (v) {
                      param = const BrowseSeriesRepositoriesParam();
                      param = param.copyWith(search: input.text);
                      _pagingController.itemList = [];
                      _pagingController.appendPage([], 1);
                      _pagingController.refresh();
                    },
                  ),
                  IconButton(
                      onPressed: () async {
                        genres.init();
                        final g = await bs(context: context, genres: genres);
                        if (g == null || g.isEmpty) return;
                        param = const BrowseSeriesRepositoriesParam();
                        param = param.copyWith(genres: g);
                        _pagingController.itemList = [];
                        _pagingController.appendPage([], 1);
                        _pagingController.refresh();
                      },
                      icon: const Icon(
                        Icons.menu_open_rounded,
                        size: 50,
                      )),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.8,
                child: BlocListener<BrowseSeriesCubit, BrowseSeriesState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      orElse: () {},
                      success: (response) {
                        if (!response.page.pageInfo.hasNextPage) {
                          _pagingController
                              .appendLastPage(response.page.media ?? []);
                        } else {
                          final nextPageKey =
                              (_pagingController.nextPageKey ?? 1) + 1;
                          _pagingController.appendPage(
                            response.page.media ?? [],
                            nextPageKey,
                          );
                        }
                      },
                    );
                  },
                  child: PagedListView<int, Media>(
                    pagingController: _pagingController,
                    physics: const BouncingScrollPhysics(),
                    builderDelegate: PagedChildBuilderDelegate<Media>(
                      itemBuilder: (context, media, index) {
                        return BrowseSeriesWidget(media: media);
                      },
                      newPageProgressIndicatorBuilder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                      firstPageProgressIndicatorBuilder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BrowseSeriesInputWidget extends StatelessWidget {
  const BrowseSeriesInputWidget({
    super.key,
    this.controller,
    this.onFieldSubmitted,
  });
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.8,
      margin: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyMedium,
        onFieldSubmitted: onFieldSubmitted,
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

Future<List<String>?> bs({
  required BuildContext context,
  required GenreCollectionCubit genres,
}) async {
  final selectedChoices = ValueNotifier<List<String>>([]);

  void onSelected(String choice) {
    final newSelectedChoices = selectedChoices.value;
    if (selectedChoices.value.contains(choice)) {
      selectedChoices.value.remove(choice); // Deselect if already selected
    } else {
      selectedChoices.value.add(choice); // Select if not selected
    }
    selectedChoices.value = List.from(newSelectedChoices);
  }

  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return BlocProvider.value(
        value: genres,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<GenreCollectionCubit, GenreCollectionState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox(),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    failure: (message) => Center(child: Text(message)),
                    success: (data) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        child: ValueListenableBuilder(
                          valueListenable: selectedChoices,
                          builder: (context, v, _) {
                            return Column(
                              children: [
                                Wrap(
                                  spacing: 5,
                                  children: data.genreCollection.map(
                                    (e) {
                                      return ChoiceChip(
                                        label: Text(e),
                                        selected:
                                            selectedChoices.value.contains(e),
                                        onSelected: (_) => onSelected(e),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context, selectedChoices.value),
                  child: const Text('Submit')),
            ],
          ),
        ),
      );
    },
  );
}
