import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/controller/detail_person_controller.dart';
import 'package:movie_app/models/person_model.dart';
import 'package:movie_app/utils/colors.dart';
import 'package:readmore/readmore.dart';

class DetailPersonView extends StatelessWidget {
  const DetailPersonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    print(id);
    return Scaffold(
      body: FutureBuilder<PersonModel>(
          future: DetailPersonController.getAllPersonDetail(id),
          builder: (context, snapshot) {
            print(snapshot.data?.birthday);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: blueColor,
                ),
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
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                          ),
                          color: Colors.white),
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      width: double.maxFinite,
                    ),
                  ),
                  expandedHeight: 600,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: FancyShimmerImage(
                      height: 600,
                      width: double.maxFinite,
                      imageUrl: snapshot.data?.profilePath == null
                          ? "https://i.pinimg.com/474x/56/51/92/565192fc7848fbb8abd85136497a095b.jpg"
                          : "https://image.tmdb.org/t/p/original/${snapshot.data?.profilePath}",
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          snapshot.data?.name ?? "Tidak ada data",
                          style: const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Age'),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    snapshot.data!.birthday == null
                                        ? "Tidak ada data"
                                        : DetailPersonController
                                            .convertBirtdayToAge(snapshot
                                                .data!.birthday
                                                .toString()),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Gender'),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    snapshot.data?.gender == null
                                        ? "Tidak ada data"
                                        : DetailPersonController
                                            .parseJenisKelamin(snapshot
                                                .data!.gender
                                                .toString()),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Birthday'),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    snapshot.data?.birthday == null
                                        ? "Tidak ada data"
                                        : DateFormat('dd MMMM yyyy').format(
                                            DateTime.parse(snapshot
                                                .data!.birthday
                                                .toString())),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Born in'),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    snapshot.data?.placeOfBirth ??
                                        "Tidak ada data",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
                              "Biography",
                              style: GoogleFonts.merriweather(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ReadMoreText(
                              snapshot.data?.biography.toString() ??
                                  "Tidak ada data",
                              trimLines: 12,
                              textAlign: TextAlign.justify,
                              colorClickableText: Colors.pink,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              moreStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: blueColor),
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  height: 1.5),
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
