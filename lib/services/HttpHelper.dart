import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dreamhrms/model/on_boarding_model/task_details_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../controller/common_controller.dart';
import '../constants/exception.dart';

class HttpHelper {
  BuildContext? context = Get.context;

  Future<dynamic> get(String url, {bool auth = false}) async {
    Map<String, String> hd = await getHeaders(auth);

    print("Api URL:$url header:$hd");
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: hd);
      print("test response : $response code :${response.statusCode}");
      responseJson = _returnResponse(response);
    } catch (e) {
      print("web server error $e");
      throw FetchDataException('No Internet Connection', 500);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body,
      {bool auth = false, bool contentHeader = false}) async {
    Map<String, String> hd =
        await getHeaders(auth, contentHeader: contentHeader);
    print("Api URL:$url header $hd body : $body");
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), body: body, headers: hd);
      print(" Response : ${json.decode(response.body)}");
      responseJson = _returnResponse(response);
    } on SocketException {
      CommonController.to.buttonLoader=false;
      // throw FetchDataException('No Internet Connection', 500);
    }
    return responseJson;
  }

  multipartPostData(
      {String method = "POST",
      required String url,
      bool auth = false,
      String? encryptMessage}) async {
    Map<String, String> hd = await getHeaders(auth, contentHeader: false);
    var responseJson;
    try {
      print("Api URL:$url $hd");
      print("Encrypt $encryptMessage");
      var request = http.MultipartRequest('POST', Uri.parse(url));
      // if (auth == true)
      request.headers.addAll(hd);
      if (encryptMessage != null && encryptMessage.isNotEmpty)
        request.fields["request_data"] = encryptMessage;
      print('request ${request.fields["request_data"]}');
      var res = await request.send();
      print("RESPONSE $res");
        // var result = await res.stream.bytesToString();
        // var jsonResponse = json.decode(result); // Parse response into JSON
        // print("API Response : ${jsonResponse}");
        // return jsonResponse;
      var jsonResponse;
      try {
        var result = await res.stream.bytesToString();
        var jsonResponse = json.decode(result); // Parse response into JSON
        print("API Response : ${jsonResponse}");
        return jsonResponse;
      } on IOException {
        print("exception occur on IOException");
        CommonController.to.buttonLoader=false;
        throw FetchDataException('IOException occurred', 500);
      } on FormatException {
        print("exception occur on FormatException");
        CommonController.to.buttonLoader=false;
        throw FetchDataException('FormatException occurred', 500);
      }
    } on SocketException {
      CommonController.to.buttonLoader=false;
      print("exception occur on SocketException");
      throw FetchDataException(
           '', 500);
      // UtilService()
      //     .showToast(context, "error", message: responseJson.toString());
      // debugPrint("onSocket Exception ${responseJson.toString()}");
      return responseJson;
    }
  }


  commonImagePostMultiPart(
      {String method = "POST",
      required String url,
      bool auth = false,
      String? encryptMessage,
      required List<String> filePaths,
      required List<String> fileName,
      List<String>? fields,
      required List<String> fieldsName,
      String? type = "Path"}) async {
    Map<String, String> hd = await getHeaders(auth, contentHeader: false);
    var responseJson;
    try {
      print("Api URL:$url $hd FILE PATH LEN ${filePaths.length} FILE TYPE $type");
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (auth == true) request.headers.addAll(hd);
        for (int i = 0; i < filePaths.length; i++) {
          String key = fileName[i];
          String filePath = filePaths[i];
          request.files.add(await http.MultipartFile.fromPath(key, filePath));
          print('key $key values$filePath');
      }
      for (int i = 0; i < fields!.length; i++) {
        request.fields[fieldsName[i]] = fields![i];
      }

      var res = await request.send();
      print("Multipart response $res");
      print("Status code ${res.statusCode}");
      var result = await res.stream.bytesToString();
      var jsonResponse = json.decode(result); // Parse response into JSON
      print("image jsonResponse $jsonResponse");
      return jsonResponse;
    } on SocketException {
      print("exception occur");
      CommonController.to.buttonLoader=false;
      return responseJson;
    }
  }

  onBoardingFileUpload(
      {String method = "POST",
        required String url,
        bool auth = false,
        String? encryptMessage,
        required List<String> filePaths,
        required List<String> fileName,
        List<String>? fields,
        required List<String> fieldsName,
        String? type = "Path", List<TaskDetails>? taskDetails}) async {
    Map<String, String> hd = await getHeaders(auth, contentHeader: false);
    var responseJson;
    try {
      print("Api URL:$url $hd FILE PATH LEN ${filePaths.length} FILE TYPE $type");
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (auth == true) request.headers.addAll(hd);

        for (int i = 0; i < taskDetails!.length; i++) {
          request.fields['task_field_type[$i][id]'] = '${taskDetails[i].id}';
          request.fields['task_field_type[$i][field_type]'] = '${taskDetails[i].fieldType}';
          request.files.add(await http.MultipartFile.fromPath('task_field_type[$i][answer]', '${taskDetails[i].answer}'));
      }
      for (int i = 0; i < fields!.length; i++) {
        request.fields[fieldsName[i]] = fields[i];
      }
      print('request field ${request.fields}request files${request.files}');
      var res = await request.send();
      print("Multipart response $res");
      print("Status code ${res.statusCode}");
      var result = await res.stream.bytesToString();
      var jsonResponse = json.decode(result); // Parse response into JSON
      print("image jsonResponse $jsonResponse");
      return jsonResponse;
    } on SocketException {
      CommonController.to.buttonLoader=false;
      print("exception occur");
      return responseJson;
    }
  }

  dynamic _returnResponse(http.Response response) async {
    print('_returnResponse${response.statusCode}');
    if (response.statusCode == 500 || response.statusCode == 502) {
      throw FetchDataException('${jsonDecode(response.body)['message']}', 500);
    }
    // var responseBody = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.body;
        return jsonDecode(responseJson);
      case 400:
        var responseJson = response.body;
        return responseJson;
      case 404:
        var message = "";
        throw BadRequestException(message.toString(), response.statusCode);
      case 401:
      case 403:
        var message = "";
        throw UnauthorisedException("", message, response.statusCode);
        break;
      case 422:
        var responseJson = response.body.toString();
        return responseJson;
      case 502:
        throw FetchDataException('', 500);
      case 500:
        throw FetchDataException(
            '${json.decode(response.body)['message']}', 500);
      default:
        throw FetchDataException(
            '${json.decode(response.body)['message']}', 500);
    }
  }

  getHeaders(auth, {bool contentHeader = false}) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.accessControlAllowOriginHeader: "*",
      // "type":"mobile_app"
    };
    if (contentHeader == true) {
      headers.addAll({
        HttpHeaders.contentTypeHeader: "application/json",
      });
    }

    var token = GetStorage().read("Token");
    debugPrint("TOKEN $token");
    if (token != null && token.isNotEmpty) {
      headers.addAll({
        HttpHeaders.authorizationHeader: "$token",
      });
    }
    return headers;
  }
}
