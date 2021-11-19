import 'package:http/http.dart' as http;
import 'dart:convert';

var deftoken = "";

Future login(
  String email,
  String password,
) async {
  Map<String, dynamic> body = {
    'email': email,
    'password': password,
  };

  var url = Uri.parse("https://webino.id/api/login");
  var response = await http.post(
    url,
    headers: {
      "Accept": "Application/json",
    },
    encoding: Encoding.getByName("utf-8"),
    body: body,
  );

  var userData1 = jsonDecode(response.body);

  return userData1;
}

Future signUser(
  String mail,
  String pass,
  String fn,
  String cp,
) async {
  var url = Uri.parse("https://webino.id/api/register");
  var response = await http.post(url, headers: {
    "Accept": "Application/json"
  }, body: {
    'name': fn,
    'email': mail,
    'password': pass,
    'password_confirmation': cp,
  });
  var userData1 = jsonDecode(response.body);

  // if (convertDatatoJson['code'] == 200) {
  //   return User.getData(convertDatatoJson['data']);
  // }
  //print(convertDatatoJson['data']);
  return userData1;
}

Future otp(
  String _otp,
  String token,
) async {
  //final prefs = await SharedPreferences.getInstance();
  // final value = prefs.getString('token') ?? "";
  //dynamic token = value;

  var url = Uri.parse("https://webino.id/api/verifikasi");
  var response = await http.post(url, headers: {
    'Authorization': 'Bearer $token',
    "Accept": "Application/json",
  }, body: {
    'otp': _otp,
  });
  var respon = jsonDecode(response.body);
  return respon;
}

Future reOTP(
  String token,
) async {
  //final prefs = await SharedPreferences.getInstance();
  // final value = prefs.getString('token') ?? "";
  //dynamic token = value;

  var url = Uri.parse("https://webino.id/api/email/otp");
  var response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var respon = jsonDecode(response.body);
  return respon;
}
