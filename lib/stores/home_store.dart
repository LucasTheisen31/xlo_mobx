import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositorios/anuncio_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
flutter pub run build_runner watch --delete-conflicting-outputs
*/

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  //construtor com autoRun para monitorar todos os observable ao mesmo tempo
  _HomeStore() {
    /*autorun é uma reação que é executada sempre que um observable que esteja dentro dele seja lido ou modificado
    sempre que tiver uma alteração o autorun vai executar a função,
    Neste caso temos 3 observable dentro do autorun e sempre que 1 deles for modificado o autorun sera executado e vai buscar uma nova lista de anuncio baseada
    nos 3 observable
    */
    autorun((_) async {
      final novosAnuncios = await AnuncioRepository().getHomeAnuncioList(
        search: search,
        category: category,
        filterStore: filterStore,
      );
      print(novosAnuncios);
    });
  }

  //monitora qual é a busca atual
  @observable
  String search = '';

  @action
  void setSearch(String value) => this.search = value;

  //monitora qual é a categoria atual
  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;

  //monitora qual é o filtro atual
  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get cloneFilterStore => filterStore.clone();

  @action
  void setFilter(FilterStore value) => filterStore = value;
}
