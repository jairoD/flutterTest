import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterTest/layouts/details.dart';
import 'package:flutterTest/models/item.dart';
import 'package:flutterTest/services/categoryProvider.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  Products({Key key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController _textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = size.height / 2;
    final double itemWidth = size.width / 3;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: _appBar(context),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: new FutureBuilder(
            future: readData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    jsonDecode(snapshot.data.toString());
                //print(data.keys.toList());
                var categories = data.keys.toList();
                categories.insert(0, "all");
                var all = getAllData(data);
                //var aux =
                //    data.entries.where((element) => element.key != "salads");
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: new Column(
                    children: [
                      new Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: categoryFilter(categories),
                        ),
                      ),
                      new Expanded(
                        child: new Consumer<CategoryProvider>(
                          builder: (context, categoryProvider, child) {
                            List<dynamic> myItems =
                                data[categoryProvider.category];
                            return itemsGrid(itemWidth, itemHeight,
                                categoryProvider, myItems, all);
                          },
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return new Text('no hay data');
              }
            },
          ),
        ));
  }

  AppBar _appBar(BuildContext context) {
    return new AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10),
        child: Container(
          height: 30.0,
          width: 40,
          child: RaisedButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffF4AF1D), Color(0xffD7306E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  constraints: BoxConstraints(maxWidth: 40.0, maxHeight: 40.0),
                  alignment: Alignment.center,
                  child: new ImageIcon(
                    AssetImage("assets/icons/back.png"),
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      centerTitle: true,
      title: new Text(
        'Chicks & Salsa',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline1,
      ),
      bottom: new PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Container(
              height: 48.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Theme.of(context).cursorColor,
                  decoration: new InputDecoration(
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                      suffixIcon: IconButton(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: new ImageIcon(
                            AssetImage("assets/icons/search.png"),
                            color: Theme.of(context).cursorColor,
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                          }),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                        left: 15,
                      ),
                      hintText: "Search for a milk or drink"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container itemsGrid(double itemWidth, double itemHeight,
      CategoryProvider categoryProvider, List myItems, all) {
    return Container(
      color: Colors.white,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: itemWidth / 180.0,
          crossAxisCount: 2,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount:
            categoryProvider.category != "all" ? myItems.length : all.length,
        itemBuilder: (context, index) {
          if (categoryProvider.category != "all") {
            Item aux = new Item.fromMap(myItems[index]);
            return Center(child: itemInfo(aux));
          } else {
            Item aux = new Item.fromMap(all[index]);
            return Center(child: itemInfo(aux));
          }
        },
      ),
    );
  }

  ListView categoryFilter(List<String> categories) {
    return new ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return GestureDetector(
                onTap: () {
                  categoryProvider.changeCategory(categories[index]);
                },
                child: Center(
                  child: new Text(
                    categories[index][0].toUpperCase() +
                        categories[index].substring(1),
                    style: categoryProvider.category == categories[index]
                        ? Theme.of(context).textTheme.subtitle2
                        : Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<String> readData() async {
    return await DefaultAssetBundle.of(context)
        .loadString("assets/data/data.json");
  }

  Widget itemInfo(Item _item) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          print(_item);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                      selectedItem: _item,
                    )),
          );
        },
        child: new Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: new Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/${_item.image}"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: new Text(
                        _item.name,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    new Text(
                      '\$${int.parse(_item.price).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headline2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(_item.description,
                    style: Theme.of(context).textTheme.headline2,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
      ),
    );
  }

  getAllData(Map<String, dynamic> allData) {
    var aux = [];
    allData.forEach((key, value) {
      List<dynamic> exam = value;
      exam.forEach((element) {
        aux.add(element);
      });
    });
    return aux;
  }
}
