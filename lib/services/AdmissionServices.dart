import 'dart:convert';
import 'dart:math';

import 'package:admissionguidence/models/TodayTaskModel.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class AdmissionServices {
//   static Future<TodayTaskModel> getTasks()async {
//     var headers = {
//       'accept': 'application/json',
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'Cookie': 'PHPSESSID=51kr304budii650p43r5com1np'
//     };
//     var request = http.Request('POST', Uri.parse('https://admissionguidanceindia.com/appdata/task.php'));
//     request.body = json.encode({
//       'todayTask': '1',
//       'user_id': '5'
//     });
//     print(request);
//
//     print({
//       'todayTask': '1',
//       'user_id':'5'
//     }.toString());
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//     print("isme hh is time");
//     print(await response.stream.bytesToString());
//   ///  log(data);
//     var data = jsonDecode(await response.stream.bytesToString());
//
// print(response.statusCode);
//     if (response.statusCode == 200) {
//       return TodayTaskModel.fromJson(data);
// //      return TodayTaskModel.fromJson(data);
//     }
//     else {
//    return TodayTaskModel.fromJson(data);
//     }
//
//   }

  static Future<TodayTaskModel?> getTasks() async {
    var dio = Dio();

    var headers = {
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'PHPSESSID=vvcju75crp3ouekfvqigd22blu'
    };
    // var data = {
    //   'todayTask': '1',
    //   'user_id': '5'
    // };
    try {
      var response = await dio.post(
        'https://admissionguidanceindia.com/appdata/task.php',
        data: {'tasklist': '1', 'user_id': '5'},
        options: Options(
          headers: headers,
        ),
        // data: data,
      );

      // if (response.statusCode == 200) {
      //   print("insme hh sb kuch");
      //  /// jsonString = jsonString.trim();
      //   print(response.data);
      //   return TodayTaskModel.fromJson(response.data);
      // }
      // else {
      //   print(response.statusMessage);
      //   return TodayTaskModel.fromJson(response.data);
      // }

      if (response.statusCode == 200) {
        var responseData = response.data is String
            ? json.decode(response.data)
            : response.data;
        return TodayTaskModel.fromJson(responseData);
      } else {
        print('Failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed with error: $e');
    }
  }

  // static Future<TodayTaskModel?> getTasks() async {
  //   var headers = {
  //     'accept': 'application/json',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //     'Cookie': 'PHPSESSID=cbqnc2keb0kht7urer3pvnncm9'
  //   };
  //   var data = {
  //     'todayTask': '1',
  //     'user_id': '5'
  //   };
  //   var dio = Dio();
  //
  //   try {
  //     var response = await dio.request(
  //       'https://admissionguidanceindia.com/appdata/task.php',
  //       options: Options(
  //         method: 'POST',
  //         headers: headers,
  //       ),
  //       data: data,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print(json.encode(response.data));
  //       print(response.data);
  //       print("print response");
  //       return TodayTaskModel.fromJson(data);
  //
  //     } else {
  //       print('Error: ${response.statusMessage}');
  //     }
  //   } catch (e) {
  //     print('Exception caught: $e');
  //   }
  // }
}
