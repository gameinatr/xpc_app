import 'package:xpc_app/models/courses/login_course_model.dart';
import 'package:xpc_app/utils/index.dart';

class CoursesProvider {
  Future<List<LoginCourseItem>> getAllCourses() async {
    final response = await Authorized().request(method: HttpMethod.get, endpoint: 'v2/success-login');
    print(response.statusCode);
    final list = response.data['courses'] as List;
    return list.map((json) => LoginCourseItem.fromJson(json)).toList();
  }
}
