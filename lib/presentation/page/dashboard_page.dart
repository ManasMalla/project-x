import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialpreneur/domain/entity/user.dart';

class DashboardPage extends StatelessWidget {
  final User user;
  const DashboardPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome back,",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              user.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Here are some of the things you can do:",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      "Request from @loremipsum",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text("Request for collaboration to work on a project"),
                    SizedBox(height: 8),
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        "\"Let's work on something that is able to lorem ipsum dolor sit amet, consectetur adipiscing elit\"",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {},
                            child: Text("Accept"),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text("Decline"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "STEMQuest",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Checkbox(value: false, onChanged: (_) {}),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Milestone #${index + 1}"),
                                ],
                              );
                            },
                            itemCount: 5,
                            shrinkWrap: true,
                            primary: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AutoSmith",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Checkbox(value: false, onChanged: (_) {}),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text("Milestone #${index + 3}"),
                                ],
                              );
                            },
                            itemCount: 3,
                            shrinkWrap: true,
                            primary: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
