import 'package:dio_hub/app/Dio/dio.dart';
import 'package:dio_hub/graphql/graphql.dart';
import 'package:dio_hub/models/issues/issue_model.dart';
import 'package:dio_hub/models/repositories/repository_model.dart';
import 'package:dio_hub/models/search/search_issues_model.dart';
import 'package:dio_hub/models/search/search_repos_model.dart';
import 'package:dio_hub/models/search/search_users_model.dart';
import 'package:dio_hub/models/users/user_info_model.dart';

class SearchService {
  static final RESTHandler _restHandler = RESTHandler();
  static final GraphqlHandler _gqlHandler = GraphqlHandler();

  static Future<List<UserInfoModel>> searchUsers(String query,
      {String? sort,
      bool? ascending = false,
      int? perPage,
      int? page,
      bool refresh = false}) async {
    final response = await _restHandler.get(
      '/search/users',
      queryParameters: {
        'q': query,
        if (sort != null) 'sort': sort,
        if (ascending != null) 'order': ascending ? 'asc' : 'desc',
        'per_page': perPage,
        'page': page,
      },
      refreshCache: refresh,
    );
    return SearchUsersModel.fromJson(response.data).items!;
  }

  static Future<List<RepositoryModel>> searchRepos(String query,
      {String? sort,
      bool? ascending,
      int? perPage,
      int? page,
      bool refresh = false}) async {
    final response = await _restHandler.get(
      '/search/repositories',
      queryParameters: {
        'q': query,
        if (sort != null) 'sort': sort,
        if (ascending != null) 'order': ascending ? 'asc' : 'desc',
        'per_page': perPage,
        'page': page,
      },
      refreshCache: refresh,
    );
    return SearchReposModel.fromJson(response.data).items!;
  }

  static Future<List<IssueModel>> searchIssues(String query,
      {String? sort,
      bool? ascending = false,
      int? perPage,
      int? page,
      bool refresh = false}) async {
    final response = await _restHandler.get(
      '/search/issues',
      queryParameters: {
        'q': query,
        if (sort != null) 'sort': sort,
        if (ascending != null) 'order': ascending ? 'asc' : 'desc',
        'per_page': perPage,
        'page': page,
      },
      refreshCache: refresh,
    );
    return SearchIssuesModel.fromJson(response.data).items!;
  }

  // static Future<List<TrendingReposModel>> trendingRepos() async {
  //   Response response =
  //       await GetDio.getDio(baseURL: 'https://ghapi.huchen.dev').get(
  //     '/repositories',
  //   );
  //   List data = response.data;
  //   return data.map((e) => TrendingReposModel.fromJson(e)).toList();
  // }

  static Future<List<SearchMentionUsers$Query$Search$Edges?>>
      searchMentionUsers(String query, String type, {String? cursor}) async {
    final q = '$query${' type:$type'}';
    final res = await _gqlHandler.query(
      SearchMentionUsersQuery(
          variables: SearchMentionUsersArguments(query: q, after: cursor)),
    );
    final userEdges =
        SearchMentionUsers$Query.fromJson(res.data!).search.edges!;
    return userEdges;
  }
}
