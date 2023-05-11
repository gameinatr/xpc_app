import 'package:xpc_app/models/site/site_model.dart';
import 'package:xpc_app/utils/index.dart';

class SiteProvider {
  Future<SchoolSite> getSite(num siteId) async {
    final response = await Authorized().request(
        method: HttpMethod.get,
        endpoint: 'v2/membership/site/$siteId/');
    final siteData = response.data;
    return SchoolSite.fromJson(siteData);
  }
}
