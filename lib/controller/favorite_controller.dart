import 'package:get/get.dart';
import '../model/team_model.dart';
import 'database_controller.dart';

class FavoriteController extends GetxController {
  var animeName = <TeamModel>[].obs;
  var animeWatched = <TeamModel>[].obs;

  DatabaseController databaseController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }


  void toggleWatched(TeamModel anime) {
    if (animeWatched.contains(anime)) {
      databaseController.toggleFavorite(anime);
    } else {
      databaseController.toggleFavorite(anime);
    }
  }

  bool isWatched(TeamModel anime) {
    return animeWatched.contains(anime);
  }
}
