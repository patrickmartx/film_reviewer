import 'package:film_reviewer/src/data/http/HttpClient.dart';
import 'package:film_reviewer/src/data/http/Routes.dart';
import 'package:film_reviewer/src/data/repositories/MovieRepository.dart';
import 'package:film_reviewer/src/stores/MovieStore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.id});
  final int id;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  final MovieDetailsStore store = MovieDetailsStore(
    repository: MovieRepositoryImpl(
      client: HttpClientImpl(),
    ),
  );

  @override
  void initState() {
    super.initState();
    store.getMovieDetailsById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
          animation: Listenable.merge([
            store.isLoading,
            store.erro,
            store.movie,
          ]),
          builder: (context, child) {
            if (store.isLoading.value) {
              return const CircularProgressIndicator();
            }

            if (store.erro.value.isNotEmpty) {
              return Center(
                child: Text(store.erro.value),
              );
            }

            else {
              return ListView(
                children: [
                  BackBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 216.0,
                          height: 318.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                Routes().routePoster(store.movie.value!.posterPath),
                                fit: BoxFit.fill,
                              )),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${store.movie.value!.voteAverage}",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24.0,
                                  color: const Color.fromRGBO(0, 56, 76, 1),
                                ),
                              ),
                              TextSpan(
                                text: "/10",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: const Color.fromRGBO(134, 142, 150, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        Column(
                          children: [
                            Text(
                              store.movie.value!.title,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                color: const Color.fromRGBO(52, 58, 64, 1),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Título original:",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10.0,
                                      color:
                                          const Color.fromRGBO(94, 103, 112, 1),
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${store.movie.value!.originalTitle}",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.0,
                                      color:
                                          const Color.fromRGBO(94, 103, 112, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GrayBoxInfo(
                                    campoUm: "Ano",
                                    campoDois:
                                        "${store.movie.value!.releaseDate}"),
                                const Padding(
                                    padding: EdgeInsets.only(left: 10)),
                                GrayBoxInfo(
                                    campoUm: "Duração",
                                    campoDois: "${store.movie.value!.runtime.toString()}"
                                    )
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Wrap(
                              spacing: 8.0,
                              children: [
                                for (final genre in store.movie.value!.genres)
                                  WhiteBoxInfo(genre: genre),
                              ],
                            ),
                            SizedBox(
                              child: Column(
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(top: 60)),
                                  TextAndSubtextBox(
                                      campoUm: "Descrição",
                                      campoDois: [store.movie.value!.overview]),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 60)),
                                  GrayBoxFixSizeInfo(
                                      campoUm: "Orçamento",
                                      campoDois:
                                          ['\$ ${store.movie.value!.budget}']),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 5)),
                                  GrayBoxFixSizeInfo(
                                      campoUm: "Produtoras",
                                      campoDois: store.movie.value!.productionCompanies),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 60)),
                                  TextAndSubtextBox(
                                      campoUm: "Diretor",
                                      campoDois: store.movie.value!.directors),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 30)),
                                  TextAndSubtextBox(
                                      campoUm: "Elenco",
                                      campoDois: store.movie.value!.cast),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 60))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

class BackBox extends StatelessWidget {
  const BackBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 220, 0),
      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color.fromRGBO(241, 243, 245, 1),
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: TextButton.icon(
          icon: const Icon(Icons.arrow_back_ios),
          style: ButtonStyle(
              iconSize: MaterialStateProperty.all(15),
              iconColor: MaterialStateColor.resolveWith(
                  (states) => const Color.fromRGBO(109, 112, 112, 1))),
          label: Text(
            "Voltar",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(109, 112, 112, 1),
              fontSize: 12.0,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class GrayBoxInfo extends StatelessWidget {
  const GrayBoxInfo(
      {super.key, required this.campoUm, required this.campoDois});
  final String campoUm;
  final String campoDois;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(4.0),
        color: const Color.fromRGBO(241, 243, 245, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$campoUm:",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: const Color.fromRGBO(134, 142, 150, 1),
                ),
              ),
              TextSpan(
                text: " $campoDois",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: const Color.fromRGBO(52, 58, 64, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GrayBoxFixSizeInfo extends StatelessWidget {
  const GrayBoxFixSizeInfo(
      {super.key, required this.campoUm, required this.campoDois});
  final String campoUm;
  final List<String> campoDois;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      decoration: BoxDecoration(
        border: Border.all(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(4.0),
        color: const Color.fromRGBO(241, 243, 245, 1),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 15),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${campoUm.toUpperCase()}:",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                  color: const Color.fromRGBO(134, 142, 150, 1),
                ),
              ),
              TextSpan(
                text: " ${campoDois.join(", ")}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: const Color.fromRGBO(52, 58, 64, 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WhiteBoxInfo extends StatelessWidget {
  const WhiteBoxInfo({super.key, required this.genre});
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Color.fromRGBO(233, 236, 239, 1),
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 6),
          child: Text(
            genre.toUpperCase(),
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
              color: const Color.fromRGBO(94, 103, 112, 1),
            ),
          )),
    );
  }
}

class TextAndSubtextBox extends StatelessWidget {
  const TextAndSubtextBox(
      {super.key, required this.campoUm, required this.campoDois});
  final String campoUm;
  final List<String> campoDois;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            campoUm,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: const Color.fromRGBO(94, 103, 112, 1),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          Text(
            campoDois.join(", "),
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: const Color.fromRGBO(52, 58, 64, 1),
            ),
          ),
        ],
      ),
    );
  }
}
