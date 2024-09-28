import 'package:api_session2/controller/home_screen_controller.dart';
import 'package:api_session2/controller/search_screen_controller.dart';
import 'package:api_session2/view/product_details_screen/product_detials_screen.dart';
import 'package:api_session2/view/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context.read<HomeScreenController>().fetchProducts();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerObj = context.watch<HomeScreenController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => SearchScreenController(),
                        child: SearchScreen(),
                      ),
                    ));
              },
              icon: Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeScreenController>().fetchProducts();
        },
      ),
      body: Builder(
        builder: (context) {
          if (providerObj.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (providerObj.myProducts.isEmpty) {
            return Center(child: Text("No data"));
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeScreenController>().fetchProducts();
              },
              child: ListView.separated(
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetialsScreen(
                                  id: providerObj.myProducts[index].id
                                      .toString(),
                                ),
                              ));
                        },
                        child: Container(
                          color: Colors.yellow,
                          child: Column(
                            children: [
                              Image.network(
                                providerObj.myProducts[index].image.toString(),
                                height: 150,
                              ),
                              Text(providerObj.myProducts[index].title
                                  .toString()),
                              Text(providerObj.myProducts[index].id.toString()),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: providerObj.myProducts.length),
            );
          }
        },
      ),
    );
  }
}
