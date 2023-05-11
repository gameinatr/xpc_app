import 'package:xpc_app/models/trainings/single_training_model.dart';
import 'package:xpc_app/utils/index.dart';

class SingleTrainingProvider {
  Future<SingleTraining> getSingleTraining(
      num siteId, num courseId, num moduleId, num trainingId) async {
    final trainingResponse = await Authorized().request(
        method: HttpMethod.get,
        endpoint:
            'v2/membership/site/$siteId/course/$courseId/module/$moduleId/trainings/$trainingId');
    final trainingData = trainingResponse.data;

    return SingleTraining.fromJson(trainingData);
  }
}
