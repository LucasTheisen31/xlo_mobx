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
  //para dar acesso ao UserManageStore atravez do getIt ou seja é uma unica instancia pra o aplicativo
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  //metodo para salvar um favorito
  Future<void> toggleFavorite(Anuncio anuncio) async {
    try {
      await FavoriteRepository()
          .save(anuncio: anuncio, user: userManagerStore.user!);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
