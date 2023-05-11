import 'package:xpc_app/models/users/student_user_model.dart';
import 'package:xpc_app/utils/index.dart';

class UserProvider {
  Future<StudentUser> getUser(num siteId) async {
    final response = await Authorized().request(
        method: HttpMethod.get,
        endpoint: 'v2/membership/site/$siteId/student/');
    final userData = response.data;
    return StudentUser.fromJson(userData);
  }
}
