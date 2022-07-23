part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final int page;
  final int totalCount;
  final int perPage;
  final List<User> list;

  UserLoaded._(
      {required this.list,
      this.page = 1,
      this.perPage = 14,
      this.totalCount = 1});

  UserLoaded loaded(
      {required List<User> users, int? perPage, int? page, int? totalCount}) {
    return UserLoaded._(
        list: users,
        page: page ?? this.page,
        totalCount: totalCount ?? this.totalCount,
        perPage: perPage ?? this.perPage);
  }
}

class UserError extends UserState {
  final List<User> list;
  UserError._({this.list = const []});
}
