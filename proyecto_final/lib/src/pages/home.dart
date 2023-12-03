import 'package:flutter/material.dart';
import 'package:proyecto_final/src/models/peliculas.dart';
import 'package:proyecto_final/src/providers/peliculas.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _provider = PeliculasProvider();
  List<Result> peliculas = [];
  bool isLoading = false;
  bool hasMore = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _loadPeliculas();
  }

  Future<void> _loadPeliculas() async {
    if (isLoading || !hasMore) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
        isError = false;
      });

      final nextResults = await _provider.getPeliculas();
      setState(() {
        peliculas.addAll(nextResults);
        hasMore = nextResults.isNotEmpty; // Verifica si hay más resultados
      });
    } catch (error) {
      print('Error al cargar películas: $error');
      setState(() {
        isError = true; // Establece el estado de error
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Función para determinar si se ha alcanzado el final de la lista
  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
        _loadPeliculas();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Peliculas'),
      ),
      body: isError ? ErrorWidget(message:'Error al cargar peliculas', onRetry: _loadPeliculas,)
        : NotificationListener<ScrollNotification>(
        onNotification: _onNotification,
        child: ListView.builder(
          itemCount: peliculas.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < peliculas.length) {
              return ItemPeliculas(peliculas: peliculas[index]);
            } else {
              return _buildLoader();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return isLoading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container();
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, size: 150, color: Colors.red),
            Text(
              message,
              style: const TextStyle(fontSize: 28),
            ),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}


class ItemPeliculas extends StatelessWidget {
  const ItemPeliculas({
    Key? key,
    required this.peliculas,
  }) : super(key: key);

  final Result peliculas;

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