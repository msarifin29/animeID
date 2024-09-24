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
  final genres = getIt<GenreCollectionCubit>();
  final series = getIt<BrowseSeriesCubit>();

  final currentpage = ValueNotifier<int>(1);
  final input = TextEditingController();

  final _pagingController = PagingController<int, Media>(firstPageKey: 0);

  BrowseSeriesRepositoriesParam param = const BrowseSeriesRepositoriesParam();

  @override
  void initState() {
    genres.init();
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
