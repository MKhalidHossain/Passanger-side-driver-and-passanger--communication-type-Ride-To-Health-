import 'package:flutter/material.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';

class SavedPlaceSingeContainer extends StatelessWidget {
  final String title;
  final String subTitle;

  const SavedPlaceSingeContainer({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded( // <--- WRAP THE CONTENT THAT NEEDS TO BE CONSTRAINED
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration( // Changed to const
                    shape: BoxShape.circle,
                    color: Colors.white24,
                  ),
                  child: const Icon(
                    Icons.bookmark_border_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded( // <--- ADD A SECOND EXPANDED HERE
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // The text widgets inside here will now wrap/truncate
                    // to fit the space provided by this Expanded widget.
                    children: [
                      title.text16White500(), 
                      subTitle.text12Grey()
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SmallSemiTranparentButton(
          //   showIcon: true,
          //   sufixIcon: Icons.refresh,
          //   weight: 100,
          //   text: 'Rebook',
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }
}