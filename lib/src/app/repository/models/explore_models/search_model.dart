class Search {
  final List<SearchResult> data;

  Search({
    required this.data,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? dataList = json['data'] as List<dynamic>?;

    return Search(
      data: dataList?.map((e) => SearchResult.fromJson(e)).toList() ?? [],
    );
  }
}

class SearchResult {
  final int schemeId;
  final String schemeName;
  final String schemeCode;

  SearchResult({
    required this.schemeId,
    required this.schemeName,
    required this.schemeCode,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        schemeId: json["scheme_id"],
        schemeName: json["scheme_name"],
        schemeCode: json["Scheme_code"],
      );
}
