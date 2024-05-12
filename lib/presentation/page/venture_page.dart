import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:socialpreneur/data/utils/capitalize.dart';
import 'package:socialpreneur/domain/entity/venture.dart';
import 'package:socialpreneur/presentation/util/desktop_padding.dart';
import 'package:socialpreneur/presentation/util/snackbar_util.dart';
import 'package:socialpreneur/presentation/widgets/cusom_horizontal_stepper.dart';
import 'package:url_launcher/url_launcher.dart';

class VenturePage extends StatelessWidget {
  final Venture venture;
  const VenturePage(this.venture, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    venture.cover,
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    alignment: Alignment.topLeft,
                  ),
                  Positioned(
                    bottom: -48,
                    left: 16,
                    child: ClipOval(
                      child: Image.network(
                        venture.logo,
                        height: 96,
                        width: 96,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.chevron_left_rounded),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            DesktopPadding(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              venture.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            venture.isVerified
                                ? Icon(
                                    Icons.verified,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : SizedBox(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber.shade700,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.star_half,
                                size: 20,
                                color: Colors.amber.shade700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      venture.tagline,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                    venture.stage == VentureStage.ideation
                                        ? Icons.lightbulb_outline_rounded
                                        : venture.stage ==
                                                VentureStage.prototype
                                            ? Icons.build_outlined
                                            : venture.stage ==
                                                    VentureStage.marketReady
                                                ? Icons.monetization_on_outlined
                                                : Icons.apartment_outlined,
                                    size: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  capitalize(venture.stage.name),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.group, size: 16),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  venture.targetAudience,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant
                                    .withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.category_outlined, size: 16),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  capitalize(venture.category.name),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                              // color: Theme.of(context)
                              //     .colorScheme
                              //     .primaryContainer
                              //     .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(24)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.calendar_month, size: 16),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Joined ${venture.joinedDate}",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        venture.activeUsers > 0
                            ? DecoratedBox(
                                decoration: BoxDecoration(
                                    // color: Theme.of(context)
                                    //     .colorScheme
                                    //     .primaryContainer
                                    //     .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(24)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.verified, size: 16),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${venture.activeUsers} active users",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(venture.description),
                    ...(venture.url != null
                        ? [
                            const SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                //TODO: Launch URL
                                final uri = Uri.tryParse(venture.url!);
                                if (uri != null) {
                                  launchUrl(uri);
                                } else {
                                  showSnackbar(context,
                                      "Oops! The link seems to be invalid.");
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.link_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    venture.url!.split("https://").last,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        : []),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              final _amountController = TextEditingController();
                              final _equityController = TextEditingController();
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                        onClosing: () {},
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Invest",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  "You are about to invest in ${venture.name}. Please enter the amount you wish to invest and the terms of the investment.",
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 150,
                                                      width: 150,
                                                      child: Stack(
                                                        children: [
                                                          SizedBox(
                                                            width: 150,
                                                            height: 150,
                                                            child:
                                                                CircularProgressIndicator(
                                                              backgroundColor: Theme
                                                                      .of(context)
                                                                  .colorScheme
                                                                  .primaryContainer,
                                                              value: venture
                                                                      .marketSizing
                                                                      .roi /
                                                                  100,
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  "${venture.marketSizing.roi}%",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleLarge
                                                                      ?.copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Text(
                                                                  "Return on Investment",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelSmall,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 24,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                _amountController,
                                                            decoration: InputDecoration(
                                                                prefixText: "₹",
                                                                labelText:
                                                                    "Amount",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14))),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          TextField(
                                                            controller:
                                                                _equityController,
                                                            decoration: InputDecoration(
                                                                labelText:
                                                                    "Equity",
                                                                suffixText: "%",
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            14))),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          FilledButton(
                                                            onPressed: () {
                                                              if (_amountController
                                                                      .text
                                                                      .isEmpty ||
                                                                  _equityController
                                                                      .text
                                                                      .isEmpty) {
                                                                showSnackbar(
                                                                    context,
                                                                    "Please fill in all the fields.");
                                                                return;
                                                              }
                                                              Navigator.pop(
                                                                  context);
                                                              showSnackbar(
                                                                  context,
                                                                  "Investment request sent successfully!");
                                                            },
                                                            child:
                                                                Text("Request"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.monetization_on_rounded,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Invest",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add,
                                size: 16,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Follow",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Problem Statement",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      venture.problemStatement,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Goals",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ...(venture.goals
                        .map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Icon(
                                      Icons.check,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(child: Text(e)),
                                ],
                              ),
                            ))
                        .toList()),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Features",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children:
                          venture.features.map((e) => FeatureChip(e)).toList(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Market Sizing",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venture.marketSizing.tam,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Text("TAM"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venture.marketSizing.sam,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Text("SAM"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              venture.marketSizing.som,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Text("SOM"),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Competitors",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      venture.competitors,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Milestones",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MilestoneWidget(),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Team",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      spacing: 32,
                      runSpacing: 16,
                      alignment: WrapAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                venture.name.toLowerCase() == "healomatic"
                                    ? "https://cdn.pixabay.com/photo/2024/02/12/17/23/ai-generated-8569065_1280.jpg"
                                    : "https://media.licdn.com/dms/image/D5603AQFYsCJRGlxWqQ/profile-displayphoto-shrink_400_400/0/1678267599550?e=2147483647&v=beta&t=tq3D4uZa0NHvTYCuCUbhqI67b2B77OJFH-V-L9uc3jI",
                                height: 72,
                                width: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              venture.name.toLowerCase() == "healomatic"
                                  ? "Sahasra C."
                                  : "Manas Malla",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Founder",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                        ...(venture.name == "STEMQuest" ||
                                venture.name == "AutoSmith"
                            ? [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        "https://images.nightcafe.studio/jobs/3SO0o4E3vquicLfDRrQX/3SO0o4E3vquicLfDRrQX--2--qoj58.jpg?tr=w-1600,c-at_max",
                                        height: 72,
                                        width: 72,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Rob M.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      "Co-Founder",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: Image.network(
                                        "https://storage.googleapis.com/pai-images/92653351d7be47cabf656ef2e34c24ec.jpeg",
                                        height: 72,
                                        width: 72,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Alexander L.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Text(
                                      "Co-Founder",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                    ),
                                  ],
                                ),
                              ]
                            : []),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                "https://media.licdn.com/dms/image/D4E03AQEzI2qF8-BtyA/profile-displayphoto-shrink_800_800/0/1707808780322?e=2147483647&v=beta&t=uImGCAocuLbHS8KpF2239bP1yWRj6ZZdM_NVCfoKM-w",
                                height: 72,
                                width: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Monica G.",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Mentor",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                "https://upload.wikimedia.org/wikipedia/commons/8/86/Woman_at_Lover%27s_Bridge_Tanjung_Sepat_%28cropped%29.jpg",
                                height: 72,
                                width: 72,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Sarayu K.",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "Mentor",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FeatureChip extends StatelessWidget {
  final String text;
  const FeatureChip(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Text(text),
        ));
  }
}

class MilestoneWidget extends StatelessWidget {
  const MilestoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: 64,
    //   child: ListView.separated(
    //       scrollDirection: Axis.horizontal,
    //       primary: false,
    //       shrinkWrap: true,
    //       itemBuilder: (context, index) {
    //         return Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Icon(Icons.flag_circle_outlined),
    //             SizedBox(
    //               height: 8,
    //             ),
    //             Text("Milestone $index"),
    //           ],
    //         );
    //       },
    //       separatorBuilder: (context, _) {
    //         return Center(
    //           child: Container(
    //             width: 24,
    //             height: 2,
    //             color: Theme.of(context).colorScheme.outline,
    //           ),
    //         );
    //       },
    //       itemCount: 10),
    // );
    return FlutterHorizontalStepper(
      steps: [
        "Milestone 1",
        "Milestone 2",
        "Milestone 3",
        "Milestone 4",
        "Milestone 5",
      ],
      radius: 40,
      currentStep: 1,
      child: [
        Icon(
          Icons.flag_circle_rounded,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        Icon(
          Icons.flag_circle_rounded,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        Icon(
          Icons.flag_circle_rounded,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        Icon(
          Icons.flag_circle_outlined,
          size: 40,
        ),
        Icon(
          Icons.flag_circle_outlined,
          size: 40,
        ),
      ],

      completeStepColor: Theme.of(context).colorScheme.outline,
      currentStepColor: Theme.of(context).colorScheme.outline,
      // inActiveStepColor: Colors.transparent,
    );
  }
}
