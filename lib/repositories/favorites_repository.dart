import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvvm_practice/models/book_model.dart';

class FavoritesRepository {
  static const String _favKey = 'favorite_slugs';

  Future<List<String>> getSlugs() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getStringList(_favKey) ?? [];
  }

  Future<void> toggle(Result book) async {
    final pref = await SharedPreferences.getInstance();
    final slugs = pref.getStringList(_favKey) ?? [];

    if (slugs.contains(book.slug)) {
      slugs.remove(book.slug);
    } else {
      slugs.add(book.slug!);
    }

    await pref.setStringList(_favKey, slugs);
  }

  bool isFavorite(Result book, List<String> slugs) {
    return slugs.contains(book.slug);
  }
}
