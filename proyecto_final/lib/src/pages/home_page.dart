import 'package:flutter/material.dart';
import 'package:proyecto_final/src/models/peliculas.dart';
import 'package:proyecto_final/src/providers/peliculas.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _provider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Peliculas'),),
      body: FutureBuilder(
        future: _provider.getPelicula(),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
          if(snapshot.hasError){
            return ErrorWidget(snapshot.error.toString());
          }

          if(snapshot.hasData){
            final peliculas = snapshot.data!;

            return ListView.builder(
              itemCount: peliculas.length,
              itemBuilder: (BuildContext context, int index){
                return ItemPelicula(pelicula: peliculas[index]);
              },
              
              );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


class ItemPelicula extends StatelessWidget {

  const ItemPelicula({
    super.key,
    required this.pelicula,
  });

  final Pelicula pelicula;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Card(
        child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: NetworkImage(pelicula.posterPath),
              width: 100,
              fit: BoxFit.cover,
              ),
      
              const SizedBox(height: 10,),
              Text(pelicula.titulo),
              const SizedBox(height: 10,),
              Text(pelicula.sinopsis),
          ],
        ),
        ),
      ),
    );
  }

}