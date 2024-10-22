import 'package:dreamhrms/controller/login_controller.dart';
import 'package:get/get.dart';

class PreferencesController extends GetxController {
  static PreferencesController get to =>
      Get.put(PreferencesController(), permanent: true);

  final List<String> Username = [];

  final List<String> Password = [];

  static List<String> getUsernameSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(to.Username);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  static List<String> getPasswordSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(to.Password);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }



}
 List<String> getUsernameAndPasswordSuggestions(String query) {
List<String> suggestions = <String>[];

// for (var credentials in LoginController.to.credentialsList) {
//   suggestions.add(LoginController.to.credentialsList["username"]!);
//   suggestions.add(credentials["password"]!);
// }
LoginController.to.credentialsList.forEach((cred) {
print('Username: ${cred.username}, Password: ${cred.password}');
var body={
  "username":cred.username,
  "password":cred.password,
};
suggestions.add(cred.username);
// suggestions.add(cred.password);
});
suggestions.retainWhere((suggestion) =>
suggestion.toLowerCase().contains(query.toLowerCase()));

return suggestions;
}