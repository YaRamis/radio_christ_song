part of 'main_menu_chart_tab.dart';

class MainMenuChartTrack {
  final int id;
  final int rating;
  final String title;
  final String author;
  final String? imageUrl;

  MainMenuChartTrack(RadioChartTrack chartTrack)
      : title = chartTrack.title,
        author = chartTrack.author,
        rating = chartTrack.rating,
        id = chartTrack.id,
        imageUrl = chartTrack.tagImage;
}

class MainMenuChartTabCardWidget extends StatelessWidget {
  final int index;
  final MainMenuChartTrack chartTrack;

  const MainMenuChartTabCardWidget({
    super.key,
    required this.index,
    required this.chartTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 25,
            child: Text(
              '${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 55,
            height: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: chartTrack.imageUrl != null
                  ? Image.network(chartTrack.imageUrl as String)
                  : Image.asset('assets/images/default_cover.png'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chartTrack.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontWeight: FontWeight.w700, height: 1),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    chartTrack.author,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            chartTrack.rating.toString(),
            style: TextStyle(
              color: chartTrack.rating == 0
                  ? Colors.white.withOpacity(0.5)
                  : (chartTrack.rating > 0
                      ? Colors.greenAccent
                      : Colors.redAccent),
              fontSize: 16,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
