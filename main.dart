// ===============================
// SINTAKS FACTORY CONSTRUCTOR
// ===============================

class BasicUser {
  String name;

  BasicUser._internal(this.name);

  factory BasicUser(String name) {
    return BasicUser._internal(name);
  }
}

void demoBasicFactory() {
  var user1 = BasicUser('Azhar');
  var user2 = BasicUser('Rizki');

  print(user1.name);
  print(user2.name);
}

// ===============================
// SINGLETON PATTERN
// ===============================

class Database {
  static final Database _instance = Database._internal();

  Database._internal();

  factory Database() {
    return _instance;
  }

  void connect() {
    print('Connected to database');
  }
}

void demoSingleton() {
  var db1 = Database();
  var db2 = Database();

  print(identical(db1, db2));

  db1.connect();
}

// ===============================
// FACTORY DENGAN CACHE
// ===============================

class CachedUser {
  final String username;

  CachedUser._internal(this.username);

  static final Map<String, CachedUser> _cache = {};

  factory CachedUser(String username) {
    if (_cache.containsKey(username)) {
      return _cache[username]!;
    }

    final user = CachedUser._internal(username);
    _cache[username] = user;

    return user;
  }
}

void demoFactoryCache() {
  var user1 = CachedUser('azhar');
  var user2 = CachedUser('azhar');
  var user3 = CachedUser('rizki');

  print(identical(user1, user2));
  print(identical(user1, user3));
}

// ===============================
// MENGEMBALIKAN SUBCLASS
// ===============================

abstract class DrawableShape {
  void draw();
}

class DrawableCircle implements DrawableShape {
  @override
  void draw() {
    print('Menggambar Lingkaran');
  }
}

class DrawableSquare implements DrawableShape {
  @override
  void draw() {
    print('Menggambar Persegi');
  }
}

class ShapeFactory {
  static DrawableShape create(String type) {
    if (type == 'circle') {
      return DrawableCircle();
    } else {
      return DrawableSquare();
    }
  }
}

void demoReturnSubclass() {
  DrawableShape shape1 = ShapeFactory.create('circle');
  DrawableShape shape2 = ShapeFactory.create('square');

  shape1.draw();
  shape2.draw();
}

// ===============================
// PRAKTIK 1
// FACTORY UNTUK CONFIGURATION
// ===============================

class Configuration {
  final String environment;
  final String apiUrl;

  Configuration._internal(this.environment, this.apiUrl);

  factory Configuration(String env) {
    if (env == 'development') {
      return Configuration._internal(
        'development',
        'https://dev-api.example.com',
      );
    } else if (env == 'production') {
      return Configuration._internal(
        'production',
        'https://api.example.com',
      );
    }

    throw Exception('Environment tidak dikenal');
  }

  void showConfig() {
    print('Environment: $environment');
    print('API URL: $apiUrl');
  }
}

void demoConfiguration() {
  var devConfig = Configuration('development');
  var prodConfig = Configuration('production');

  devConfig.showConfig();

  print('---');

  prodConfig.showConfig();
}

// ===============================
// FACTORY DENGAN NAMED CONSTRUCTORS
// ===============================

class UserRole {
  String name;
  String role;

  UserRole._internal(this.name, this.role);

  factory UserRole.admin(String name) {
    return UserRole._internal(name, 'Admin');
  }

  factory UserRole.guest(String name) {
    return UserRole._internal(name, 'Guest');
  }

  void showInfo() {
    print('Name: $name');
    print('Role: $role');
  }
}

void demoNamedFactory() {
  var admin = UserRole.admin('Azhar');
  var guest = UserRole.guest('Rizki');

  admin.showInfo();
  guest.showInfo();
}

// ===============================
// FACTORY DENGAN GENERIC
// ===============================

class Box<T> {
  T value;

  Box._internal(this.value);

  factory Box(T value) {
    return Box._internal(value);
  }

  void showValue() {
    print('Value: $value');
    print('Type : ${value.runtimeType}');
  }
}

void demoGenericFactory() {
  var intBox = Box<int>(100);
  var stringBox = Box<String>('Hello Dart');

  intBox.showValue();

  print('---');

  stringBox.showValue();
}

// ===============================
// PRAKTIK 2
// FACTORY UNTUK PAYMENT METHODS
// ===============================

abstract class PaymentMethod {
  void pay(double amount);

  factory PaymentMethod(String type) {
    if (type == 'creditcard') {
      return CreditCardPayment();
    } else if (type == 'ewallet') {
      return EWalletPayment();
    } else if (type == 'banktransfer') {
      return BankTransferPayment();
    }

    throw Exception('Metode pembayaran tidak tersedia');
  }
}

class CreditCardPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print('Pembayaran Rp$amount menggunakan Kartu Kredit');
  }
}

class EWalletPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print('Pembayaran Rp$amount menggunakan E-Wallet');
  }
}

class BankTransferPayment implements PaymentMethod {
  @override
  void pay(double amount) {
    print('Pembayaran Rp$amount menggunakan Transfer Bank');
  }
}

void demoPaymentMethod() {
  PaymentMethod payment1 = PaymentMethod('creditcard');
  PaymentMethod payment2 = PaymentMethod('ewallet');
  PaymentMethod payment3 = PaymentMethod('banktransfer');

  payment1.pay(50000);
  payment2.pay(75000);
  payment3.pay(100000);
}

// ===============================
// FACTORY VS STATIC METHOD
// ===============================

class StaticFactoryUser {
  String name;

  StaticFactoryUser._internal(this.name);

  factory StaticFactoryUser(String name) {
    return StaticFactoryUser._internal(name);
  }

  static StaticFactoryUser createGuest() {
    return StaticFactoryUser._internal('Guest');
  }

  void showInfo() {
    print('Name: $name');
  }
}

void demoFactoryVsStatic() {
  var user1 = StaticFactoryUser('Azhar');
  var user2 = StaticFactoryUser.createGuest();

  user1.showInfo();
  user2.showInfo();
}

// ===============================
// FACTORY UNTUK IMMUTABLE OBJECTS
// DENGAN CACHE
// ===============================

class ImmutableCachedUser {
  final String username;

  static final Map<String, ImmutableCachedUser> _cache = {};

  ImmutableCachedUser._internal(this.username);

  factory ImmutableCachedUser(String username) {
    if (_cache.containsKey(username)) {
      return _cache[username]!;
    }

    final user = ImmutableCachedUser._internal(username);
    _cache[username] = user;

    return user;
  }
}

void demoImmutableCache() {
  var user1 = ImmutableCachedUser('azhar');
  var user2 = ImmutableCachedUser('azhar');
  var user3 = ImmutableCachedUser('rizki');

  print(identical(user1, user2));
  print(identical(user1, user3));
}

// ===============================
// DOCUMENT FACTORY
// ===============================

abstract class Document {
  void open();

  factory Document(String type) {
    if (type == 'pdf') {
      return PdfDocument();
    } else if (type == 'word') {
      return WordDocument();
    } else if (type == 'excel') {
      return ExcelDocument();
    }

    throw Exception('Tipe dokumen tidak didukung');
  }
}

class PdfDocument implements Document {
  @override
  void open() {
    print('Membuka dokumen PDF');
  }
}

class WordDocument implements Document {
  @override
  void open() {
    print('Membuka dokumen Word');
  }
}

class ExcelDocument implements Document {
  @override
  void open() {
    print('Membuka dokumen Excel');
  }
}

void demoDocumentFactory() {
  Document pdf = Document('pdf');
  Document word = Document('word');
  Document excel = Document('excel');

  pdf.open();
  word.open();
  excel.open();
}

// ===============================
// CONNECTION POOL
// ===============================

class DatabaseConnection {
  final String host;
  final int port;

  DatabaseConnection._(this.host, this.port);

  static final Map<String, DatabaseConnection> _pool = {};

  factory DatabaseConnection(String host, int port) {
    String key = '$host:$port';

    if (_pool.containsKey(key)) {
      print('Menggunakan koneksi dari pool');
      return _pool[key]!;
    }

    print('Membuat koneksi baru');

    final connection = DatabaseConnection._(host, port);

    _pool[key] = connection;

    return connection;
  }

  void connect() {
    print('Terhubung ke $host:$port');
  }
}

void demoConnectionPool() {
  var conn1 = DatabaseConnection('localhost', 5432);
  var conn2 = DatabaseConnection('localhost', 5432);

  conn1.connect();

  print(identical(conn1, conn2));
}

// ===============================
// NOTIFICATION FACTORY
// ===============================

abstract class Notification {
  void send(String message);

  factory Notification(String platform) {
    if (platform.toLowerCase() == 'email') {
      return EmailNotification();
    } else if (platform.toLowerCase() == 'sms') {
      return SmsNotification();
    } else if (platform.toLowerCase() == 'push') {
      return PushNotification();
    }

    throw Exception('Platform tidak didukung');
  }
}

class EmailNotification implements Notification {
  @override
  void send(String message) {
    print('Email: $message');
  }
}

class SmsNotification implements Notification {
  @override
  void send(String message) {
    print('SMS: $message');
  }
}

class PushNotification implements Notification {
  @override
  void send(String message) {
    print('Push Notification: $message');
  }
}

void demoNotificationFactory() {
  Notification email = Notification('email');
  Notification sms = Notification('sms');
  Notification push = Notification('push');

  email.send('Selamat datang!');
  sms.send('Kode OTP Anda: 123456');
  push.send('Ada promo baru hari ini!');
}

// ===============================
// SHAPE FACTORY DENGAN CACHE
// ===============================

abstract class CachedShape {
  void draw();
}

class CachedCircle implements CachedShape {
  final double radius;

  CachedCircle(this.radius);

  @override
  void draw() {
    print('Lingkaran dengan radius $radius');
  }
}

class CachedSquare implements CachedShape {
  final double side;

  CachedSquare(this.side);

  @override
  void draw() {
    print('Persegi dengan sisi $side');
  }
}

class CachedShapeFactory {
  static final Map<String, CachedShape> _cache = {};

  static CachedShape getCircle(double radius) {
    String key = 'circle_$radius';

    if (!_cache.containsKey(key)) {
      print('Membuat Circle baru');
      _cache[key] = CachedCircle(radius);
    } else {
      print('Menggunakan Circle dari cache');
    }

    return _cache[key]!;
  }

  static CachedShape getSquare(double side) {
    String key = 'square_$side';

    if (!_cache.containsKey(key)) {
      print('Membuat Square baru');
      _cache[key] = CachedSquare(side);
    } else {
      print('Menggunakan Square dari cache');
    }

    return _cache[key]!;
  }
}

void demoShapeCache() {
  CachedShape circle1 = CachedShapeFactory.getCircle(10);
  CachedShape circle2 = CachedShapeFactory.getCircle(10);

  CachedShape square1 = CachedShapeFactory.getSquare(5);
  CachedShape square2 = CachedShapeFactory.getSquare(5);

  circle1.draw();
  square1.draw();

  print(identical(circle1, circle2));
  print(identical(square1, square2));
}

// ===============================
// CHALLENGE - ANIMAL FACTORY
// ===============================

abstract class Animal {
  String name;

  Animal(this.name);

  void makeSound();

  static final Map<String, Animal> _cache = {};

  factory Animal.create(String type, String name) {
    if (name.trim().isEmpty) {
      throw Exception('Nama hewan tidak boleh kosong');
    }

    String key = '${type.toLowerCase()}_$name';

    if (_cache.containsKey(key)) {
      print('Menggunakan hewan dari cache');
      return _cache[key]!;
    }

    Animal animal;

    switch (type.toLowerCase()) {
      case 'dog':
        animal = Dog(name);
        break;
      case 'cat':
        animal = Cat(name);
        break;
      case 'bird':
        animal = Bird(name);
        break;
      default:
        throw Exception('Jenis hewan tidak dikenal');
    }

    _cache[key] = animal;

    print('Membuat hewan baru');

    return animal;
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeSound() {
    print('$name : Woof!');
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() {
    print('$name : Meow!');
  }
}

class Bird extends Animal {
  Bird(String name) : super(name);

  @override
  void makeSound() {
    print('$name : Tweet!');
  }
}

void demoAnimalFactory() {
  Animal dog1 = Animal.create('dog', 'Buddy');
  Animal dog2 = Animal.create('dog', 'Buddy');

  Animal cat1 = Animal.create('cat', 'Milo');

  dog1.makeSound();
  cat1.makeSound();

  print(identical(dog1, dog2));
}

// ===============================
// MAIN
// ===============================

void main() {
  print('\n=== Sintaks Factory Constructor ===');
  demoBasicFactory();

  print('\n=== Singleton Pattern ===');
  demoSingleton();

  print('\n=== Factory Cache ===');
  demoFactoryCache();

  print('\n=== Mengembalikan Subclass ===');
  demoReturnSubclass();

  print('\n=== Praktik 1 - Configuration ===');
  demoConfiguration();

  print('\n=== Named Factory Constructor ===');
  demoNamedFactory();

  print('\n=== Factory Generic ===');
  demoGenericFactory();

  print('\n=== Praktik 2 - Payment Method ===');
  demoPaymentMethod();

  print('\n=== Factory vs Static Method ===');
  demoFactoryVsStatic();

  print('\n=== Immutable Objects dengan Cache ===');
  demoImmutableCache();

  print('\n=== Document Factory ===');
  demoDocumentFactory();

  print('\n=== Connection Pool ===');
  demoConnectionPool();

  print('\n=== Notification Factory ===');
  demoNotificationFactory();

  print('\n=== Shape Factory dengan Cache ===');
  demoShapeCache();

  print('\n=== Challenge - Animal Factory ===');
  demoAnimalFactory();
}
