import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/meus_anuncios_store.dart';

import 'components/active_tile.dart';
import 'components/empty_card.dart';
import 'components/pending_tile.dart';
import 'components/sold_tile.dart';

class MeusAnunciosScreen extends StatefulWidget {
  const MeusAnunciosScreen({Key? key, this.initialPage = 0}) : super(key: key);

  final int initialPage;

  @override
  State<MeusAnunciosScreen> createState() => _MeusAnunciosScreenState();
}

class _MeusAnunciosScreenState extends State<MeusAnunciosScreen>
    with SingleTickerProviderStateMixin {
  //SingleTickerProviderStateMixin para poder usar o vsync na TabController
  TabController? tabController;

  //para dar acesso ao MeusAnunciosStore
  final MeusAnunciosStore meusAnunciosStore = MeusAnunciosStore();

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
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
          tabs: const [
            Tab(child: Text('ATIVOS')),
            Tab(child: Text('PENDENTES')),
            Tab(child: Text('VENDIDOS')),
          ],
        ),
      ),
      body: Observer(
        builder: (context) {
          if (meusAnunciosStore.loading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else {
            return TabBarView(
              controller: tabController,
              children: [
                Observer(
                  builder: (_) {
                    /* if (meusAnunciosStore.listAnunciosAtivos.isEmpty)
                return EmptyCard('Você não possui nenhum anúncio ativo.');*/

                    return ListView.builder(
                      itemCount: meusAnunciosStore.listAnunciosAtivos.length,
                      itemBuilder: (_, index) {
                        return ActiveTile(
                            anuncio:
                                meusAnunciosStore.listAnunciosAtivos[index],
                            meusAnunciosStore: meusAnunciosStore);
                      },
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    /*if (meusAnunciosStore.listAnunciosPendentes.isEmpty)
                return EmptyCard('Você não possui nenhum anúncio pendente.');*/

                    return ListView.builder(
                      itemCount: meusAnunciosStore.listAnunciosPendentes.length,
                      itemBuilder: (_, index) {
                        return PendingTile(
                          anuncio:
                              meusAnunciosStore.listAnunciosPendentes[index],
                        );
                      },
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    /*if (meusAnunciosStore.listAnunciosVendidos.isEmpty)
                return EmptyCard('Você não possui nenhum anúncio vendido.');*/

                    return ListView.builder(
                      itemCount: meusAnunciosStore.listAnunciosVendidos.length,
                      itemBuilder: (_, index) {
                        return SoldTile(
                          anuncio:
                              meusAnunciosStore.listAnunciosVendidos[index],
                        );
                      },
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
