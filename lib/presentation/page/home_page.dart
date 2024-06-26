import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:socialpreneur/data/static/app_data.dart';
import 'package:socialpreneur/domain/entity/venture.dart';
import 'package:socialpreneur/main.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_bloc.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_state.dart';
import 'package:socialpreneur/presentation/bloc/venture_module/venture_state.dart';
import 'package:socialpreneur/presentation/injector.dart';
import 'package:socialpreneur/presentation/page/chat_page.dart';
import 'package:socialpreneur/presentation/page/coming_soon_page.dart';
import 'package:socialpreneur/presentation/page/dashboard_page.dart';
import 'package:socialpreneur/presentation/page/new_venture_page.dart';
import 'package:socialpreneur/presentation/page/notification_page.dart';
import 'package:socialpreneur/presentation/page/profile_page.dart';
import 'package:socialpreneur/presentation/page/venture_page.dart';
import 'package:socialpreneur/presentation/providers/NavigationStateProvider.dart';
import 'package:socialpreneur/presentation/util/desktop_padding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      setState(() {});
    });
    return Consumer<NavigationStateProvider>(
        builder: (context, navigationStateProvider, _) {
      return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
        return LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            appBar: navigationStateProvider.currentDestination == 2
                ? null
                : AppBar(
                    toolbarHeight: kToolbarHeight *
                        (navigationStateProvider.currentDestination == 1
                            ? 1.5
                            : 1),
                    automaticallyImplyLeading: false,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    title: navigationStateProvider.currentDestination == 1
                        ? TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              labelText: 'Search',
                              suffixIcon: const Icon(Icons.search_outlined),
                            ),
                          )
                        : Text(
                            navigationStateProvider.currentDestination == 4
                                ? "@${(profileState is FetchedProfileState ? profileState.user.name.replaceAll(" ", "").toLowerCase() : "user")}"
                                : appName.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold),
                          ),
                    actions: navigationStateProvider.currentDestination == 0
                        ? [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationPage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.favorite_outline_rounded,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ChatPage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.messenger_outline,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ]
                        : navigationStateProvider.currentDestination == 4
                            ? [
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text("Sign out"),
                                            content: const Text(
                                                "Are you sure you want to sign out?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel")),
                                              TextButton(
                                                  onPressed: () {
                                                    FirebaseAuth.instance
                                                        .signOut();
                                                    Navigator.of(context)
                                                        .pushAndRemoveUntil(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const MyApp()),
                                                            (route) => false);
                                                  },
                                                  child:
                                                      const Text("Sign out")),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.menu_outlined),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ]
                            : [],
                  ),
            bottomNavigationBar: constraints.maxWidth <= 600
                ? CustomBottomNavigationBar(
                    currentIndex: navigationStateProvider.currentDestination,
                    onNavigated: (_) {
                      navigationStateProvider
                          .navigateTo(NavigationDestinations.values[_]);
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search_outlined),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add_box_outlined),
                        label: 'Create',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.business_outlined),
                        label: 'TBA',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle_outlined),
                        label: 'Profile',
                      ),
                    ],
                  )
                : null,
            //User roles: Investor - Innovator
            body: Row(
              children: [
                constraints.maxWidth > 600
                    ? NavigationDrawer(
                        selectedIndex:
                            navigationStateProvider.currentDestination,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          const NavigationDrawerDestination(
                            icon: Icon(Icons.home_outlined),
                            label: Text('Home'),
                          ),
                          const NavigationDrawerDestination(
                            icon: Icon(Icons.search_outlined),
                            label: Text('Search'),
                          ),
                          const NavigationDrawerDestination(
                            icon: Icon(Icons.add_box_outlined),
                            label: Text('Create'),
                          ),
                          const NavigationDrawerDestination(
                            icon: Icon(Icons.business_outlined),
                            label: Text('TBA'),
                          ),
                          const NavigationDrawerDestination(
                            icon: Icon(Icons.account_circle_outlined),
                            label: Text('Profile'),
                          ),
                        ],
                        onDestinationSelected: (value) {
                          navigationStateProvider
                              .navigateTo(NavigationDestinations.values[value]);
                        },
                      )
                    : const SizedBox(),
                Expanded(
                  child: DesktopPadding(
                    applyPadding:
                        navigationStateProvider.currentDestination != 2,
                    layoutConstraints: constraints,
                    child: Column(
                      children: navigationStateProvider.currentDestination == 0
                          ? <Widget>[
                              ...(profileState is FetchedProfileState
                                  ? [
                                      Expanded(
                                          child: DashboardPage(
                                        user: profileState.user,
                                      ))
                                    ]
                                  : [
                                      const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ]),
                            ]
                          : navigationStateProvider.currentDestination == 1
                              ? <Widget>[
                                  Expanded(
                                      child: SearchPage(
                                          searchController: _searchController))
                                ]
                              : navigationStateProvider.currentDestination == 2
                                  ? <Widget>[
                                      const Expanded(
                                        child: NewVenturePage(),
                                      )
                                    ]
                                  : navigationStateProvider
                                              .currentDestination ==
                                          3
                                      ? <Widget>[
                                          const Expanded(
                                            child: ComingSoonPage(),
                                          ),
                                        ]
                                      : navigationStateProvider
                                                  .currentDestination ==
                                              4
                                          ? <Widget>[
                                              Expanded(child:
                                                  Builder(builder: (context) {
                                                if (profileState
                                                    is ErrorProfileState) {
                                                  return const Center(
                                                    child: Text(
                                                        "Error fetching profile"),
                                                  );
                                                } else if (profileState
                                                    is FetchedProfileState) {
                                                  return ProfilePage(
                                                    user: profileState.user,
                                                  );
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              })),
                                            ]
                                          : <Widget>[],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      });
    });
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: VentureCategory.values
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 24),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.arrow_outward_rounded,
                                    size: 12,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    e.name,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder(
              bloc: Injector.fetchVentureBloc,
              builder: (context, state) {
                if (state is FetchedVenturesState) {
                  final venturesWithSearchCondition = state.ventures
                      .where(
                        (element) => element.name.toLowerCase().contains(
                              _searchController.text.toLowerCase(),
                            ),
                      )
                      .toList();
                  return ListView.separated(
                    itemBuilder: (context, itemIndex) {
                      final venture = venturesWithSearchCondition[itemIndex];
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => VenturePage(venture)));
                        },
                        leading: ClipOval(
                          child: Image.network(
                            venture.logo,
                            fit: BoxFit.cover,
                            height: 42,
                            width: 42,
                          ),
                        ),
                        title: Text(
                          venture.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          venture.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 8,
                      );
                    },
                    itemCount: venturesWithSearchCondition.length,
                    shrinkWrap: true,
                    primary: false,
                  );
                } else if (state is ErrorFetchingVenturesState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
