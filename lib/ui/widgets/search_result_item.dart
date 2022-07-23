import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_search_users_app/ui/theme/theme_font.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user.dart';

class SearchResultItem extends StatelessWidget {
  final User user;
  const SearchResultItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: CachedNetworkImage(
          imageUrl: user.avatarUrl!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  colorFilter:
                      const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
            ),
          ),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text(
        user.login!,
        style: defTextStyle.copyWith(fontSize: 12),
      ),
      onTap: () async {
        final url = Uri.parse(user.htmlUrl!);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
    );
  }
}
