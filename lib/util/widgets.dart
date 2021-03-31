import 'package:cart/viewmodel/base_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCartIcon extends StatelessWidget {
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
            Navigator.pushNamed(context, '/cart_view');
          },
        ),
        Positioned(
          right: 8,
          top: 7,
          child: Consumer<BaseModel>(
            builder: (context, baseModel, child) {
              return baseModel.itemsInCart == 0
                  ? Container()
                  : Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 20,
                      child: Text("${baseModel.itemsInCart}"),
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
