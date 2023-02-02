import 'dart:convert';

import 'package:chopper_demo/data/models/home_data.dart';
import 'package:chopper_demo/data/models/post.dart';
import 'package:chopper_demo/data/remote/post_api_service.dart';
import 'package:chopper_demo/data/resource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class PostNotifier extends ChangeNotifier {
  final _apiService = PostApiService.create();
  Resource _resource = Resource.initial;
  Resource get resource => _resource;
  void _setResource(Resource resource) {
    _resource = resource;
    notifyListeners();
  }

  Either<String, HomeData> _homeData = left("");
  Either<String, HomeData> get homeData => _homeData;

  void _setHome(Either<String, HomeData> homeData) {
    _homeData = homeData;
    notifyListeners();
  }

  void getHomeData() async {
    _setResource(Resource.loading);
    final results = await Future.wait([
      _apiService.getPosts(),
      _apiService.getPost(1),
    ]);
    try {
      final posts =
          (results[0].body as Iterable).map((e) => Post.fromJson(e)).toList();
      final post = Post.fromJson(results[1].body);
      _setHome(Right(HomeData(posts, post)));
    } catch (e) {
      _setHome(left(e.toString()));
    }
    _setResource(Resource.loaded);
  }

  // Future<Either<String, HomeData>> getHomeData() async {
  //   final results = await Future.wait([
  //     _apiService.getPosts(),
  //     _apiService.getPost(1),
  //   ]);
  //   try {
  //     final posts =
  //         (results[0].body as Iterable).map((e) => Post.fromJson(e)).toList();
  //     final post = Post.fromJson(results[1].body);
  //     return Right(HomeData(posts, post));
  //   } catch (e) {
  //     return left(e.toString());
  //   }
  // }
}
