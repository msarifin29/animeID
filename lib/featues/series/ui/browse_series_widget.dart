// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:app/featues/series/series.dart';

class BrowseSeriesWidget extends StatelessWidget {
  const BrowseSeriesWidget({super.key, required this.media});

  final Media media;

  @override
  Widget build(BuildContext context) {
    final genres = media.genres ?? [];

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: double.infinity,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoverImage(
              image: media.coverImage.medium ?? '',
              averageScore: media.averageScore ?? 0,
              popularity: media.popularity ?? 0,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.65,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    height: kToolbarHeight - 40,
                    child: Text(
                      media.title.userPreferred ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    height: kToolbarHeight - 20,
                    child: Text(
                      media.description ?? '',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                  ),
                  Wrap(
                    spacing: 3,
                    runSpacing: 3,
                    children: genres.map((e) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          e,
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.image,
    this.averageScore = 0,
    this.popularity = 0,
  });

  final String image;
  final int averageScore;
  final int popularity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: 100,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Positioned(
            child: Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              child: Text('$averageScore'),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 25,
              width: 100,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.black87),
              child: Text(
                '$popularity',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
