import 'package:get/get.dart';
import '../model/team_model.dart';
import '../service/api_service.dart';

class TeamController extends GetxController {
  final ApiService apiService = ApiService();
  final teamList = <TeamModel>[].obs;
  final isLoading = false.obs;
  

  @override
  void onInit() {
    super.onInit();
    fetchTeamList();
  }

  Future<void> fetchTeamList() async {
    try {
      isLoading.value = true;
      List<TeamModel> response = await apiService.getTeamList();
      teamList.clear();
      teamList.addAll(response);
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Failed to load teams',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    isLoading.value = true;
    teamList.clear();
    await fetchTeamList();
    isLoading.value = false;
  }
}
