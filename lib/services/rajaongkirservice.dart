part of 'service.dart';

class RajaOngkirServices {
  // static Future<http.Response> getOngkir() {
  //   return http.post(
  //     Uri.https(Const.baseUrl, "/starter/cost"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Key': Const.apiKey,
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         "origin": '501',
  //         'destination': '114',
  //         'weight': 2500,
  //         'courier': 'jne'
  //       },
  //     ),
  //   );
  // }

  static Future<http.Response> sendEmail(String mail) {
    return http.post(
      Uri.https('ikanpaus.salahjurusan.com', "/cirestapi/api/mahasiswa"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': mail,
      }),
    );

  }
}
