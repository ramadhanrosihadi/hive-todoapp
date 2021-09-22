import 'dart:convert';

import 'support.dart';
import 'user.dart';

class ResultApi {
  final int page;
  final int per_page;
  final int total;
  final int total_pages;
  final List<User> user;
  final Support? support;
  ResultApi({
    this.page = 0,
    this.per_page = 0,
    this.total = 0,
    this.total_pages = 0,
    this.user = const [],
    this.support,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'per_page': per_page,
      'total': total,
      'total_pages': total_pages,
      'user': user.map((x) => x.toMap()).toList(),
      'support': support?.toMap(),
    };
  }

  factory ResultApi.fromMap(Map<String, dynamic> map) {
    return ResultApi(
      page: map['page']?.toInt() ?? 0,
      per_page: map['per_page']?.toInt() ?? 0,
      total: map['total']?.toInt() ?? 0,
      total_pages: map['total_pages']?.toInt() ?? 0,
      user: User.fromListDynamic(map['data']),
      support: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultApi.fromJson(String source) => ResultApi.fromMap(json.decode(source));
}
