import 'package:xpc_app/models/users/user_model.dart';
import 'package:xpc_app/utils/index.dart';

class UserProvider {
  Future<User> getUser(num siteId) async {
    final response = await Authorized().request(
        method: HttpMethod.get,
        endpoint: 'v2/membership/site/$siteId/student/');
    final userData = response.data;
    print('request');
    return User.fromJson(userData);
  }
}
