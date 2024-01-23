import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/pages/favorite_movie_page.dart';
import 'package:movie/presentation/pages/tv_show_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({super.key});

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  int bottomNavIndex = 0;
  FocusNode focusNode = FocusNode();
  bool statusSearch = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<NowPlayingMoviesBloc>(context, listen: false)
          .add(FetchNowPlayingMovies());
    });
  }

  Widget navBottomNavigationRoute(int i) {
    switch (i) {
      case 0:
        return HomePageView(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height);
      case 1:
        return TvShowsPage();
      case 2:
        return FavoriteMoviePage();
      default:
        return HomePageView(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: navBottomNavigationRoute(bottomNavIndex),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Color.fromRGBO(210, 32, 60, 1),
                Color.fromRGBO(86, 66, 212, 1),
              ])),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                  Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                  Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: Colors.blueGrey,
        ))),
        child: BottomNavigationBar(
          selectedItemColor: kMikadoYellow,
          currentIndex: bottomNavIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: kRichBlack,
          unselectedItemColor: kDavysGrey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Movie',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'TV Show',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
          onTap: (selected) {
            setState(() {
              bottomNavIndex = selected;
            });
          },
        ),
      ),
    );
  }

  Widget HomePageView(double screenWidth, double screenHeight) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            const Background(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          // print("masuk ke klik");
                          // authC.removeEmailFromLocal();
                          // authC.logOut();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        )),
                    Container(
                      width: screenWidth * .7,
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: GradientBoxBorder(
                            gradient: LinearGradient(colors: [
                          Color.fromRGBO(210, 32, 60, 1),
                          Color.fromRGBO(86, 66, 212, 1),
                        ])),
                      ),
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText: "Type title, actor, game etc",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  gradient: statusSearch
                                      ? const LinearGradient(colors: [
                                          Color.fromRGBO(210, 32, 60, 1),
                                          Color.fromRGBO(86, 66, 212, 1),
                                        ])
                                      : null),
                              child: const Icon(
                                Icons.list_rounded,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic_none,
                          color: Colors.white,
                          size: 36,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Continue Watching", style: kHeading5),
                              const SizedBox(
                                height: 20,
                              ),
                              BlocBuilder<NowPlayingMoviesBloc,
                                  NowPlayingMoviesState>(
                                builder: (context, state) {
                                  if (state is NowPlayingMoviesLoading) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state is NowPlayingMoviesHasData) {
                                    return MovieList(state.result);
                                  } else if (state is NowPlayingMoviesError) {
                                    return Center(
                                      child: Text(state.message),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              // SizedBox(
                              //   height: screenHeight * .32,
                              //   child: movieC.isLoading.value
                              //       ? Center(
                              //           child: CircularProgressIndicator(),
                              //         )
                              //       : ListView.builder(
                              //           physics:
                              //               const BouncingScrollPhysics(),
                              //           scrollDirection: Axis.horizontal,
                              //           itemCount: movieC.movieModel
                              //                   ?.results.length ??
                              //               0,
                              //           itemBuilder: (context, index) {
                              //             return MovieCard(
                              //               title: movieC
                              //                       .movieModel
                              //                       ?.results[index]
                              //                       .title ??
                              //                   "no title",
                              //               rating: movieC
                              //                       .movieModel
                              //                       ?.results[index]
                              //                       .voteAverage
                              //                       .toString() ??
                              //                   "0",
                              //               linkImage: movieC
                              //                       .movieModel
                              //                       ?.results[index]
                              //                       .posterPath ??
                              //                   "",
                              //               id: movieC.movieModel
                              //                       ?.results[index].id ??
                              //                   0,
                              //             );
                              //           }),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Top Movie", style: kHeading5),
                              const SizedBox(
                                height: 20,
                              ),
                              // SizedBox(
                              //   height: screenHeight * .32,
                              //   child: movieC.isLoadingTop.value
                              //       ? Center(
                              //           child: CircularProgressIndicator(),
                              //         )
                              //       : ListView.builder(
                              //           physics:
                              //               const BouncingScrollPhysics(),
                              //           scrollDirection: Axis.horizontal,
                              //           itemCount: movieC.movieTopModel
                              //                   ?.results.length ??
                              //               0,
                              //           itemBuilder: (context, index) {
                              //             return MovieCard(
                              //               title: movieC
                              //                       .movieTopModel
                              //                       ?.results[index]
                              //                       .title ??
                              //                   "no title",
                              //               rating: movieC
                              //                       .movieTopModel
                              //                       ?.results[index]
                              //                       .voteAverage
                              //                       .toString() ??
                              //                   "0",
                              //               linkImage: movieC
                              //                       .movieTopModel
                              //                       ?.results[index]
                              //                       .posterPath ??
                              //                   "",
                              //               id: movieC.movieTopModel
                              //                       ?.results[index].id ??
                              //                   0,
                              //             );
                              //           }),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Popular on Movie it", style: kHeading5),
                              const SizedBox(
                                height: 20,
                              ),
                              // SizedBox(
                              //   height: screenHeight * .32,
                              //   child: movieC.isLoadingPopular.value
                              //       ? Center(
                              //           child: CircularProgressIndicator(),
                              //         )
                              //       : ListView.builder(
                              //           physics:
                              //               const BouncingScrollPhysics(),
                              //           scrollDirection: Axis.horizontal,
                              //           itemCount: movieC.moviePopularModel
                              //                   ?.results.length ??
                              //               0,
                              //           itemBuilder: (context, index) {
                              //             return MovieCard(
                              //               title: movieC
                              //                       .moviePopularModel
                              //                       ?.results[index]
                              //                       .title ??
                              //                   "no title",
                              //               rating: movieC
                              //                       .moviePopularModel
                              //                       ?.results[index]
                              //                       .voteAverage
                              //                       .toString() ??
                              //                   "0",
                              //               linkImage: movieC
                              //                       .moviePopularModel
                              //                       ?.results[index]
                              //                       .posterPath ??
                              //                   "",
                              //               id: movieC.moviePopularModel
                              //                       ?.results[index].id ??
                              //                   0,
                              //             );
                              //           }),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              child: statusSearch
                  ? Container(
                      margin: const EdgeInsets.only(top: 50),
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: screenWidth * .7,
                        height: screenHeight * .6,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.85),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: const GradientBoxBorder(
                              gradient: LinearGradient(colors: [
                            Color.fromRGBO(210, 32, 60, 1),
                            Color.fromRGBO(86, 66, 212, 1),
                          ])),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // ListTile(
                              //   title: Text(
                              //     "Search by...",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              //   trailing: IconButton(
                              //       onPressed: () {},
                              //       icon: const Icon(
                              //         Icons.close_rounded,
                              //         color: Colors.white,
                              //       )),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Quote",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Keywords",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Genres",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Title",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Year",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Director",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Actors",
                              //     style: GoogleFonts.nunito(
                              //         fontWeight: FontWeight.w500,
                              //         color: Colors.white,
                              //         fontSize: 18),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                // Navigator.pushNamed(
                //   context,
                //   MovieDetailPage.ROUTE_NAME,
                //   arguments: movie.id,
                // );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
