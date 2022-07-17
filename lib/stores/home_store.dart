import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositorios/anuncio_repository.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

import '../models/anuncio.dart';

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
      try {
        setLoading(true);
        final novosAnuncios = await AnuncioRepository().getHomeAnuncioList(
          search: search,
          category: category,
          filterStore: filterStore,
          page: page,
        );
        addNovosAnuncios(novosAnuncios); //adiciona os novos anuncios
        setError(null);
        setLoading(false);
      } catch (e) {
        setLoading(false);
        setError(e.toString());
      }
    });
  }

  //obervableList que vai armazenar os anuncios que serao exibitos da HomeScreen
  ObservableList<Anuncio> listaAnuncio = ObservableList<Anuncio>();

  //monitora qual é a busca atual
  @observable
  String search = '';

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  //monitora qual é a categoria atual
  @observable
  Category? category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  //monitora qual é o filtro atual
  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get cloneFilterStore => filterStore.clone();

  @action
  void setFilter(FilterStore value) {
    filterStore = value;
    resetPage();
  }

  @observable
  String? error;

  @action
  void setError(String? value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  //cada pagina exibe 20 anuncios
  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  //incrementa a pagina para carregar mais Anuncios
  @action
  void nextPage() {
    page++;
  }

  @action
  void addNovosAnuncios(List<Anuncio> novosAnuncios) {
    if (novosAnuncios.length < 10) {
      lastPage = true;
    }
    listaAnuncio.addAll(novosAnuncios);
  }

  @computed
  int get itemCount => lastPage ? listaAnuncio.length : listaAnuncio.length + 1;

  void resetPage() {
    //reseta o numero da pagina e limpa a lista dos anuncios
    page = 0;
    listaAnuncio.clear();
    lastPage = false;
  }

  //retorna se esta carregando e se a lista de anuncios esta vazia, desta forma vai exibir um CircularProgressIndicator
  @computed
  bool get showProgress => loading && listaAnuncio.isEmpty;
}
