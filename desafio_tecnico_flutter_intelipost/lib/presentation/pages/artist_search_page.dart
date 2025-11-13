import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/artist_provider.dart';
import 'artist_result_page.dart';

class ArtistSearchPage extends StatefulWidget {
  const ArtistSearchPage({Key? key}) : super(key: key);

  @override
  State<ArtistSearchPage> createState() => _ArtistSearchPageState();
}

class _ArtistSearchPageState extends State<ArtistSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchArtist() {
    final artistName = _searchController.text.trim();
    if (artistName.isNotEmpty) {
      context.read<ArtistProvider>().searchArtist(artistName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ArtistResultPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, digite o nome de um artista.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Artista'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nome do Artista',
                hintText: 'Ex: Coldplay, Taylor Swift',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: (_) => _searchArtist(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchArtist,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Buscar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
