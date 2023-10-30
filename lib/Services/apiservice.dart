// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';
import 'package:project_one/Screens/Home/details_screen.dart';
import 'package:project_one/Screens/Home/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Models/user_model.dart';
import '../Screens/AuthScreen/login.dart';

class ApiServices {
  int page = 1;
  int? id;
  final baseURL = 'https://reqres.in/api/';

// SignUp

  signUp(String email, password) async {
    try {
      Response response = await post(Uri.parse('${baseURL}register'),
          body: {'email': email, 'password': password});
      // ignore: unused_local_variable
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        Get.to(const LoginScreen());
        Get.snackbar(
            "Registation", snackPosition: SnackPosition.BOTTOM, "Successfully");
        // print(data);
        // print('Token: ' + data['token']);
        print('Registration Successfully');
      } else {
        Get.snackbar(
            "Registation", snackPosition: SnackPosition.BOTTOM, "failed");
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Login

  logIn(String email, password) async {
    try {
      Response response = await post(Uri.parse('${baseURL}register'),
          body: {'email': email, 'password': password});
      // ignore: unused_local_variable
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        Get.to(const HomeScreen());
        Get.snackbar(
            "Login", snackPosition: SnackPosition.BOTTOM, "Successfully");
        // print(data);
        // print('Token: ' + data['token']);
        print('Login Successfully');
      } else {
        Get.snackbar("Login", snackPosition: SnackPosition.BOTTOM, "failed");
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

// Get Data

  Future<Map> getPosts() async {
    try {
      var response = await get(
        Uri.parse('${baseURL}users?page=$page}'),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.body);

        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (SocketExecption) {
      return Future.error("Error Fetcing Data");
    }
  }

// Get Profile Details

  Future<Map> getProileDetails({required int id}) async {
    try {
      var response = await get(
        Uri.parse(
          '${baseURL}users/$id',
        ),
      );

      if (response.statusCode == 200) {
        print(response.body);

        log(response.body);
        Get.to(const DetailsScreen());
        Get.snackbar(
          "User Detials Data",
          response.body,
          snackPosition: SnackPosition.BOTTOM,
        );

        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error!");
      }
    } catch (e) {
      return Future.error("Error Fetching Data");
    }
  }
}
