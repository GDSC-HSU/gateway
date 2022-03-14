import 'package:gateway/config/constants/service_constants.dart';
import 'package:gateway/model/organization_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrganizationService {
  Future<OrganizationInfo> getOrgPreview() async {
    final headers = <String, String>{
      AppConstantsService.API_KEY_HEADER: AppConstantsService.API_KEY,
      AppConstantsService.DEVICE_ACCESS_TOKEN_HEADER:
          AppConstantsService.DEVICE_ACCESS_TOKEN,
      AppConstantsService.PREFIX_CONTENT_TYPE: AppConstantsService.CONTENT_TYPE,
    };
    // url
    final url = Uri.parse(AppConstantsService.ORG_ENDPOINT +
        AppConstantsService.ENDPOINT_VERSION +
        AppConstantsService.ORG_PATH +
        "/" +
        AppConstantsService.ORG_ID);

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final orgInfo = OrganizationInfo.fromJson(json);
        return orgInfo;
      } else {
        // 404: missing field
        // 403: API-KEY invalid
        //         ACCESS-KEY invalid
        throw "[Dev] Error";
      }
    } catch (e) {
      throw "[Dev] Error";
    }
  }
}
