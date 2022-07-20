import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/anuncio.dart';
import 'package:xlo_mobx/repositorios/favorite_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  //construtor
  _FavoriteStore() {
    //reaction para garantir que o usuario sera carregado primeiro antes de buscar os favoritos dele
    reaction((_) => userManagerStore.isLoggedIn, (_) {
      //chama o metodo para carregar os favoritos do usuario
      _getFavoriteList();
    });
  }

  //para dar acesso ao UserManageStore atravez do getIt ou seja é uma unica instancia pra o aplicativo
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  //lista para armazenar todos os anuncios favoritados pelo usuario
  ObservableList<Anuncio> favoriteList = ObservableList<Anuncio>();

  //metodo para carregar os favoritos do usuario na inicialização
  @action
  Future<void> _getFavoriteList() async {
    try {
      //limpa a favoriteList antes de adicionar novos favoritos, para nao duplicar
      favoriteList.clear();
      //chama o metodo que vai buscar os favoritos do usuario no banco
      final favorites =
          await FavoriteRepository().getFavorites(userManagerStore.user!);
      //passa a lista de favoritos para a ObservableList
      favoriteList.addAll(favorites);
    } catch (e) {
      print(e.toString());
    }
  }

  //metodo para salvar um favorito
  @action
  Future<void> toggleFavorite(Anuncio anuncio) async {
    try {
      //verifica se o anuncio ja esta na favoriteList
      if (favoriteList.any((element) => element.id == anuncio.id)) {
        //remove o favorito da lista e deleta no banco
        favoriteList.removeWhere((element) => element.id == anuncio.id);
        await FavoriteRepository()
            .delete(anuncio: anuncio, user: userManagerStore.user!);
      } else {
        //add o anuncio na favotiteList e salva no banco
        favoriteList.add(anuncio);
        await FavoriteRepository()
            .save(anuncio: anuncio, user: userManagerStore.user!);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
