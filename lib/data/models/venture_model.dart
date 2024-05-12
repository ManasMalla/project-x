import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:socialpreneur/domain/entity/venture.dart';

class VentureModel extends Equatable {
  final String name;
  final String tagline;
  final bool isVerified;
  final String description;
  final VentureStage stage;
  final String logo;
  final String cover;
  final String targetAudience;
  final VentureCategory category;
  final String joinedDate;
  final int activeUsers;
  final String? url;
  final String problemStatement;
  final List<String> goals;
  final List<String> features;
  final MarketSizing marketSizing;
  final String competitors;

  const VentureModel({
    required this.name,
    required this.tagline,
    required this.isVerified,
    required this.description,
    required this.logo,
    required this.cover,
    required this.stage,
    required this.targetAudience,
    required this.category,
    required this.joinedDate,
    required this.activeUsers,
    this.url,
    required this.problemStatement,
    required this.goals,
    required this.features,
    required this.marketSizing,
    required this.competitors,
  });

  factory VentureModel.fromDocumentSnapshot(DocumentSnapshot snapshot) =>
      VentureModel(
        name: snapshot.get("name"),
        description: snapshot.get("description"),
        logo: snapshot.get("logo") ?? "",
        cover: snapshot.get("cover") ?? "",
        tagline: snapshot.get("tagline"),
        isVerified: snapshot.get("isVerified"),
        stage: VentureStage.values[snapshot.get("stage")],
        targetAudience: snapshot.get("targetAudience"),
        category: VentureCategory.values[snapshot.get("category")],
        joinedDate: snapshot.get("joinedDate"),
        activeUsers: snapshot.get("activeUsers"),
        url: snapshot.get("url"),
        problemStatement: snapshot.get("problemStatement"),
        goals: List<String>.from(snapshot.get("goals")),
        features: List<String>.from(snapshot.get("features")),
        marketSizing: MarketSizing(
          tam: snapshot.get("tam"),
          sam: snapshot.get("sam"),
          som: snapshot.get("som"),
          marketGrowth: snapshot.get("marketGrowth"),
          revenue: snapshot.get("revenue"),
          profit: snapshot.get("profit"),
          cost: snapshot.get("cost"),
          roi: snapshot.get("roi"),
        ),
        competitors: snapshot.get("competitors"),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "tagline": tagline,
        "isVerified": isVerified,
        "description": description,
        "logo": logo,
        "cover": cover,
        "stage": stage.index,
        "targetAudience": targetAudience,
        "category": category.index,
        "joinedDate": joinedDate,
        "activeUsers": activeUsers,
        "url": url,
        "problemStatement": problemStatement,
        "goals": goals,
        "features": features,
        "tam": marketSizing.tam,
        "sam": marketSizing.sam,
        "som": marketSizing.som,
        "marketGrowth": marketSizing.marketGrowth,
        "revenue": marketSizing.revenue,
        "profit": marketSizing.profit,
        "cost": marketSizing.cost,
        "roi": marketSizing.roi,
        "competitors": competitors,
      };

  Venture toEntity() => Venture(
      name: name,
      tagline: tagline,
      isVerified: isVerified,
      description: description,
      logo: logo,
      cover: cover,
      stage: stage,
      targetAudience: targetAudience,
      category: category,
      joinedDate: joinedDate,
      activeUsers: activeUsers,
      problemStatement: problemStatement,
      goals: goals,
      features: features,
      marketSizing: marketSizing,
      competitors: competitors);

  @override
  List<Object?> get props => [name];
}
