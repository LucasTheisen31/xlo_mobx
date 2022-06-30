import 'package:mobx/mobx.dart';
import '../models/category.dart';
import '../repositorios/category_repositorio.dart';

/*Comando queprecisa executar no terminal:
flutter packages pub run build_runner watch
*/

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  //construtor chamando a funcao _loadCateries() na inicialização
  _CategoryStore() {
    _loadCateries();
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
  Future<void> _loadCateries() async {
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
