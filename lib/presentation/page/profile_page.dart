import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialpreneur/domain/entity/user.dart';
import 'package:socialpreneur/domain/entity/venture.dart';
import 'package:socialpreneur/presentation/page/venture_page.dart';
import 'package:socialpreneur/presentation/util/snackbar_util.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  widget.user.avatar,
                  height: 96,
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      widget.user.totalVentures.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text("ventures"),
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: [
                    Text(
                      widget.user.totalFollowers.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text("followers"),
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: [
                    Text(
                      widget.user.totalFollowing.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text("following"),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.user.name),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.user.pronoun,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.eco_outlined,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.user.ecoPoints} eco-points",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  )),
            ),
            Text(widget.user.bio),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).colorScheme.outline,
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  widget.user.location,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.cake_outlined,
                  color: Theme.of(context).colorScheme.outline,
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  "${widget.user.age} years old",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                //TODO: Launch URL
                final uri = Uri.tryParse(widget.user.link);
                if (uri != null) {
                  launchUrl(uri);
                } else {
                  showSnackbar(context, "Oops! The link seems to be invalid.");
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.link_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.user.displayLink,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                FilledButton(
                  onPressed: () {},
                  child: const Text("Edit Profile"),
                ),
                const SizedBox(
                  width: 8,
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("Share Profile"),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TabBar(
              tabs: [
                const Tab(
                  text: "Ventures",
                ),
                const Tab(
                  text: "Posts",
                ),
              ],
              controller: _tabController,
            ),
            const SizedBox(
              height: 12,
            ),
            LayoutBuilder(builder: (context, constraints) {
              return AutoScaleTabBarView(
                controller: _tabController,
                children: [
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 0.7),
                      itemBuilder: (context, index) {
                        final venture = widget.user.ventures[index] as Venture;
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VenturePage(venture)));
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    venture.logo,
                                    height: 86,
                                    width: 86,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  venture.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  venture.description,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: widget.user.ventures.length,
                    ),
                  ),
                  Container(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
