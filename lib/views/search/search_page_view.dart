import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/controller/search_page_controller.dart';
import 'package:movie_app/utils/colors.dart';

import '../../models/search_model.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  void dispose() {
    super.dispose();
    SearchPageController.searchInput.dispose();
    SearchPageController.movieName.dispose();
    SearchPageController.searchResult.dispose();
  }

  @override
  void initState() {
    super.initState();
    SearchPageController.searchInput = TextEditingController();
    SearchPageController.movieName = TextEditingController();
    SearchPageController.searchResult = ValueNotifier([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find your favorite movie here"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: SearchPageController.movieName,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Judul',
                    suffixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: blueColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      SearchPageController.search();
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ValueListenableBuilder<List<Result>>(
                    valueListenable: SearchPageController.searchResult,
                    builder: (_, value, __) {
                      return SearchPageController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.amber),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: ListView.builder(
                                  itemCount: value.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, '/detail-movie',
                                                    arguments: value[index].id);
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
                                                    width: 200,
                                                    height: 300,
                                                    imageUrl:
                                                        "https://image.tmdb.org/t/p/w500/${value[index].posterPath}",
                                                    boxFit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${value[index].title}",
                                                    style: const TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        color: ratingBintang,
                                                        size: 30,
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        '${value[index].voteAverage?.toStringAsFixed(1) ?? "0"} / 10 IMDb',
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w200,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.calendar_month,
                                                        color: Colors.grey,
                                                        size: 30,
                                                      ),
                                                      const SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          DateFormat(
                                                                  'dd MMMM yyyy')
                                                              .format(
                                                            DateTime.parse(
                                                                value[index]
                                                                    .releaseDate
                                                                    .toString()),
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
