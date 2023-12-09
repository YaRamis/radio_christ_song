import 'package:flutter/material.dart';
import 'package:radio_christ_song/widgets/common_widgets/app_buttons.dart';
import 'main_menu_order_screen_dialog.dart';

class MainMenuOrderTrack {
  final int id;
  final String title;
  final String author;
  final String? imageUrl;

  MainMenuOrderTrack({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
  });
}

class MainMenuOrderScreenCardWidget extends StatelessWidget {
  final MainMenuOrderTrack orderTrack;

  const MainMenuOrderScreenCardWidget({
    super.key,
    required this.orderTrack,
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
            width: 55,
            height: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: orderTrack.imageUrl != null
                  ? Image.network(orderTrack.imageUrl as String)
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
                    orderTrack.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontWeight: FontWeight.w700, height: 1),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    orderTrack.author,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          AppDefaultButton(
            onPressed: () {
              showDialog(
                barrierColor: const Color(0x55000000),
                builder: (context) =>
                    MainMenuOrderScreenDialogWidget(orderTrack: orderTrack),
                context: context,
              );
            },
            child: const Text('Заказать'),
          ),
        ],
      ),
    );
  }
}
