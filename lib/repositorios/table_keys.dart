/*Padronização das chaves (nome das colunas das tabelas para evitar de digitar errado) do banco de dados*/
//Campos tabela do Ususario
const keyUserId = 'objectID'; //nome da tabela
const keyUserName = 'name';
const keyUserEmail = 'email';
const keyUserPhone = 'phone';
const keyUserPassword = 'password';
const keyUserType = 'type';
const keyUserCreatedAt = 'createdAt';

//Campos da tabela de Categoria
const keyCategoryTable = 'Categorias'; //nome da tabela
const keyCategoryId = 'objectId';
const keyCategoryDescription = 'descricao';

//Compos Tabela do Annuncio
const String keyAnuncioTable = 'Anuncios'; //nome da tabela
const String keyAnuncioId = 'objectId';
const String keyAnuncioTitle = 'title';
const String keyAnuncioDescription = 'description';
const String keyAnuncioHidePhone = 'hidePhone';
const String keyAnuncioPrice = 'price';
const String keyAnuncioStatus = 'status';
const String keyAnuncioDistrict = 'district';
const String keyAnuncioCity = 'city';
const String keyAnuncioPostalCode = 'postalCode';
const String keyAnuncioFederativeUnit = 'federativeUnit';
const String keyAnuncioImages = 'images';
const String keyAnuncioCategory = 'category';
const String keyAnuncioOwner = 'owner';
const String keyAnuncioCreatedAt = 'createdAt';
const String keyAnuncioViews = 'views';

//Campos da Tabela de Favoritos
const String keyFavoritoTable = 'Favoritos'; //nome da tabela
const String keyFavoritoId = 'objectId';
const String keyFavoritoAnuncio = 'anuncio';
const String keyFavoritoOwner = 'owner';
