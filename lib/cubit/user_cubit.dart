import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  static final RefreshController refreshController = RefreshController();
  static final TextEditingController search = TextEditingController();
  int perPage = 14;
  int page = 1;

  void init() {
    search.text = '';
    getUserGithub();
  }

  void getUserGithub() async {
    try {
      var searchText = search.text;
      final url = Uri.parse(
          'https://api.github.com/search/users?q=$searchText&page=$page&per_page=$perPage');
      var response = await http.get(url);

      final jsonResult = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List items = jsonResult['items'];

        List<User> users =
            items.map((jsonUser) => User.fromJson(jsonUser)).toList();

        emit(UserLoaded._(
            list: users,
            totalCount: jsonResult['total_count'],
            perPage: perPage,
            page: page));
      }
    } catch (e, stackTrace) {
      log('Error : $e\nStacktrace : $stackTrace');
      emit(UserError._());
    } finally {
      refreshController.loadComplete();
    }
  }

  void onLoadMoreUser() async {
    var searchText = search.text;
    if (state is UserLoaded) {
      var st = state as UserLoaded;
      try {
        int page = 1 + st.page;
        final url = Uri.parse(
            'https://api.github.com/search/users?q=$searchText&page=$page&per_page=$perPage');
        var response = await http.get(url);
        final jsonResult = jsonDecode(response.body);

        if (response.statusCode == 200) {
          List items = jsonResult['items'];
          List<User> users =
              items.map((jsonUser) => User.fromJson(jsonUser)).toList();

          List oldData = st.list;
          users = [...oldData, ...users];

          final s = state as UserLoaded;
          emit(s.loaded(
              users: users,
              page: page,
              perPage: perPage,
              totalCount: jsonResult['total_count']));
        }
      } catch (e) {
        log('Error : $e');
        emit(UserError._());
      } finally {
        refreshController.loadComplete();
      }
    }
  }

  void onRefresh() {
    getUserGithub();
  }
}
