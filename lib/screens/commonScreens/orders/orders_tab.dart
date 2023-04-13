import 'package:flutter/material.dart';
import 'package:hireachef/screens/commonScreens/orders/active_orders.dart';
import 'package:hireachef/screens/commonScreens/orders/completed_orders.dart';
import 'package:hireachef/screens/commonScreens/orders/pending_orders.dart';
import 'package:hireachef/widgets/navigation/catering_navigation.dart';

import '../../../Constants.dart';
import '../../../widgets/navigation/chef_navigation.dart';

class OrdersTab extends StatefulWidget {
  OrdersTab({Key? key}) : super(key: key);

  var id;
  OrdersTab.set({this.id});
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  int cupertinoTabBarValue = 0;

  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  bottomNavigation(){
    if(widget.id==2){
      return chefNavigation(context, 2);
    }
    else if (widget.id==3){
      return cateringNavigation(context, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Constant.orange),
          backgroundColor: Constant.orange,
          title: const Image(
            image: AssetImage('assets/text-logo.png'),
            width: 170,
          ),
          elevation: 1,
          bottom: TabBar(
            indicatorColor: Constant.white,
            tabs: const [
              Tab(
                icon: Text(
                  'Pending',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Text(
                  'Active',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                icon: Text(
                  'Completed',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PendingOrders(),
            ActiveOrders(),
            CompletedOrders(),
          ],
        ),
        bottomNavigationBar: bottomNavigation(),
      ),
    );
  }
}
