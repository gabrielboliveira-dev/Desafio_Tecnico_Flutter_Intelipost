import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:intl/date_symbol_data_local.dart';

import 'data/datasources/youtube_datasource.dart';
import 'data/datasources/ticketmaster_datasource.dart';
import 'data/repositories/artist_repository_impl.dart';

import 'domain/repositories/artist_repository.dart';

import 'presentation/providers/artist_provider.dart';
import 'presentation/pages/artist_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<http.Client>(create: (_) => http.Client()),

        Provider<YoutubeDataSource>(
          create: (context) =>
              YoutubeDataSource(client: context.read<http.Client>()),
        ),
        Provider<TicketmasterDataSource>(
          create: (context) =>
              TicketmasterDataSource(client: context.read<http.Client>()),
        ),

        Provider<ArtistRepository>(
          create: (context) => ArtistRepositoryImpl(
            youtubeDataSource: context.read<YoutubeDataSource>(),
            ticketmasterDataSource: context.read<TicketmasterDataSource>(),
          ),
        ),

        ChangeNotifierProvider<ArtistProvider>(
          create: (context) =>
              ArtistProvider(repository: context.read<ArtistRepository>()),
        ),
      ],

      child: MaterialApp(
        title: 'Intelipost Artist Search',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 2,
          ),
          cardTheme: CardThemeData(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        home: const ArtistSearchPage(),
      ),
    );
  }
}
