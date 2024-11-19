// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/team_model.dart';
// import 'dart:convert';

// class DatabaseController extends GetxController {
//   final data = <TeamModel>[].obs;
//   static const String favoritesKey = 'favorites';

//   @override
//   void onInit() {
//     loadFavorites();
//     super.onInit();
//   }

//   Future<void> toggleFavorite(TeamModel team) async {
//     team.isFavorite = team.isFavorite == 1 ? 0 : 1;
    
//     // Find if team exists in data list
//     int index = data.indexWhere((t) => t.strTeam == team.strTeam);
//     if (index >= 0) {
//       data[index] = team;
//     } else {
//       data.add(team);
//     }
    
//     await saveFavorites();
//   }

//   Future<void> saveFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String encodedData = json.encode(
//       data.map((team) => team.toJson()).toList(),
//     );
//     await prefs.setString(favoritesKey, encodedData);
//   }

//   Future<void> loadFavorites() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? jsonString = prefs.getString(favoritesKey);
    
//     if (jsonString != null) {
//       final List<dynamic> jsonList = json.decode(jsonString);
//       data.value = jsonList.map((json) => TeamModel.fromJson(json)).toList();
//     }
//   }
// }
