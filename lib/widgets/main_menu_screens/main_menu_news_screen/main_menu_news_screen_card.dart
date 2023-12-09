import 'package:flutter/material.dart';
import 'package:radio_christ_song/widgets/main_menu_screens/main_menu_radio_screen/main_menu_radio_screen.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../theme/app_colors.dart';

class MainMenuNews {
  final int id;
  final String title;
  final String text;
  final DateTime datetime;
  final String? imageUrl;
  final String? videoUrl;

  MainMenuNews({
    required this.id,
    required this.title,
    required this.text,
    required this.datetime,
    required this.imageUrl,
    required this.videoUrl,
  });
}

class MainMenuNewsScreenCardWidget extends StatefulWidget {
  final MainMenuNews news;

  const MainMenuNewsScreenCardWidget({super.key, required this.news});

  @override
  State<MainMenuNewsScreenCardWidget> createState() =>
      _MainMenuNewsScreenCardWidgetState();
}

class _MainMenuNewsScreenCardWidgetState
    extends State<MainMenuNewsScreenCardWidget> {
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    if (widget.news.videoUrl != null) {
      _youtubePlayerController = YoutubePlayerController.fromVideoId(
        params: const YoutubePlayerParams(
          showControls: true,
          mute: false,
          showFullscreenButton: true,
          loop: false,
        ),
        videoId: YoutubePlayerController.convertUrlToId(widget.news.videoUrl!)!,
        autoPlay: false,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: const [BoxShadow(color: Color(0x22FFFFFF), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.news.videoUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: YoutubePlayer(controller: _youtubePlayerController!),
            )
          else if (widget.news.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.news.imageUrl as String),
            ),
          const SizedBox(height: 5),
          Text(
            widget.news.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${widget.news.datetime.day}.${widget.news.datetime.month}.${widget.news.datetime.year}',
            style: TextStyle(color: Colors.white.withOpacity(0.6)),
          ),
          const SizedBox(height: 10),
          Text(widget.news.text),
        ],
      ),
    );
  }
}
