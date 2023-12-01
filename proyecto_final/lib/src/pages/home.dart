
import 'package:flutter/material.dart';
import 'package:proyecto_final/src/models/peliculas.dart';
import 'package:proyecto_final/src/providers/peliculas.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _provider = PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Peliculas'),
        ),
        body: FutureBuilder(
          future: _provider.getPeliculas(), 
          builder: 
            (BuildContext context, AsyncSnapshot<List<Peliculas>> snapshot){
              if (snapshot.hasError) {
                return ErrorWidget(message: snapshot.error.toString());
              }

              if (snapshot.hasData) {
                // obtener el listado de peliculas
                final peliculas = snapshot.data!; // Establece que la lista no es nula
                // retornar el widget con la lista de peliculas
                return ListView.builder(
                  itemCount: peliculas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemPeliculas(peliculas: peliculas[index]);
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error, size: 150, color: Colors.red),
          Text(
            message,
            style: const TextStyle(fontSize: 28),
          ),
        ],
      ),
    );
  }
}

class ItemPeliculas extends StatelessWidget {
  const ItemPeliculas({
    super.key,
    required this.peliculas,
  });

  final Peliculas peliculas;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(peliculas.originalTitle),
          ],
        ),
      ),
    );
  }
}