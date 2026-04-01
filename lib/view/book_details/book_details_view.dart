import 'package:flutter/material.dart';
import 'package:mvvm_practice/view/book_details/book_details_viewmodel.dart';
import 'package:mvvm_practice/view/widgets/my_appbar.dart';
import 'package:provider/provider.dart';

class BookDetailsView extends StatelessWidget {
  final String slug;

  const BookDetailsView({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookDetailsViewmodel>(
      create: (_) => BookDetailsViewmodel()..fetchBookDetails(slug),
      builder: (context, child) {
        return Scaffold(
          appBar: MyAppbar(title: "Thuprai"),

          body: Builder(
            builder: (context) {
              if (context.watch<BookDetailsViewmodel>().isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                );
              }

              if (context.watch<BookDetailsViewmodel>().error != null) {
                return Center(
                  child: Text(context.watch<BookDetailsViewmodel>().error!),
                );
              }

              if (context.watch<BookDetailsViewmodel>().bookDetails == null) {
                return const Center(child: Text("No data"));
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 200,
                          width: 150,
                          color: Colors.grey,
                          child:
                              context
                                      .watch<BookDetailsViewmodel>()
                                      .bookDetails!
                                      .frontCover !=
                                  null
                              ? Image.network(
                                  context
                                      .watch<BookDetailsViewmodel>()
                                      .bookDetails!
                                      .frontCover!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Container(color: Colors.grey),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context
                                        .watch<BookDetailsViewmodel>()
                                        .bookDetails!
                                        .englishTitle ??
                                    "No title",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                context
                                        .watch<BookDetailsViewmodel>()
                                        .bookDetails!
                                        .englishSubtitle ??
                                    "No Subtitle",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "by ${context.watch<BookDetailsViewmodel>().bookDetails!.authors![0].name}",
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
