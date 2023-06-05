import 'package:xpc_app/models/trainings/next_training_model.dart';
import 'package:xpc_app/models/courses/single_course_item_model.dart';
import 'package:xpc_app/utils/index.dart';

class SingleCourseProvider {
  Future<SingleCourse> getSingleCourse(int courseId, String courseLink) async {
    final uri = Uri.parse(courseLink);
    final host = uri.host;
    final siteResponse = await Authorized()
        .request(method: HttpMethod.get, endpoint: 'v2/membership/site/$host');
    final siteId = siteResponse.data['id'];
    final courseResponse = await Authorized().request(
        method: HttpMethod.get,
        endpoint:
            'v2/membership/site/$siteId/course/$courseId?page=course-home');
    final courseData = courseResponse.data;
    final courseVideoUrl = getVideoUrlFromCourseData(courseData);
    final nextUpTrainingsResponse = await Authorized().request(
        method: HttpMethod.get,
        endpoint:
            'v2/membership/site/$siteId/course/$courseId/next-up-trainings/?type=module&limit=4');
    final nextUpTrainingsData = nextUpTrainingsResponse.data as List;
    final nextUpTrainingsList =
        nextUpTrainingsData.map((json) => NextTraining.fromJson(json)).toList();

    return SingleCourse(
        draft: courseData['draft'],
        id: courseId,
        description: courseData['description'],
        nextTrainings: nextUpTrainingsList,
        siteId: siteId,
        title: courseData['title'],
        xpLabel: courseData['configs']['bottom_bar']['xp_label'],
        xxpLabel: courseData['configs']['bottom_bar']['xxp_label'],
        videoLink: courseVideoUrl ?? '');
  }
}
