// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DataBaseBuilder databaseBuilder(String name) =>
      _$DataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DataBaseBuilder inMemoryDatabaseBuilder() => _$DataBaseBuilder(null);
}

class _$DataBaseBuilder {
  _$DataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DataBase extends DataBase {
  _$DataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DatabaseDao? _databaseDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AddressModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `addressLine` TEXT, `postalCode` INTEGER, `country` TEXT, `city` TEXT, `district` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CardInfoModel` (`cardHolderName` TEXT, `cardNumber` INTEGER, `cvv` INTEGER, `expirationDate` INTEGER, PRIMARY KEY (`cardNumber`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `RatingAndReviewModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `itemTitle` TEXT NOT NULL, `date` TEXT NOT NULL, `review` TEXT NOT NULL, `rating` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderInfo` (`orderNumber` INTEGER PRIMARY KEY AUTOINCREMENT, `timeCreated` TEXT NOT NULL, `totalAmount` REAL NOT NULL, `quantity` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderNotification` (`orderNumber` INTEGER NOT NULL, `date` TEXT NOT NULL, `imagePath` TEXT NOT NULL, `title` TEXT NOT NULL, PRIMARY KEY (`orderNumber`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DatabaseDao get databaseDao {
    return _databaseDaoInstance ??= _$DatabaseDao(database, changeListener);
  }
}

class _$DatabaseDao extends DatabaseDao {
  _$DatabaseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _addressModelInsertionAdapter = InsertionAdapter(
            database,
            'AddressModel',
            (AddressModel item) => <String, Object?>{
                  'id': item.id,
                  'addressLine': item.addressLine,
                  'postalCode': item.postalCode,
                  'country': item.country,
                  'city': item.city,
                  'district': item.district
                }),
        _cardInfoModelInsertionAdapter = InsertionAdapter(
            database,
            'CardInfoModel',
            (CardInfoModel item) => <String, Object?>{
                  'cardHolderName': item.cardHolderName,
                  'cardNumber': item.cardNumber,
                  'cvv': item.cvv,
                  'expirationDate': item.expirationDate
                }),
        _ratingAndReviewModelInsertionAdapter = InsertionAdapter(
            database,
            'RatingAndReviewModel',
            (RatingAndReviewModel item) => <String, Object?>{
                  'id': item.id,
                  'itemTitle': item.itemTitle,
                  'date': item.date,
                  'review': item.review,
                  'rating': item.rating
                }),
        _orderNotificationInsertionAdapter = InsertionAdapter(
            database,
            'OrderNotification',
            (OrderNotification item) => <String, Object?>{
                  'orderNumber': item.orderNumber,
                  'date': item.date,
                  'imagePath': item.imagePath,
                  'title': item.title
                }),
        _orderInfoInsertionAdapter = InsertionAdapter(
            database,
            'OrderInfo',
            (OrderInfo item) => <String, Object?>{
                  'orderNumber': item.orderNumber,
                  'timeCreated': item.timeCreated,
                  'totalAmount': item.totalAmount,
                  'quantity': item.quantity
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AddressModel> _addressModelInsertionAdapter;

  final InsertionAdapter<CardInfoModel> _cardInfoModelInsertionAdapter;

  final InsertionAdapter<RatingAndReviewModel>
      _ratingAndReviewModelInsertionAdapter;

  final InsertionAdapter<OrderNotification> _orderNotificationInsertionAdapter;

  final InsertionAdapter<OrderInfo> _orderInfoInsertionAdapter;

  @override
  Stream<List<OrderInfo>> getAllMyOrders() {
    return _queryAdapter.queryListStream('SELECT * FROM OrderInfo',
        mapper: (Map<String, Object?> row) => OrderInfo(
            orderNumber: row['orderNumber'] as int?,
            quantity: row['quantity'] as int,
            totalAmount: row['totalAmount'] as double),
        queryableName: 'OrderInfo',
        isView: false);
  }

  @override
  Future<List<OrderNotification>> getAllNotification() async {
    return _queryAdapter.queryList('SELECT * FROM OrderNotification',
        mapper: (Map<String, Object?> row) => OrderNotification(
            orderNumber: row['orderNumber'] as int,
            date: row['date'] as String,
            imagePath: row['imagePath'] as String,
            title: row['title'] as String));
  }

  @override
  Future<List<AddressModel>> getAllMyAddress() async {
    return _queryAdapter.queryList('SELECT * FROM AddressModel',
        mapper: (Map<String, Object?> row) => AddressModel(
            addressLine: row['addressLine'] as String?,
            postalCode: row['postalCode'] as int?,
            country: row['country'] as String?,
            city: row['city'] as String?,
            district: row['district'] as String?));
  }

  @override
  Future<List<CardInfoModel>> getAllMyCards() async {
    return _queryAdapter.queryList('SELECT * FROM CardInfoModel',
        mapper: (Map<String, Object?> row) => CardInfoModel(
            cardHolderName: row['cardHolderName'] as String?,
            cardNumber: row['cardNumber'] as int?,
            cvv: row['cvv'] as int?,
            expirationDate: row['expirationDate'] as int?));
  }

  @override
  Future<List<RatingAndReviewModel>> getAllMyReview() async {
    return _queryAdapter.queryList('SELECT * FROM RatingAndReviewModel',
        mapper: (Map<String, Object?> row) => RatingAndReviewModel(
            itemTitle: row['itemTitle'] as String,
            review: row['review'] as String,
            rating: row['rating'] as double));
  }

  @override
  Future<List<RatingAndReviewModel>> getAllItemReview(String itemTitle) async {
    return _queryAdapter.queryList(
        'SELECT * FROM RatingAndReviewModel WHERE itemTitle = ?1',
        mapper: (Map<String, Object?> row) => RatingAndReviewModel(
            itemTitle: row['itemTitle'] as String,
            review: row['review'] as String,
            rating: row['rating'] as double),
        arguments: [itemTitle]);
  }

  @override
  Future<void> insertAddress(AddressModel address) async {
    await _addressModelInsertionAdapter.insert(
        address, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCardInfo(CardInfoModel cardInfo) async {
    await _cardInfoModelInsertionAdapter.insert(
        cardInfo, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertRatingAndReview(
      RatingAndReviewModel ratingAndReview) async {
    await _ratingAndReviewModelInsertionAdapter.insert(
        ratingAndReview, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertOrderNotification(
      OrderNotification orderNotification) async {
    await _orderNotificationInsertionAdapter.insert(
        orderNotification, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertOrder(OrderInfo order) {
    return _orderInfoInsertionAdapter.insertAndReturnId(
        order, OnConflictStrategy.abort);
  }
}
