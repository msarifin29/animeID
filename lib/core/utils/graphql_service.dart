import 'package:app/core/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import 'graphql_parser.dart';

@lazySingleton
class GraphqlService {
  Future<Response> gql(
    String fileName,
    Map<String, dynamic> variables,
  ) async {
    return await http.post(
      Uri.parse(BaseUrl.aniList),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: await const GqlParser().gqlRequestBody(
        fileName,
        variables,
      ),
    );
  }
}
