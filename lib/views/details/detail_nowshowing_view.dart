import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/controller/detail_movie_controller.dart';

import 'package:movie_app/models/movie_detail_model.dart';

import 'package:movie_app/models/video_model.dart' as videoModel;
import 'package:movie_app/utils/colors.dart';
import 'package:movie_app/utils/url_launcher.dart';

import '../../models/cast_model.dart';

class DetailNowShowingView extends StatelessWidget {
  const DetailNowShowingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      body: FutureBuilder<MovieDetail>(
        future: DetailMovieController.getAllMovieDetail(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: FancyShimmerImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500/${snapshot.data?.backdropPath}',
                    height: 200,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 300,
                            child: Text(
                              "${snapshot.data?.title}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                              ),
                              // overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const Icon(Icons.bookmark_add_outlined, size: 30),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: ratingBintang,
                            size: 35,
                          ),
                          const SizedBox(
                            width: 4.0,
                          ),
                          Text(
                              "${snapshot.data?.voteAverage?.toStringAsFixed(1)} / 10 IMDb")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          for (var genre in snapshot.data?.genres as List)
                            Chip(
                              label: Text(
                                '${genre.name}'.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: Colors.grey[500],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Length"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                DetailMovieController.converMinutesToHours(
                                  snapshot.data!.runtime!.toInt(),
                                ),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Language"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                snapshot.data?.spokenLanguages?[0].name ??
                                    "Tidak ada data",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Status"),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                snapshot.data?.status ?? "Tidak ada data",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: GoogleFonts.merriweather(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            "${snapshot.data?.overview}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              height: 1.5,
                              color: Colors.black.withOpacity(.6),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Cast",
                        style: GoogleFonts.merriweather(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 350,
                        child: FutureBuilder<CastModel>(
                            future: DetailMovieController.getAllCast(id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.cast?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  Cast? cast = snapshot.data?.cast?[index];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/detail-person',
                                                  arguments: cast?.id);
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              shadowColor: Colors.black,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: FancyShimmerImage(
                                                  width: 150,
                                                  height: 150,
                                                  imageUrl: cast?.profilePath ==
                                                          null
                                                      ? "https://i.pinimg.com/474x/56/51/92/565192fc7848fbb8abd85136497a095b.jpg"
                                                      : "https://image.tmdb.org/t/p/w500/${cast?.profilePath}",
                                                  boxFit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            cast?.name ?? "Tidak ada data",
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                            // overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            cast?.character ?? "Tidak ada data",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Videos",
                            style: GoogleFonts.merriweather(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FutureBuilder<videoModel.VideoModel>(
                              future: DetailMovieController.getAllVideos(id),
                              builder: (context, snaphot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return SizedBox(
                                  height: 500,
                                  child: ListView.builder(
                                    itemCount: snaphot.data?.results?.length,
                                    itemBuilder: (context, index) {
                                      videoModel.Results? results =
                                          snaphot.data?.results?[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () => UrlLauncher.launchURL(
                                                  'https://www.youtube.com/watch?v=${results?.key}'),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Stack(
                                                  children: [
                                                    FancyShimmerImage(
                                                      width: 500,
                                                      height: 200,
                                                      imageUrl: results?.key ==
                                                              null
                                                          ? 'https://i.pinimg.com/474x/56/51/92/565192fc7848fbb8abd85136497a095b.jpg'
                                                          : 'https://img.youtube.com/vi/${results?.key}/0.jpg',
                                                      boxFit: BoxFit.cover,
                                                    ),
                                                    Positioned(
                                                      top: 75,
                                                      right: 175,
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      500),
                                                        ),
                                                        child: const Icon(
                                                          Icons.play_arrow,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              results?.name ?? "Tidak ada data",
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              })
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
