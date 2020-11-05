import 'package:flutter/material.dart';
import '../models/my_model.dart';
import 'package:provider/provider.dart';
import 'package:cart/screens/cart.dart';

class CustomCartIcon extends StatefulWidget {
  @override
  _CustomCartIconState createState() => _CustomCartIconState();
}

class _CustomCartIconState extends State<CustomCartIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.only(top: 3.5),
            height: 50,
            width: 50,
            child: Icon(Icons.shopping_cart),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Cart()));
          },
        ),
        Positioned(
          right: 8,
          top: 7,
          child: Consumer<MyModel>(
            builder: (context, myModel, child) {
              return myModel.itemsInCart == 0
                  ? Container()
                  : Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: Text("${myModel.itemsInCart}"),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
