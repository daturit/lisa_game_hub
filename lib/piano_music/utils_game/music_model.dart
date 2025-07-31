
import 'music_color.dart';

class MusicModel {
  String title;
  String description;
  String price;
  int quantity;
  double score;
  List<String> images;
  bool isFavorite;
  List<MusicColor> colors;

  MusicModel({
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
    required this.score,
    required this.images,
    this.isFavorite = false,
    required this.colors,
  });
}
