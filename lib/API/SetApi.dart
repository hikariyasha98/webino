import 'dart:io';
//import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//import 'package:flutter/services.dart' show rootBundle;
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:async/async.dart';

import 'Models/ProdukModels.dart';

Future feedprodukPlus(int a) async {
  String b = a.toString();
  var url2 = Uri.parse("https://webino.id/api/products?page=$b");
  var response2 = await http.get(
    url2,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );

  var userData2 = jsonDecode(response2.body);
  return userData2;
}

Future feedprodukV2() async {
  var url = Uri.parse("https://webino.id/api/products");
  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );
  var userData1 = jsonDecode(response.body);
  var a = userData1['meta']['total_pages'];

  var url2 = Uri.parse("https://webino.id/api/products?page=$a");
  var response2 = await http.get(
    url2,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );

  var userData2 = jsonDecode(response2.body);

  return userData2;
}

Future totalPage() async {
  var url = Uri.parse("https://webino.id/api/products");
  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );
  var userData1 = jsonDecode(response.body);

  return userData1;
}

Future detailProduk(
  String token,
  String slug,
) async {
  //token == null

  var wasd = (token.length > 6) ? "produk" : "products";
  var url = Uri.parse("https://webino.id/api/$wasd/$slug");

  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      'Authorization': (token.length > 6)
          ? 'Bearer $token'
          : "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM",
    },
  );
  var userData1 = jsonDecode(response.body);

  return userData1;
}

Future fetchCategory() async {
  var url = Uri.parse("https://webino.id/api/category");
  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM",
    },
  );
  var userData1 = jsonDecode(response.body);

  return userData1;
}

// Future<Category> fetchCategory2() async {
//   var url = Uri.parse("https://webino.id/api/category");
//   final response = await http.get(
//     url,
//     headers: {
//       "Accept": "Application/json",
//       HttpHeaders.authorizationHeader:
//           "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM",
//     },
//   );
//   // var userData1 = jsonDecode(response.body);

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Category.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

Future fetchLokasi() async {
  var url = Uri.parse("https://api.rajaongkir.com/starter/city");
  var response = await http.get(url, headers: {
    "key": "3b7bf76291bff3f6611100c7b444ffa4",
  });
  var locationRSP = jsonDecode(response.body);

  return locationRSP;
}

Future fetchLokasiDummy() async {
  var url = Uri.parse("https://api.rajaongkir.com/starter/city");
  var response = await http.get(url, headers: {
    "key": "3b7bf76291bff3f6611100c7b444ffa4",
  });
  var locationRSP = jsonDecode(response.body);
  var code = locationRSP['rajaongkir']['status']['code'];
  if (code == 200) {
    List a = [];
    var result = locationRSP['rajaongkir']['results'];
    a = result;
    a.forEach((element) {
      Map a = element;
      a.remove('province_id');
      a.remove('postal_code');
      a.remove('province');
      a.remove('city_id');

      element = a;
      return element;
    });

    var lesgo = jsonEncode(result);

    return lesgo;
  } else {
    var result = "error";
    return result;
  }
}

Future feedSlider() async {
  var url = Uri.parse("https://webino.id/api/slides");
  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );
  var sliderData = jsonDecode(response.body);

  return sliderData;
}

Future userPorfile(String token) async {
  var url = Uri.parse("https://webino.id/api/me");

  var response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var userData = jsonDecode(response.body);

  return userData;
}

Future logout() async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');
  // print(token);
  var url = Uri.parse("https://webino.id/api/logout");

  var response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var userData = jsonDecode(response.body);
  //print(userData);
  return userData;
}

Future setReminder(
  int id,
  String a,
  String b,
  String c,
) async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  var url = Uri.parse("https://webino.id/api/add/reminder/$id");
  var response = await http.post(url, headers: {
    'Authorization': 'Bearer $token',
    "Accept": "Application/json",
  }, body: {
    "set_reminder_1": a,
    "set_reminder_2": b,
    "set_reminder_3": c
  });

  var reminderSetRSP = jsonDecode(response.body);

  return reminderSetRSP;
}

Future deleteReminder(
  int id,
) async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');
  var url = Uri.parse("https://webino.id/api/destroy/reminder/$id");
  var response = await http.delete(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var reminderSetRSP = jsonDecode(response.body);

  return reminderSetRSP;
}

Future checkreminder() async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  var url = Uri.parse("https://webino.id/api/reminder?page=1");

  var response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var reminderSetRSP = jsonDecode(response.body);

  return reminderSetRSP;
}

Future checkreminderplus(int i) async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  var url = Uri.parse("https://webino.id/api/reminder?page=$i");

  var response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var reminderSetRSP = jsonDecode(response.body);

  return reminderSetRSP;
}

Future updateReminder(
  int id,
  String a,
  String b,
  String c,
) async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  var url = Uri.parse("https://webino.id/api/add/reminder/update/$id");
  var response = await http.post(url, headers: {
    'Authorization': 'Bearer $token',
    "Accept": "Application/json",
  }, body: {
    "set_reminder_1": a,
    "set_reminder_2": b,
    "set_reminder_3": c
  });

  var reminderSetRSP = jsonDecode(response.body);

  return reminderSetRSP;
}

Future searchProduk(
  String query,
) async {
  final queue = {"q": query};

  // final queryParameters = {
  //   'param1': 'one',
  //   'param2': 'two',
  // };
// final uri =
//     Uri.https('www.myurl.com', '/api/v1/test/${widget.pk}', queryParameters);

  var url = Uri.https("webino.id", "/api/products", queue);
  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM",
    },
  );
  var userData1 = jsonDecode(response.body);

  return userData1;
}

Future uploadImage(
  File image,
  image2,
) async {
  //var formData1 = await FormData1();
  //Response response;
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  var postUri = Uri.parse('https://webino.id/api/update/foto_profile');

  // ignore: deprecated_member_use
  var stream = new http.ByteStream(DelegatingStream.typed(image.openRead()));

  var length = await image.length();

  var request = new http.MultipartRequest("POST", postUri);
  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Content-Type'] = 'Multipart/form-data';
  request.headers['Accept'] = 'Application/json';
  var multipartFile = new http.MultipartFile('image', stream, length,
      filename: basename(image.path));

  request.files.add(multipartFile);
  var respon = await request.send();

  var responseData = await respon.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);

  var d = jsonDecode(responseString);
  return d;
}

Future gantiPassword(
  String old,
  String newPass,
  String confirm,
) async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');
  Map<String, dynamic> body = {
    'current_password': old,
    'password': newPass,
    'password_confirmation': confirm,
  };

  var url = Uri.parse("https://webino.id/api/change-password");
  var response = await http.patch(
    url,
    headers: {
      "Accept": "Application/json",
      'Authorization': 'Bearer $token',
    },
    encoding: Encoding.getByName("utf-8"),
    body: body,
  );

  var userData1 = jsonDecode(response.body);

  return userData1;
}

Future userUpdate(String userName) async {
  final storage = new FlutterSecureStorage();
  var token = await storage.read(key: 'token');

  Map<String, dynamic> body = {
    'name': userName,
  };
  var url = Uri.parse("https://webino.id/api/profile");

  var response = await http.post(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
    body: body,
  );
  var userData = jsonDecode(response.body);

  return userData;
}

Future<String> findPath(String imageUrl) async {
  final cache = DefaultCacheManager();
  final file = await cache.getSingleFile(imageUrl);

  return file.toString();
}

Future feedprodukSepcialEvent(int a) async {
  String b = a.toString();
  var url2 = Uri.parse("https://webino.id/api/event/special?page=$b");
  var response2 = await http.get(
    url2,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );

  var userData2 = jsonDecode(response2.body);

  return userData2;
}

Future feedprodukSepcialEventPlus(int a) async {
  String b = a.toString();
  var url2 = Uri.parse("https://webino.id/api/event/special?page=$b");
  var response2 = await http.get(
    url2,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );
  var userData2 = jsonDecode(response2.body);
  int bc = userData2['meta']['total_pages'];

  var url = Uri.parse("https://webino.id/api/event/special?page=$bc");
  var response = await http.get(
    url,
    headers: {
      "Accept": "Application/json",
      HttpHeaders.authorizationHeader:
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5NDYyYzEyMi1mYTU1LTQzZDMtYmI3YS1kMDU2MGU3NmIwYjUiLCJqdGkiOiI5NGM1MTg1YmU5ZmEyNWZmMGQ2OTY5M2YwNWIzMjQ4M2FmYzlkOTI0ODA5MmY2MjI4MWEwNmQ1YmY4NGI4NzA0MWE3ODYyOGFmOGU1MWEzNyIsImlhdCI6MTYzMTUxODk2Ny40MzE1ODE5NzQwMjk1NDEwMTU2MjUsIm5iZiI6MTYzMTUxODk2Ny40MzE1ODYwMjcxNDUzODU3NDIxODc1LCJleHAiOjE2NjMwNTQ5NjcuNDI1NDA5MDc4NTk4MDIyNDYwOTM3NSwic3ViIjoiIiwic2NvcGVzIjpbXX0.o8nz9_gikRho4PXQvKRQOPvQ1kjD7YsTpb_4gu5oXn894HGwh8a0AnkQ6YPAP1ALoUtrX8CmNDC0wOPgvMo1R02V9aGMJN7aId8kPCoQsGJh3g7bLitJtfqYfULlU3K044Od5YxU7Gj3viZp7q6Mf7HU70uH87D_Vymp4kUGG4acVoza-BONCl4dJFOavoazfkXg1xSt9LnN8IfBje-RG8fsxTBq9VPIUU2owmXLxMi8aGpFjb7wO8XulesV3wSKW8GHpjt-q0c5EiSmtEM9R457evBopiAoHFpC3wnKUmVoQgtgWX_KUH1YFhimGzvfUXaO3bG-EJ-wmyvnSspG8a5Kd6jEzl5G_hmS7laCSgaihNCNkG4sQi9gz3eO2TyfyOZHzONsLcZRuL8kUHAF30U8Wjif935bfN_txBXz7U3MCkurb50azXT8tx8I2oNQ7hWB119fJ3tlvIbuj07qq_Me5xaUTxkiAtH6F6ljb92YqreWI_Ga_AmgRwy-o41X6FgCU46LIbvQinOxCZFicC1fHAY61ty8-qQWNeNrqy7To5C8KaOyIrws_6rWUw6Dqp994PU4ybhOaIHt1XAnvE-0oU6BFSemK7w-F2Glw-wyc1Y9D8zvIcNBXJT-r9nCsdofzNAp-X6VNdS9mALm87TJqO1VAiRp8mrZ-S5jOMM"
    },
  );
  var userData = jsonDecode(response.body);

  return userData;
}
