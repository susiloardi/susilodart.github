import 'dart:io';

class Snack {
  String name;
  double price;
  int quantity;

  Snack(this.name, this.price, this.quantity);

  String toString() {
    return 'Nama: $name, Harga: Rp $price, Jumlah: $quantity';
  }
}

class Queue {
  List<Snack?> queue;
  int front;
  int rear;
  int maxQueue;

  Queue(this.maxQueue)
      : queue = List<Snack?>.filled(maxQueue, null),
        front = -1,
        rear = -1;

  bool isFull() {
    return (rear + 1) % maxQueue == front;
  }

  bool isEmpty() {
    return front == -1;
  }

  //Untuk menambahkan menggunakan Queue 
  void enqueue(Snack snack) {
    if (isFull()) {
      print('Penuh tidak bisa menambah snack.');
      return;
    }

    if (isEmpty()) {
      front = 0;
    }

    rear = (rear + 1) % maxQueue;
    queue[rear] = snack;
    print('${snack.name} berhasil ditambahkan.');
  }

  //Untuk Hapus menggunakan dequeue
  void dequeue() {
    if (isEmpty()) {
      print('Tidak ada snack yang bisa dihapus.');
      return;
    }

    var removedSnack = queue[front];
    if (front == rear) {
      front = rear = -1;
    } else {
      front = (front + 1) % maxQueue;
    }

    print('${removedSnack?.name} berhasil dihapus.');
  }

  //Untuk menampilkan semua snack
  void display() {
    if (isEmpty()) {
      print('Tidak ada snack di toko.');
      return;
    }

    int i = front;
    while (true) {
      print(queue[i]);
      if (i == rear) break;
      i = (i + 1) % maxQueue;
    }
  }

  //Untuk Mencari snack menggunakan LinierSearch
  Snack? searchSnack(String name) {
    if (isEmpty()) {
      return null;
    }

    int i = front;
    while (true) {
      if (queue[i]?.name == name) {
        return queue[i];
      }
      if (i == rear) break;
      i = (i + 1) % maxQueue;
    }

    return null;
  }
}


class SnackStore {
  Queue queue;

  SnackStore(int maxQueue) : queue = Queue(maxQueue);

  void addSnack(String name, double price, int quantity) {
    queue.enqueue(Snack(name, price, quantity));
  }

  void removeSnack() {
    queue.dequeue();
  }

  void displaySnacks() {
    queue.display();
  }

  void searchSnack(String name) {
    var snack = queue.searchSnack(name);
    if (snack != null) {
      print('Snack ditemukan: $snack');
    } else {
      print('Snack dengan nama $name tidak ditemukan.');
    }
  }
}

void main() {
  var store = SnackStore(10);
  while (true) {
    print('==============================');
    print('Sistem Manajemen Toko Snack');
    print('1. Tambah Snack');
    print('2. Hapus Snack');
    print('3. Lihat Semua Snack');
    print('4. Cari Snack');
    print('5. Keluar');
    print('==============================');
    stdout.write('Pilih opsi: ');
    var choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write('Masukkan nama snack: ');
      var name = stdin.readLineSync();
      stdout.write('Masukkan harga snack: ');
      var price = double.parse(stdin.readLineSync()!);
      stdout.write('Masukkan jumlah snack: ');
      var quantity = int.parse(stdin.readLineSync()!);
      store.addSnack(name!, price, quantity);
    } else if (choice == '2') {
      store.removeSnack();
    } else if (choice == '3') {
      store.displaySnacks();
    } else if (choice == '4') {
      stdout.write('Masukkan nama snack yang ingin dicari: ');
      var name = stdin.readLineSync();
      store.searchSnack(name!);
    } else if (choice == '5') {
      print('Keluar dari sistem...');
      break;
    } else {
      print('Pilihan tidak valid. Silakan coba lagi.');
    }
  }
}
