import 'package:api_session2/controller/search_screen_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchScreenProvider = context.watch<SearchScreenController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(
              controller: controller,
              leading: IconButton(
                  onPressed: () {
                    context
                        .read<SearchScreenController>()
                        .onSearch(controller.text);
                  },
                  icon: Icon(Icons.search)),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context
                      .read<SearchScreenController>()
                      .onSearch(controller.text);
                }
              },
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (searchScreenProvider.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (searchScreenProvider.newsArticles.isEmpty) {
                    return Center(
                      child: Text("No results found"),
                    );
                  } else {
                    return ListView.separated(
                        itemBuilder: (context, index) => Container(
                              child: ListTile(
                                title: Text(searchScreenProvider
                                    .newsArticles[index].title
                                    .toString()),
                                leading: CachedNetworkImage(
                                  imageUrl: searchScreenProvider
                                      .newsArticles[index].urlToImage
                                      .toString(),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),

                                // Image.network(searchScreenProvider
                                //     .newsArticles[index].urlToImage
                                //     .toString()),
                              ),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 20,
                            ),
                        itemCount: searchScreenProvider.newsArticles.length);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
