import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/model/reviewModel.dart';
import 'authdata.dart';

class Review {
  Future<ReviewModel> getAllReview() async {
    var response = await ApiServices().getdata(Apiconstants.all_review);
    var body = json.decode(response.body);
    if (body["success"] == true) {
      var body = json.decode(response.body);
      ReviewModel _data = ReviewModel.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }
}