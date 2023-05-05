import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> fetchInfo() async {
  final response = await http.get(Uri.parse(
      "https://eb863a74-7a4e-4daf-9540-d2db8470c18e.mock.pstmn.io/marketplace/orders/123"));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server returns an error, throw an exception.
    throw Exception(
        'Failed to load data! Connect to the internet and try Again');
  }
}

Future<int> acceptOrder() async {
  final url =
      'https://eb863a74-7a4e-4daf-9540-d2db8470c18e.mock.pstmn.io/marketplace/orders/123/accept';

  try {
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      print(
          'Accept order request was successful. Response body: ${response.body}');
      return 1;
    } else {
      print('Accept order request failed. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error making accept order request: $error');
  }
  return 0;
}

Future<int> declineOrder() async {
  final url =
      'https://eb863a74-7a4e-4daf-9540-d2db8470c18e.mock.pstmn.io/marketplace/orders/123/decline';

  try {
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      print(
          'Decline order request was successful. Response body: ${response.body}');
      return 2;
    } else {
      print(
          'Decline order request failed. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error making decline order request: $error');
  }
  return 0;
}
