import '../../../auth/domain/user_entity.dart';
import '../../../../core/widgets/user_avatar.dart';
import 'package:flutter/material.dart';
import '../../../../core/theming/text_styles.dart';

class LeaderboardCard extends StatelessWidget {
  final UserEntity leaderboardEntity;

  const LeaderboardCard({
    super.key,
    required this.leaderboardEntity,
    required this.isCurrentUser,
    required this.score,
  });
  final bool isCurrentUser;
  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.white : const Color(0xffe8f9f9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isCurrentUser
                ? const Color(0xffededed)
                : const Color(0xffe8f9f9),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isCurrentUser
              ? const Color(0xffededed)
              : const Color(0xffe8f9f9),
          width: 3,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  Transform.translate(
                    offset: const Offset(1, 15),
                    child: Text(
                      leaderboardEntity.rank.toString(),
                      style: TextStyles.semiBold18,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(2, 0),
                    child: const Icon(
                      Icons.arrow_drop_up_rounded,
                      size: 40,
                      color: Color(0xfff6bb14),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  UserAvatar(
                    name:
                        "${leaderboardEntity.firstName} ${leaderboardEntity.lastName}",
                    savedColor: leaderboardEntity.avatarColor!,
                    imageUrl: leaderboardEntity.imageUrl,
                    radius: 25,
                    fontSize: 22,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    isCurrentUser
                        ? "ترتيبك الحالي"
                        : "${leaderboardEntity.firstName} ${leaderboardEntity.lastName}",
                    style: TextStyles.semiBold15,
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffd7e4e5),
            ),
            child: Text(
              textDirection: TextDirection.ltr,
              "$score XP",
              style: TextStyles.semiBold15,
            ),
          ),
        ],
      ),
    );
  }
}
