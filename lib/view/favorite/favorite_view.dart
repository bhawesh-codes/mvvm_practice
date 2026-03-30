import 'package:flutter/material.dart';
import 'package:mvvm_practice/utils/const/my_appbar.dart';
import 'package:mvvm_practice/view/favorite/favorite_viewmodel.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FavoriteViewmodel>();
    final books = vm.favoritebooks;
    return Scaffold(
      appBar: MyAppbar(),
      body: books.isEmpty
          ? const Center(child: Text("No favorite books"))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: books.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      final book = books[index];

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                child: book.frontCover != null
                                    ? Image.network(
                                        book.frontCover!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : Container(color: Colors.grey),
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    book.title ?? "No title",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteViewmodel>()
                                        .toggleFavorite(book);
                                  },
                                  icon: vm.isFavorite(book)
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 20,
                                        )
                                      : Icon(Icons.favorite_border, size: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
