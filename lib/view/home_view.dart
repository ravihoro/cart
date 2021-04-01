import 'package:cart/view/theme_switch.dart';
import 'package:cart/viewmodel/login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../models/item.dart';
import '../enums/viewstate.dart';
import '../viewmodel/base_model.dart';
import '../util/widgets.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BaseModel baseModel = Provider.of<BaseModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites_view');
            },
          ),
          CustomCartIcon(),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
              title: Text(
                'Theme',
              ),
              trailing: ThemeSwitch(),
            ),
            ViewModelBuilder<LoginViewModel>.nonReactive(
              builder: (context, model, child) {
                return ListTile(
                  title: Text(
                    'Sign Out',
                  ),
                  onTap: () async {
                    bool val = await model.logout();
                    if (val) {
                      Navigator.pushReplacementNamed(context, '/login_view');
                    } else {
                      print("Logout failed");
                    }
                  },
                );
              },
              viewModelBuilder: () => LoginViewModel(),
            ),
          ],
        ),
      ),
      body: ViewModelBuilder<HomeViewModel>.reactive(
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) {
          return model.state == ViewState.Loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.5,
                  ),
                  itemCount: model.items.length,
                  itemBuilder: (context, index) {
                    return customCard(model.items[index], context, baseModel);
                  },
                );
        },
        viewModelBuilder: () => HomeViewModel(),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   BaseModel baseModel = Provider.of<BaseModel>(context);

  //   return ViewModelBuilder<HomeViewModel>.reactive(
  //     onModelReady: (model) => model.loadData(),
  //     viewModelBuilder: () => HomeViewModel(),
  //     builder: (context, model, child) {
  //       return Scaffold(
  //         drawer: Drawer(
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 100,
  //               ),
  //               ListTile(
  //                 title: Text(
  //                   'Theme',
  //                 ),
  //                 trailing: ThemeSwitch(),
  //               ),
  //             ],
  //           ),
  //         ),
  //         appBar: AppBar(
  //           title: Text(
  //             'Items',
  //           ),
  //           actions: [
  //             IconButton(
  //               icon: Icon(Icons.favorite),
  //               onPressed: () {
  //                 Navigator.pushNamed(context, '/favorites_view');
  //               },
  //             ),
  //             CustomCartIcon(),
  //           ],
  //         ),
  //         body: model.state == ViewState.Loading
  //             ? Center(
  //                 child: CircularProgressIndicator(),
  //               )
  //             : GridView.builder(
  //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                   crossAxisCount: 2,
  //                   childAspectRatio: 2 / 2.5,
  //                 ),
  //                 itemCount: model.items.length,
  //                 itemBuilder: (context, index) {
  //                   return customCard(model.items[index], context, baseModel);
  //                 },
  //               ),
  //       );
  //     },
  //   );
  //}

  Widget customCard(Item item, BuildContext context, BaseModel baseModel) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/item_detail', arguments: item);
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Card(
          elevation: 10.0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Expanded(
                      child: Hero(
                        tag: item.id,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(
                                item.imageUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "${item.title}",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      '\$ ${item.price.toString()}',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
                Positioned(
                  right: 1.0,
                  top: 1.0,
                  child: IconButton(
                    icon: Icon(
                      baseModel.favoritesId.contains(item.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.deepPurpleAccent,
                    ),
                    onPressed: () {
                      if (baseModel.favoritesId.contains(item.id)) {
                        baseModel.removeFavorite(item);
                      } else {
                        baseModel.addFavorite(item);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
