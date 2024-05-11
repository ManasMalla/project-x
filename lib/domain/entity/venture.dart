import 'package:equatable/equatable.dart';
import 'package:socialpreneur/domain/entity/user.dart';

enum VentureStage { ideation, prototype, marketReady, established }

enum VentureCategory {
  education,
  health,
  finance,
  technology,
  agriculture,
  automobile
}

class MarketSizing {
  final String tam;
  final String sam;
  final String som;
  final int marketGrowth;
  final int revenue;
  final int profit;
  final int cost;
  final int roi;

  const MarketSizing(
      {required this.tam,
      required this.sam,
      required this.som,
      required this.marketGrowth,
      required this.revenue,
      required this.profit,
      required this.cost,
      required this.roi});
}

class Venture extends Equatable {
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

  const Venture({
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

  @override
  // TODO: implement props
  List<Object?> get props => [name];
}
