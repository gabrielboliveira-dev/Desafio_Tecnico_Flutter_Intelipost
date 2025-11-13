import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/artist_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ArtistResultPage extends StatelessWidget {
  const ArtistResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<ArtistProvider>(
            builder: (_, p, __) => Text(p.currentArtist),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.video_library), text: 'Vídeos'),
              Tab(icon: Icon(Icons.event), text: 'Eventos'),
            ],
          ),
        ),
        body: Consumer<ArtistProvider>(
          builder: (context, provider, child) {
            if (provider.state == ViewState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.state == ViewState.error) {
              return Center(child: Text(provider.errorMessage));
            }

            return TabBarView(
              children: [
                ListView.builder(
                  itemCount: provider.videos.length,
                  itemBuilder: (ctx, i) {
                    final video = provider.videos[i];
                    return Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl: video.thumbnailUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) =>
                                Container(color: Colors.grey),
                          ),
                        ),
                        title: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () => launchUrlString(
                          video.videoUrl,
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                    );
                  },
                ),

                provider.events.isEmpty
                    ? const Center(child: Text('Nenhum evento encontrado.'))
                    : ListView.builder(
                        itemCount: provider.events.length,
                        itemBuilder: (ctx, i) {
                          final event = provider.events[i];
                          final dateStr = DateFormat(
                            'dd/MM/yyyy',
                          ).format(event.date);
                          return Card(
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(event.name),
                              subtitle: Text(
                                '${event.venue} - ${event.city}\n$dateStr',
                              ),
                              isThreeLine: true,
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () => launchUrlString(
                                event.ticketUrl,
                                mode: LaunchMode.externalApplication,
                              ),
                            ),
                          );
                        },
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
