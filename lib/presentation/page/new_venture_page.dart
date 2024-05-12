import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socialpreneur/data/models/venture_model.dart';
import 'package:socialpreneur/data/utils/capitalize.dart';
import 'package:socialpreneur/domain/entity/venture.dart';
import 'package:socialpreneur/presentation/bloc/profile_module/profile_event.dart';
import 'package:socialpreneur/presentation/injector.dart';
import 'package:socialpreneur/presentation/providers/NavigationStateProvider.dart';
import 'package:socialpreneur/presentation/util/column_extension.dart';
import 'package:socialpreneur/presentation/util/snackbar_util.dart';

class NewVenturePage extends StatefulWidget {
  const NewVenturePage({super.key});

  @override
  State<NewVenturePage> createState() => _NewVenturePageState();
}

class _NewVenturePageState extends State<NewVenturePage> {
  VentureCategory? category;
  VentureStage? stage;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController taglineController = TextEditingController();
  final TextEditingController targetAudienceController =
      TextEditingController();
  final TextEditingController activeUsersController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController problemStatementController =
      TextEditingController();
  var goals = [];
  final TextEditingController goalsController = TextEditingController();
  var features = [];
  final TextEditingController featuresController = TextEditingController();
  final TextEditingController competitorsController = TextEditingController();
  final TextEditingController tamController = TextEditingController();
  final TextEditingController samController = TextEditingController();
  final TextEditingController somController = TextEditingController();
  XFile? logo;
  XFile? cover;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 280,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                InkWell(
                  onTap: () {
                    ImagePicker()
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      setState(() {
                        cover = value;
                      });
                    });
                  },
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    alignment: Alignment.topLeft,
                    child: cover != null
                        ? kIsWeb
                            ? Image.network(
                                cover!.path,
                                height: 280,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(cover!.path),
                                height: 280,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                        : null,
                  ),
                ),
                Positioned(
                  bottom: -48,
                  left: 16,
                  child: ClipOval(
                    child: InkWell(
                      onTap: () {
                        ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((value) {
                          setState(() {
                            logo = value;
                          });
                        });
                      },
                      child: Container(
                        color: Theme.of(context).colorScheme.primary,
                        height: 96,
                        width: 96,
                        child: logo != null
                            ? kIsWeb
                                ? Image.network(
                                    logo!.path,
                                    height: 96,
                                    width: 96,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(logo!.path),
                                    height: 96,
                                    width: 96,
                                    fit: BoxFit.cover,
                                  )
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Venture Information",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Name',
                  ),
                ),
                TextField(
                  controller: taglineController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Tagline',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: DropdownButtonFormField<VentureStage>(
                            items: const [
                          DropdownMenuItem(
                            value: VentureStage.ideation,
                            child: Text("Ideation"),
                          ),
                          DropdownMenuItem(
                            value: VentureStage.prototype,
                            child: Text("Prototype"),
                          ),
                          DropdownMenuItem(
                            value: VentureStage.marketReady,
                            child: Text("MVP"),
                          ),
                          DropdownMenuItem(
                            value: VentureStage.established,
                            child: Text("Established"),
                          ),
                        ],
                            onChanged: (_) {
                              setState(() {
                                stage = _;
                              });
                            },
                            value: stage,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              labelText: 'Stage',
                            ))),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        controller: targetAudienceController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'Target audience',
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: activeUsersController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Active Users (optional)',
                  ),
                ),
                Wrap(
                  spacing: 8,
                  children: VentureCategory.values
                      .map((e) => FilterChip(
                            label: Text(capitalize(e.name)),
                            onSelected: (_) {
                              setState(() {
                                if (e == category) {
                                  category = null;
                                  return;
                                }
                                category = e;
                              });
                            },
                            selected: category == e,
                          ))
                      .toList(),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Description',
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Additional information",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: problemStatementController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Problem statement',
                  ),
                ),
                TextField(
                  controller: goalsController,
                  onSubmitted: (value) => setState(() {
                    goals.add(value);
                    goalsController.clear();
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Goals',
                  ),
                ),
                ...(goals.isNotEmpty
                    ? [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Icon(Icons.check),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(goals[index]),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      goals.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                          itemCount: goals.length,
                          shrinkWrap: true,
                          primary: false,
                        ),
                        Divider(),
                      ]
                    : []),
                TextField(
                  controller: featuresController,
                  onSubmitted: (value) => setState(() {
                    features.add(value);
                    featuresController.clear();
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Features',
                  ),
                ),
                ...(features.isNotEmpty
                    ? [
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Icon(Icons.new_releases),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(features[index]),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      features.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                          itemCount: features.length,
                          shrinkWrap: true,
                          primary: false,
                        ),
                        Divider(),
                      ]
                    : []),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Market Sizing & Positioning",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tamController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'TAM',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        controller: samController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'SAM',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        controller: somController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14)),
                          labelText: 'SOM',
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: competitorsController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Competitors',
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        if (nameController.text.isEmpty ||
                            taglineController.text.isEmpty ||
                            stage == null ||
                            targetAudienceController.text.isEmpty ||
                            category == null ||
                            descriptionController.text.isEmpty ||
                            problemStatementController.text.isEmpty ||
                            goals.isEmpty ||
                            features.isEmpty ||
                            competitorsController.text.isEmpty ||
                            tamController.text.isEmpty ||
                            samController.text.isEmpty ||
                            somController.text.isEmpty) {
                          showSnackbar(context, "Please fill all fields");
                          return;
                        }
                        if (logo == null || cover == null) {
                          showSnackbar(context, "Please upload logo and cover");
                          return;
                        }
                        try {
                          final coverFile = File(cover!.path);
                          final logoFile = File(logo!.path);
                          final storageRef = FirebaseStorage.instance.ref();
                          final coverRef = storageRef.child(
                              "ventures/${nameController.text.replaceAll(" ", "-").toLowerCase()}/${cover!.name}");
                          final logoRef = storageRef.child(
                              "ventures/${nameController.text.replaceAll(" ", "-").toLowerCase()}/${logo!.name}");
                          print(coverRef.fullPath);
                          print(logoRef.fullPath);
                          showSnackbar(context, "Uploading images...");
                          if (kIsWeb) {
                            final coverUploadTask = coverRef
                                .putData(await coverFile.readAsBytes())
                                .then((p0) async {
                              final logoUploadTask = logoRef
                                  .putData(await logoFile.readAsBytes())
                                  .then((p1) async {
                                print(p0.state);
                                showSnackbar(context, "Images uploaded");
                                final coverUrl =
                                    await coverRef.getDownloadURL();
                                final logoUrl = await logoRef.getDownloadURL();
                                final venture = VentureModel(
                                  name: nameController.text,
                                  isVerified: false,
                                  logo: logoUrl,
                                  cover: coverUrl,
                                  joinedDate: DateFormat("MMM yyyy")
                                      .format(DateTime.now()),
                                  tagline: taglineController.text,
                                  stage: stage!,
                                  targetAudience: targetAudienceController.text,
                                  activeUsers: int.tryParse(
                                          activeUsersController.text) ??
                                      0,
                                  category: category!,
                                  description: descriptionController.text,
                                  problemStatement:
                                      problemStatementController.text,
                                  goals:
                                      goals.map((e) => e.toString()).toList(),
                                  features: features
                                      .map((e) => e.toString())
                                      .toList(),
                                  competitors: competitorsController.text,
                                  marketSizing: MarketSizing(
                                      tam: tamController.text,
                                      sam: samController.text,
                                      som: somController.text,
                                      marketGrowth: 120,
                                      revenue: 100,
                                      profit: 20,
                                      cost: 1000,
                                      roi: 10),
                                );
                                showSnackbar(context, "Creating venture...");
                                await Injector.firestore
                                    .collection("ventures")
                                    .doc(nameController.text
                                        .replaceAll(" ", "-")
                                        .toLowerCase())
                                    .set(venture.toJson());
                                showSnackbar(context, "Venture created");
                                await Injector.firestore
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "ventures": FieldValue.arrayUnion([
                                    Injector.firestore
                                        .collection("ventures")
                                        .doc(nameController.text
                                            .replaceAll(" ", "-")
                                            .toLowerCase())
                                  ])
                                }).then((value) {
                                  showSnackbar(
                                      context, "Venture added to profile");
                                  Injector.profileBloc.add(FetchProfileEvent(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid));
                                  Provider.of<NavigationStateProvider>(context,
                                          listen: false)
                                      .navigateTo(
                                          NavigationDestinations.profile);
                                });
                              });
                            });
                            return;
                          }
                          final coverUploadTask =
                              coverRef.putFile(coverFile).then((p0) {
                            final logoUploadTask =
                                logoRef.putFile(logoFile).then((p1) async {
                              print(p0.state);
                              showSnackbar(context, "Images uploaded");
                              final coverUrl = await coverRef.getDownloadURL();
                              final logoUrl = await logoRef.getDownloadURL();
                              final venture = VentureModel(
                                name: nameController.text,
                                isVerified: false,
                                logo: logoUrl,
                                cover: coverUrl,
                                joinedDate: DateFormat("MMM yyyy")
                                    .format(DateTime.now()),
                                tagline: taglineController.text,
                                stage: stage!,
                                targetAudience: targetAudienceController.text,
                                activeUsers:
                                    int.tryParse(activeUsersController.text) ??
                                        0,
                                category: category!,
                                description: descriptionController.text,
                                problemStatement:
                                    problemStatementController.text,
                                goals: goals.map((e) => e.toString()).toList(),
                                features:
                                    features.map((e) => e.toString()).toList(),
                                competitors: competitorsController.text,
                                marketSizing: MarketSizing(
                                    tam: tamController.text,
                                    sam: samController.text,
                                    som: somController.text,
                                    marketGrowth: 120,
                                    revenue: 100,
                                    profit: 20,
                                    cost: 1000,
                                    roi: 10),
                              );
                              showSnackbar(context, "Creating venture...");
                              await Injector.firestore
                                  .collection("ventures")
                                  .doc(nameController.text
                                      .replaceAll(" ", "-")
                                      .toLowerCase())
                                  .set(venture.toJson());
                              showSnackbar(context, "Venture created");
                              await Injector.firestore
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "ventures": FieldValue.arrayUnion([
                                  Injector.firestore.collection("ventures").doc(
                                      nameController.text
                                          .replaceAll(" ", "-")
                                          .toLowerCase())
                                ])
                              }).then((value) {
                                showSnackbar(
                                    context, "Venture added to profile");
                                Injector.profileBloc.add(FetchProfileEvent(
                                    uid: FirebaseAuth
                                        .instance.currentUser!.uid));
                                Provider.of<NavigationStateProvider>(context,
                                        listen: false)
                                    .navigateTo(NavigationDestinations.profile);
                              });

                              // Injector.firestore.collection("ventures").doc()
                            });
                          });
                        } catch (e) {
                          showSnackbar(context,
                              "Error uploading images: ${e.toString()}");
                        }
                      },
                      child: Text("Create Venture"),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text("Cancel"),
                    ),
                  ),
                ]),
              ],
            ).childrenPadding(
              const EdgeInsets.symmetric(vertical: 8),
            ),
          )
        ],
      ),
    );
  }
}
