import 'package:emmorceapp/design/user/cartListPage.dart';
import 'package:emmorceapp/design/user/categoryGrid.dart';
import 'package:emmorceapp/design/user/userProfile.dart';
import 'package:emmorceapp/design/user/whishListPage.dart';
import 'package:emmorceapp/services/cartService.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
   BottomBar({Key? key});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,color: Colors.red,),
          label: 'Whishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
               Icon(Icons.shopping_cart,),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 5,
                  child: Text("2", style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
          label: 'Cart',
        ),

      ],

      onTap: (int index) {
        if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CategoryGrid()));
        } else if(index==2){
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => WhishListPage()));
        }
        else if (index == 3) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfileScreen()));
        }else if (index == 4) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CartListPage()));
        }
      },
    );
  }
}
