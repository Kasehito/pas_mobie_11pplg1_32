import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/team_controller.dart';
import '../component/my_card.dart';
import '../detailpage.dart';

class HomePage extends StatelessWidget {
  final TeamController teamController = Get.put(TeamController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => teamController.fetchTeamList(),
        child: Obx(() {
          if (teamController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (teamController.teamList.isEmpty) {
            return const Center(child: Text('No Teams Found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: teamController.teamList.length,
            itemBuilder: (context, index) {
              final team = teamController.teamList[index];
              return TeamCard(
                team: team,
                onTap: () {
                  Get.to(() => DetailPage(team: team));
                },
              );
            },
          );
        }),
      ),
    );
  }
}
