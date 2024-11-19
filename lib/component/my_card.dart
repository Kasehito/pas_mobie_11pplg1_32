import 'package:flutter/material.dart';

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
  final String strTeam;
  final String strBadge;
  final VoidCallback onTap;
  final VoidCallback onPressed;

  const TeamCard({
    required this.strTeam,
    required this.strBadge,
    required this.onTap,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: onTap,
      child: Row(
        children: [
          if (strBadge.isNotEmpty)
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              child: Image.network(
                strBadge,
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
              strTeam,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.favorite),
          ),
        ],
      ),
    );
  }
}
