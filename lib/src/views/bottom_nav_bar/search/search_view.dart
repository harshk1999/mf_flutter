import 'package:flutter/material.dart';
import 'package:mf_app/src/app/repository/models/explore_models/search_model.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/bottom_nav_bar/search/search_view_model.dart';
import 'package:mf_app/src/views/explore/explore_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController searchController;
  late final SearchViewModel svm;
  List<String> recentSearches = [];
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    svm = context.read<SearchViewModel>();
    svm.fetchSearchResult(searchController.text);
  }

  void addToRecentSearches(String schemeName) {
    if (!recentSearches.contains(schemeName)) {
      setState(() {
        recentSearches.add(schemeName);
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextField(
          controller: searchController,
          cursorColor: Colors.black,
          onChanged: svm.onChanged,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search mutual funds..',
            hintStyle: TextStyle(
              color: Color(0xffA9AFB9),
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: svm.searchNotifier,
          builder: (_, searchState, __) {
            if (searchState is SearchResultLoaded ||
                searchState is SearchInitial) {
              List<SearchResult> searchResults = [];
              if (searchState is SearchResultLoaded) {
                searchResults = searchState.searchResultList;
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: searchResults.length,
                      itemBuilder: (_, index) {
                        SearchResult result = searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                AppRoutes.detailScreen,
                                arguments: ExploreScreenArguments(
                                    schemeId: result.schemeId, duration: '6M'));
                            addToRecentSearches(result.schemeName);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            child: Wrap(
                              runSpacing: 4,
                              children: [
                                Text(
                                  result.schemeName,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff5F6570)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                        thickness: 1,
                        color: Color(0xffEFF1F5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Trending',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xff5F6570)),
                  )
                ],
              );
            }

            if (searchState is SearchError) {
              return Center(
                child: Text(searchState.error),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
