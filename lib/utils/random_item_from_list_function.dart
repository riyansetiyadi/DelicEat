import 'dart:math';

T getRandomItemFromList<T>(List<T> list) {
  if (list.isEmpty) {
    throw Exception("List is empty");
  }

  final random = Random();
  final randomIndex = random.nextInt(list.length);

  return list[randomIndex];
}
