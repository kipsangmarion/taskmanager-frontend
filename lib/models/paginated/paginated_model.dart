import 'package:taskmanager_frontend/models/paginated/links.dart';

import 'links.dart';

class PaginatedModel<T> {
  PaginatedModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.totalData,
    this.links,
    this.results,
  });
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? totalData;
  Links? links;
  List<T>? results;
}