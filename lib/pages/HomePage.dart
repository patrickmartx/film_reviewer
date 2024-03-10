import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pageName = 'Filmes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text(
          pageName,
          style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              height: 1.22,
              color: Color.fromRGBO(52, 58, 64, 1),
              //rgba(52, 58, 64, 1)
              ),
        ),
      ),
      body: Column(children: [
        Container(
          child: SearchBox(),
        ),
        Container(
          child: SearchBar(
            leading: Icon(Icons.search),
            hintText: 'Pesquise filmes',
          ),
        )
      ]),
    );
  }
}

class SearchBox extends StatelessWidget {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              onChanged: (text) {
                searchText = text;
              },
              decoration: InputDecoration(
                  labelText: 'Pesquise filmes',
                  filled: true,
                  fillColor: Color.fromRGBO(241, 243, 245, 1),
                  // rgba(241, 243, 245, 1)
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: BorderSide.none,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
