import 'package:shared_preferences/shared_preferences.dart';
import 'package:draw/draw.dart';

Future<String> loadCreditentials() async {
  final pref = await SharedPreferences.getInstance();
  final key = "reddit_credditential";
  final value = pref.getString(key) ?? "null";

  return "null";
}

void saveCreditentials(Reddit redditTech) async {
  final pref = await SharedPreferences.getInstance();
  final key = "reddit_credditential";
  final value = redditTech.auth.credentials.toJson();

  pref.setString(key, value);
}
