# Resume Materi Sesi 10
## Factory Constructors dalam Pemrograman Berorientasi Objek

**Nama :** Azhar Rizki Ismail 
**NIM :** 23141005P
**Kelas :** SI6KR
**Mata Kuliah :** Pemrograman Berorientasi Objek  

---

# Pendahuluan


Dalam pemrograman berorientasi objek, constructor digunakan untuk membuat dan menginisialisasi objek dari sebuah class. Pada umumnya, setiap pemanggilan constructor akan menghasilkan instance baru. Namun, pada beberapa kondisi tertentu, programmer memerlukan cara yang lebih fleksibel, seperti mengembalikan objek yang sudah ada, memilih subclass tertentu, atau menerapkan mekanisme caching untuk menghemat penggunaan memori. Untuk memenuhi kebutuhan tersebut, Dart menyediakan fitur Factory Constructors.

Factory Constructors merupakan jenis constructor khusus yang tidak selalu membuat instance baru setiap kali dipanggil. Factory constructor dapat mengembalikan objek yang telah dibuat sebelumnya, memilih jenis objek yang akan dikembalikan berdasarkan kondisi tertentu, bahkan mengimplementasikan pola desain seperti Singleton dan Object Pool. Kemampuan ini membuat factory constructor menjadi salah satu fitur penting dalam pengembangan aplikasi yang membutuhkan efisiensi dan pengelolaan objek yang lebih baik.

Pada materi ini akan dibahas konsep Factory Constructors mulai dari pengertian, sintaks dasar, penggunaan named factory constructors, generic factory constructors, perbandingan factory dengan static method, hingga implementasi caching pada objek immutable. Selain itu, materi ini juga dilengkapi dengan berbagai praktik dan studi kasus yang bertujuan membantu memahami penerapan Factory Constructors dalam pengembangan aplikasi nyata.


---

# Factory Constructors

## Pengertian Factory Constructors

Factory Constructor adalah constructor khusus pada Dart yang digunakan untuk mengontrol proses pembuatan objek. Berbeda dengan constructor biasa yang selalu membuat instance baru setiap kali dipanggil, factory constructor dapat mengembalikan instance yang sudah ada, memilih objek tertentu berdasarkan kondisi, atau mengembalikan objek dari subclass yang berbeda. Kemampuan ini membuat factory constructor sangat berguna untuk mengimplementasikan pola desain seperti Singleton, Caching, dan Factory Pattern.

Penggunaan factory constructor membantu meningkatkan efisiensi penggunaan memori karena objek yang sama dapat digunakan kembali tanpa harus membuat instance baru secara berulang. Selain itu, factory constructor juga memberikan fleksibilitas yang lebih besar dalam menentukan objek apa yang akan dikembalikan kepada pengguna class, sehingga proses pembuatan objek menjadi lebih terkontrol dan sesuai dengan kebutuhan aplikasi.

## Sintaks Factory Constructors

Factory Constructor ditulis menggunakan keyword factory sebelum nama constructor. Berbeda dengan constructor biasa, factory constructor tidak menggunakan keyword new secara langsung untuk membuat objek, melainkan harus mengembalikan sebuah instance melalui perintah return. Dengan cara ini, programmer dapat menentukan apakah akan membuat objek baru, menggunakan objek yang sudah ada, atau mengembalikan objek lain sesuai kondisi tertentu. Sintaks factory constructor memberikan fleksibilitas yang lebih besar dalam proses pembuatan objek dibandingkan constructor biasa.

### Contoh :

```dart
class User {
  String name;

  User._internal(this.name);

  factory User(String name) {
    return User._internal(name);
  }
}

void main() {
  var user1 = User('Azhar');
  var user2 = User('Rizki');

  print(user1.name);
  print(user2.name);
}
```

<img width="1920" height="943" alt="1" src="https://github.com/user-attachments/assets/d1bebfb5-8d47-4e9a-ad35-15de0d27cfea" />


# Studi Kasus

## Studi Kasus I - Singleton Pattern

```dart
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

void main() {
  var db1 = Database();
  var db2 = Database();

  print(identical(db1, db2));

  db1.connect();
}
```

<img width="1920" height="946" alt="2" src="https://github.com/user-attachments/assets/092af698-e36c-47d0-a907-be458af00347" />


## Studi Kasus II - Object Pool / Caching

```dart
class User {
  final String username;

  User._internal(this.username);

  static final Map<String, User> _cache = {};

  factory User(String username) {
    if (_cache.containsKey(username)) {
      return _cache[username]!;
    }

    final user = User._internal(username);
    _cache[username] = user;

    return user;
  }
}

void main() {
  var user1 = User('azhar');
  var user2 = User('azhar');
  var user3 = User('rizki');

  print(identical(user1, user2));
  print(identical(user1, user3));
}
```

<img width="1919" height="944" alt="3" src="https://github.com/user-attachments/assets/801a4591-b575-4c3e-9af5-273b46d53653" />


## Studi Kasus III - Mengembalikan Subclass

```dart
abstract class Shape {
  void draw();
}

class Circle implements Shape {
  @override
  void draw() {
    print('Menggambar Lingkaran');
  }
}

class Square implements Shape {
  @override
  void draw() {
    print('Menggambar Persegi');
  }
}

class ShapeFactory {
  static Shape create(String type) {
    if (type == 'circle') {
      return Circle();
    } else {
      return Square();
    }
  }
}

void main() {
  Shape shape1 = ShapeFactory.create('circle');
  Shape shape2 = ShapeFactory.create('square');

  shape1.draw();
  shape2.draw();
}
```

<img width="1919" height="942" alt="4" src="https://github.com/user-attachments/assets/c2949b3a-2b17-4a1d-9e99-8f799a569a61" />


# Praktik

## Praktik I - Factory untuk Configuration

```dart
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

void main() {
  var devConfig = Configuration('development');
  var prodConfig = Configuration('production');

  devConfig.showConfig();
  print('---');
  prodConfig.showConfig();
}
```

<img width="1920" height="945" alt="5" src="https://github.com/user-attachments/assets/728f1132-161b-4fe3-a14f-90d9251e0d4a" />


---

## Factory dengan Named Constructors

Factory constructor dapat dikombinasikan dengan named constructor untuk menyediakan beberapa cara pembuatan objek sesuai kebutuhan. Dengan pendekatan ini, sebuah class dapat memiliki lebih dari satu factory constructor yang masing-masing bertugas membuat objek dengan konfigurasi atau kondisi yang berbeda. Teknik ini membuat kode lebih mudah dibaca, terstruktur, dan memudahkan pengguna class dalam memilih jenis objek yang ingin dibuat tanpa harus memahami detail implementasinya.

### Contoh :

```dart
class User {
  String name;
  String role;

  User._internal(this.name, this.role);

  factory User.admin(String name) {
    return User._internal(name, 'Admin');
  }

  factory User.guest(String name) {
    return User._internal(name, 'Guest');
  }

  void showInfo() {
    print('Name: $name');
    print('Role: $role');
  }
}

void main() {
  var admin = User.admin('Azhar');
  var guest = User.guest('Rizki');

  admin.showInfo();
  guest.showInfo();
}
```

<img width="1920" height="944" alt="6" src="https://github.com/user-attachments/assets/abc70db9-261c-4784-8a96-be76c2d9302c" />


## Factory dengan Generic

Factory constructor juga dapat digunakan pada class generic sehingga objek yang dibuat dapat menyesuaikan tipe data yang digunakan. Dengan generic, satu class dapat digunakan untuk berbagai tipe data tanpa perlu membuat class yang berbeda untuk setiap tipe. Penggabungan generic dan factory constructor membuat kode menjadi lebih fleksibel, reusable, dan tetap menjaga type safety karena tipe data ditentukan saat objek dibuat.

### Contoh :

```dart
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

void main() {
  var intBox = Box<int>(100);
  var stringBox = Box<String>('Hello Dart');

  intBox.showValue();
  print('---');
  stringBox.showValue();
}
```

<img width="1920" height="943" alt="7" src="https://github.com/user-attachments/assets/0dbd546e-ed9a-4c73-a378-06896a1814dd" />


## Praktik 2 – Factory untuk Payment Methods

```dart
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

void main() {
  PaymentMethod payment1 = PaymentMethod('creditcard');
  PaymentMethod payment2 = PaymentMethod('ewallet');
  PaymentMethod payment3 = PaymentMethod('banktransfer');

  payment1.pay(50000);
  payment2.pay(75000);
  payment3.pay(100000);
}
```

<img width="1920" height="942" alt="8" src="https://github.com/user-attachments/assets/019dd7ba-868d-420e-a8e5-f8a540bbefe9" />


## Factory vs Static Method

Factory constructor dan static method sama-sama dapat digunakan untuk membuat objek, namun keduanya memiliki tujuan yang berbeda. Factory constructor merupakan bagian dari mekanisme constructor sehingga dapat dipanggil seperti pembuatan objek biasa dan memiliki kemampuan untuk mengembalikan instance yang sudah ada, melakukan caching, atau mengembalikan subclass tertentu. Sementara itu, static method hanyalah method biasa yang dimiliki class dan digunakan untuk membuat atau mengelola objek tanpa menjadi bagian dari constructor. Factory constructor lebih cocok digunakan ketika proses pembuatan objek memerlukan logika khusus, sedangkan static method lebih sesuai untuk utility atau helper method yang berkaitan dengan class tersebut.

### Contoh :

```dart
class User {
  String name;

  User._internal(this.name);

  factory User(String name) {
    return User._internal(name);
  }

  static User createGuest() {
    return User._internal('Guest');
  }

  void showInfo() {
    print('Name: $name');
  }
}

void main() {
  var user1 = User('Azhar');

  var user2 = User.createGuest();

  user1.showInfo();

  user2.showInfo();
}
```

<img width="1920" height="942" alt="9" src="https://github.com/user-attachments/assets/5876a1d4-c1e5-40de-83d9-281383838c7c" />


## Factory untuk Immutable Objects dengan Cache

Factory constructor sering digunakan untuk menerapkan caching pada immutable object, yaitu objek yang nilainya tidak dapat diubah setelah dibuat. Dengan teknik ini, ketika objek dengan data yang sama diminta kembali, factory constructor akan mengembalikan instance yang sudah ada di cache daripada membuat objek baru. Pendekatan ini dapat menghemat penggunaan memori, meningkatkan performa aplikasi, dan memastikan tidak terjadi pembuatan objek yang sama secara berulang.

### Contoh :

```dart
class User {
  final String username;

  static final Map<String, User> _cache = {};

  User._internal(this.username);

  factory User(String username) {
    if (_cache.containsKey(username)) {
      return _cache[username]!;
    }

    final user = User._internal(username);
    _cache[username] = user;

    return user;
  }
}

void main() {
  var user1 = User('azhar');
  var user2 = User('azhar');
  var user3 = User('rizki');

  print(identical(user1, user2));

  print(identical(user1, user3));
}
```

<img width="1920" height="942" alt="10" src="https://github.com/user-attachments/assets/201d590d-fc90-45b9-aa54-e5dc942af5ac" />


# Studi Kasus

## Studi Kasus I - Document Factory

```dart
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

void main() {
  Document pdf = Document('pdf');
  Document word = Document('word');
  Document excel = Document('excel');

  pdf.open();
  word.open();
  excel.open();
}
```

<img width="1919" height="941" alt="11" src="https://github.com/user-attachments/assets/e7d0cbf2-3b48-4ac1-9c5d-bc9bbe68fc45" />


# Kesimpulan

Factory Constructor merupakan constructor khusus pada Dart yang memberikan fleksibilitas lebih dalam proses pembuatan objek. Berbeda dengan constructor biasa yang selalu membuat instance baru, factory constructor dapat mengembalikan objek yang sudah ada, mengelola proses caching, maupun menentukan jenis objek yang akan dikembalikan berdasarkan kondisi tertentu. Kemampuan ini membuat factory constructor menjadi salah satu fitur penting dalam pengembangan aplikasi berorientasi objek.

Melalui materi ini telah dipelajari berbagai konsep terkait Factory Constructors, mulai dari sintaks dasar, penggunaan named factory constructor, generic factory constructor, hingga perbandingan antara factory constructor dan static method. Selain itu, factory constructor juga dapat dimanfaatkan untuk mengimplementasikan immutable objects dengan cache sehingga penggunaan memori menjadi lebih efisien. Berbagai contoh kode yang diberikan menunjukkan bagaimana factory constructor dapat menyederhanakan proses pembuatan objek sekaligus meningkatkan fleksibilitas desain program.

Penerapan Factory Constructors sangat banyak ditemukan dalam pengembangan perangkat lunak modern, seperti pada implementasi Singleton Pattern, Object Pool, Caching, pemilihan subclass secara otomatis, dan pembuatan dokumen berdasarkan tipe tertentu. Dengan memahami konsep dan penggunaan factory constructor secara tepat, programmer dapat menghasilkan kode yang lebih efisien, mudah dipelihara, serta sesuai dengan prinsip-prinsip pemrograman berorientasi objek.

---


# Latihan

## Latihan 1

```dart
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

void main() {
  var conn1 = DatabaseConnection('localhost', 5432);
  var conn2 = DatabaseConnection('localhost', 5432);

  conn1.connect();

  print(identical(conn1, conn2));
}
```

<img width="1920" height="945" alt="12" src="https://github.com/user-attachments/assets/b8fa9490-24d1-45fd-93c6-1ef5a4889493" />


## Latihan 2

```dart
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

void main() {
  Notification email = Notification('email');
  Notification sms = Notification('sms');
  Notification push = Notification('push');

  email.send('Selamat datang!');
  sms.send('Kode OTP Anda: 123456');
  push.send('Ada promo baru hari ini!');
}
```

<img width="1920" height="943" alt="13" src="https://github.com/user-attachments/assets/77a74017-4be6-4059-ac89-7b73d6952a89" />


## Latihan 3

```dart
abstract class Shape {
  void draw();
}

class Circle implements Shape {
  final double radius;

  Circle(this.radius);

  @override
  void draw() {
    print('Lingkaran dengan radius $radius');
  }
}

class Square implements Shape {
  final double side;

  Square(this.side);

  @override
  void draw() {
    print('Persegi dengan sisi $side');
  }
}

class ShapeFactory {
  static final Map<String, Shape> _cache = {};

  static Shape getCircle(double radius) {
    String key = 'circle_$radius';

    if (!_cache.containsKey(key)) {
      print('Membuat Circle baru');
      _cache[key] = Circle(radius);
    } else {
      print('Menggunakan Circle dari cache');
    }

    return _cache[key]!;
  }

  static Shape getSquare(double side) {
    String key = 'square_$side';

    if (!_cache.containsKey(key)) {
      print('Membuat Square baru');
      _cache[key] = Square(side);
    } else {
      print('Menggunakan Square dari cache');
    }

    return _cache[key]!;
  }
}

void main() {
  Shape circle1 = ShapeFactory.getCircle(10);
  Shape circle2 = ShapeFactory.getCircle(10);

  Shape square1 = ShapeFactory.getSquare(5);
  Shape square2 = ShapeFactory.getSquare(5);

  circle1.draw();
  square1.draw();

  print(identical(circle1, circle2));
  print(identical(square1, square2));
}
```

<img width="1919" height="946" alt="14" src="https://github.com/user-attachments/assets/708e7d6d-5bf0-4cbf-a6f4-75f8a622f17b" />


---

# Challenge - AnimalFactory

```dart
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

void main() {
  Animal dog1 = Animal.create('dog', 'Buddy');
  Animal dog2 = Animal.create('dog', 'Buddy');

  Animal cat1 = Animal.create('cat', 'Milo');

  dog1.makeSound();
  cat1.makeSound();

  print(identical(dog1, dog2));
}
```

<img width="1919" height="942" alt="15" src="https://github.com/user-attachments/assets/aac4a391-526d-449d-9748-49cf0f452387" />


---
