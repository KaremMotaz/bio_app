import 'package:bio_app/core/theming/assets_data.dart';
import 'package:bio_app/core/theming/text_styles.dart';
import 'package:flutter/material.dart';

class LeaderboardUserBadge extends StatelessWidget {
  const LeaderboardUserBadge({
    super.key,
    required this.userRow,
  });

  final Map<String, Object> userRow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (userRow['rank'] == 1) ...[
          const Icon(Icons.padding),
          const SizedBox(height: 2),
        ],
    
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.amber,
                  width: 4,
                ),
              ),
            ),
            const CircleAvatar(
              radius: 42,
              backgroundImage: AssetImage(
                AssetsData.profileImage,
              ),
            ),
            Positioned(
              bottom: -10,
              child: Container(
                alignment: Alignment.center,
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.amber,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Text(
                  "${userRow['rank']}",
                  style: TextStyles.bold14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "${userRow['name']}",
          style: TextStyles.bold14.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
