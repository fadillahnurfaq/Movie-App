import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/controller/home_controller.dart';
import 'package:movie_app/models/popular_model.dart' as popularModel;
import 'package:movie_app/utils/colors.dart';

import '../../models/now_showing_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          "Movie App",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: const Icon(
                Icons.search,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Now Showing",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "See More",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),

            //* Bagian Now Showing
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<NowShowing>(
                  future: HomeController.getAllNowShowing(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.results!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Results? nowShowing = snapshot.data?.results?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/detail-movie',
                                  arguments: nowShowing?.id,
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: Colors.black,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: FancyShimmerImage(
                                    width: 175,
                                    height: 275,
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/w500/${nowShowing?.posterPath}",
                                    boxFit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              width: 180,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  nowShowing?.title ?? "Tidak ada data",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: ratingBintang,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${nowShowing?.voteAverage?.toStringAsFixed(1) ?? 0} / 10 IMDb",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w200),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "See More",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder<popularModel.PopularModel>(
                    future: HomeController.getAllPopular(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        // shrinkWrap: true,
                        itemCount: snapshot.data?.results?.length,
                        itemBuilder: (context, index) {
                          popularModel.Results? popular =
                              snapshot.data?.results?[index];
                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/detail-movie',
                                        arguments: popular?.id,
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      shadowColor: Colors.black,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: FancyShimmerImage(
                                          width: 200,
                                          height: 300,
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/w500/${popular?.posterPath}",
                                          boxFit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25.0,
                                        ),
                                        Text(
                                          "${popular?.title}",
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: ratingBintang,
                                              size: 30,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              "${popular?.voteAverage} / 10 IMDb",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                              size: 30,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              DateFormat("dd MMMM yyyy").format(
                                                DateTime.parse(popular
                                                        ?.releaseDate
                                                        .toString() ??
                                                    "Tidak ada data"),
                                              ),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
