import 'package:flutter/material.dart';

class MeusAnunciosScreen extends StatefulWidget {
  const MeusAnunciosScreen({Key? key}) : super(key: key);

  @override
  State<MeusAnunciosScreen> createState() => _MeusAnunciosScreenState();
}

class _MeusAnunciosScreenState extends State<MeusAnunciosScreen>
    with SingleTickerProviderStateMixin {
  //SingleTickerProviderStateMixin para poder usar o vsync na TabController
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anúncios'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: [
            Tab(
              child: Text('ATIVOS'),
            ),
            Tab(
              child: Text('PENDENTES'),
            ),
            Tab(
              child: Text('VENDIDOS'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blueGrey,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
