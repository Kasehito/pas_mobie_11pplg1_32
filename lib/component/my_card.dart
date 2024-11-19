import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/database_controller.dart';
import '../model/team_model.dart';

class MyCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const MyCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Material(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: InkWell(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(12),
            child: child ?? const SizedBox(),
          ),
        ),
      ),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamModel team;
  final VoidCallback onTap;
  final DatabaseController controller = Get.find();

  TeamCard({
    super.key,
    required this.team,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      child: Row(
        children: [
          if (team.strBadge?.isNotEmpty ?? false)
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              child: Image.network(
                team.strBadge!,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.sports_soccer,
                      size: 40, color: Colors.grey);
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
              ),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              team.strTeam ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              team.isFavorite == 1 ? Icons.favorite : Icons.favorite_border,
              color: team.isFavorite == 1 ? Colors.red : null,
            ),
            onPressed: () => controller.toggleFavorite(team),
          ),
        ],
      ),
    );
  }
}
