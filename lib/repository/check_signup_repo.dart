import 'package:clinicassistant/Constant/api.dart';
import 'package:clinicassistant/model/verify.dart';

class CheckSignUpRepository {
  //التعامل مع قاعدة البيانات
  String? returnMessage;
  Verify verify = Verify();
  Future<String?> checkSignUpRepo(
      String patientId, String verificationCode) async {
    try {
      int code = int.parse(verificationCode);
      var response = await API.dio.post(
          '${API.BaseUrlBack}' + '${API.patientsBack}' + '/${API.verifyBack}',
          data: {'patientId': patientId, 'code': code});
      verify = Verify.fromJson(response.data);
      print(response.statusCode);
      if (response.statusCode == 201) {
        print(verify.message);
        returnMessage = verify.message;
      } else if (response.statusCode == 401) {
        //اعادة رسالة لعدم وجود المستخدم
        //accessToken = AccessToken.fromJson(response.statusMessage as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        //this is the message for sending a wrong form of the number
        //phoneNumber must match /^09\\d{8}$/ regular expression

        print("4444444444444444444444444444444444444444444");
      }
      return returnMessage;
    } catch (exception) {
      throw Exception("Failed to create user: $exception ");
    }
  }
}
