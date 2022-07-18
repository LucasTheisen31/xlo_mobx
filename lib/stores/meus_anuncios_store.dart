import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../repositorios/anuncio_repository.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'meus_anuncios_store.g.dart';

class MeusAnunciosStore = _MeusAnunciosStore with _$MeusAnunciosStore;

abstract class _MeusAnunciosStore with Store {
  //construtor
  _MeusAnunciosStore() {
    getMeusAnuncios();
  }

  @observable
  List<Anuncio> lisTodosAnuncios = [];

  @observable
  bool loading = false;

  //retorna uma lista como os anuncios do usuario
  Future<void> getMeusAnuncios() async {
    final user = GetIt.I<UserManagerStore>().user;

    try {
      loading = true;
      //chama o metodo que vai buscar os anuncios do usuario
      lisTodosAnuncios = await AnuncioRepository().getMeusAnuncios(user!);
      loading = false;
    } catch (e) {}
  }

  //retorna somente os Anuncios Ativos
  @computed
  List<Anuncio> get listAnunciosAtivos => lisTodosAnuncios
      .where((anuncio) => anuncio.status == AnuncioStatus.ACTIVE)
      .toList();
  //retorna somente os Anuncios Pendentes
  List<Anuncio> get listAnunciosPendentes => lisTodosAnuncios
      .where((anuncio) => anuncio.status == AnuncioStatus.PENNDING)
      .toList();
  //retorna somente os Anuncios Vendidos
  List<Anuncio> get listAnunciosVendidos => lisTodosAnuncios
      .where((anuncio) => anuncio.status == AnuncioStatus.SOLD)
      .toList();

  //metodo para recarregar
  void refresh() => getMeusAnuncios();
}
