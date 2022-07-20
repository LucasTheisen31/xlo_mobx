import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../models/category.dart';
import '../repositorios/category_repositorio.dart';
import 'connectivity_store.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  //acessando uma instancia de ConnectivityStore atravez do GetIt, que da acesso a objetos de qualquer lugar do app
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  //construtor chamando a funcao _loadCateries() na inicialização
  _CategoryStore() {
    /*autorun é uma reação que é executada sempre que um observable que esteja dentro dele seja lido ou modificado
    sempre que tiver uma alteração o autorun vai executar a função,
    Neste caso temos 1 observable dentro do autorun (connected que indica se esta conectado a rede ou nao e sempre que conected for true e a lista de categoria for vazia)
    o autorun sera executado e vai buscar uma nova lista de categoria
    */
    autorun((_) {
      if (connectivityStore.connected && categoryList.isEmpty) {
        _loadCategories();
      }
    });
  }

  @computed
  //copia a categoriList e insere na posicao 0 uma categoria com id = * e descricao = Todas
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: 'Todas'));

  //lista observavel do tipo Category
  ObservableList<Category> categoryList = ObservableList<Category>();

  //Action para adicionar itens na categoryList
  @action
  void setCategories(List<Category> categories) {
    //limpa a lista primeiro para nao dublicar itens
    categoryList.clear();
    categoryList.addAll(categories);
  }

  @observable
  String? error;

  @action
  void setError(String error) {
    this.error = error;
  }

  //funcao para carregar a lista de categorias cadastradas no parseServer
  Future<void> _loadCategories() async {
    //busca as categorias atravez do metodo CategoryRepositorio().getList()
    //como CategoryRepositorio().getList() pode gerar uma exceção temos que tratala
    try {
      final categories = await CategoryRepositorio().getList();
      setCategories(categories);
    } catch (e) {
      setError(e.toString());
    }
  }
}
