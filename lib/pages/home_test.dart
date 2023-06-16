import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<String> tabs = ['全部', '森林', '地獄生物', '吉娃娃'];
  @override
  Widget build(BuildContext context) {
    const title = '動物白噪音';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              // backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                ),
              ],
              bottom: TabBar(
                tabs: tabs
                    .map((tab) => Tab(
                          child: Text(
                            tab,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background/home-bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: TabBarView(
                children: tabs.map((tab) {
                  return GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(8, (index) {
                      return Center(
                        child: Text(
                          'Item $index',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      );
                    }),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// child: GridView.count(
//               crossAxisCount: 2,
//               children: List.generate(8, (index) {
//                 return Center(
//                   child: Text(
//                     'Item $index',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                 );
//               }),
