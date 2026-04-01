// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
    Pagination? pagination;
    List<Result>? results;

    BookModel({
        this.pagination,
        this.results,
    });

    factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Pagination {
    int? count;
    int? page;
    int? pages;
    String? previous;
    String? next;
    int? size;

    Pagination({
        this.count,
        this.page,
        this.pages,
        this.previous,
        this.next,
        this.size,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        page: json["page"],
        pages: json["pages"],
        previous: json["previous"],
        next: json["next"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "pages": pages,
        "previous": previous,
        "next": next,
        "size": size,
    };
}

class Result {
    String? title;
    String? englishTitle;
    String? slug;
    String? frontCover;

    Result({
        this.title,
        this.englishTitle,
        this.slug,
        this.frontCover,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        englishTitle: json["english_title"],
        slug: json["slug"],
        frontCover: json["front_cover"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "english_title": englishTitle,
        "slug": slug,
        "front_cover": frontCover,
    };
}
