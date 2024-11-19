import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/database_controller.dart';
import '../model/team_model.dart';

class MyListPage extends StatelessWidget {
  final DatabaseController databaseController = Get.find();

  MyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites'),
      ),
      body: Obx(() {
        final favorites = databaseController.data.where((team) => team.isFavorite == 1);
        
        if (favorites.isEmpty) {
          return Center(
            child: Text('No favorites yet'),
          );
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final team = favorites.elementAt(index);
            return ListTile(
              leading: team.strBadge != null
                  ? Image.network(
                      team.strBadge!,
                      width: 50,
                      height: 50,
                    )
                  : Icon(Icons.sports_soccer),
              title: Text(team.strTeam ?? ''),
              subtitle: Text(
                team.strDescriptionEN ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () => databaseController.toggleFavorite(team),
              ),
            );
          },
        );
      }),
    );
  }
}
