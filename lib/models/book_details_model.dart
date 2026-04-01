// To parse this JSON data, do
//
//     final bookDetailsModel = bookDetailsModelFromJson(jsonString);

import 'dart:convert';

BookDetailsModel bookDetailsModelFromJson(String str) =>
    BookDetailsModel.fromJson(json.decode(str));

String bookDetailsModelToJson(BookDetailsModel data) =>
    json.encode(data.toJson());

class BookDetailsModel {
  int? id;
  String slug;
  String? nepaliTitle;
  String? englishTitle;
  dynamic nepaliSubtitle;
  dynamic englishSubtitle;
  String? nepaliDescription;
  String? englishDescription;
  String? backCoverText;
  String? language;
  List<Category>? categories;
  List<Author>? authors;
  List<dynamic>? contributions;
  bool? hasCommonPublisher;
  List<dynamic>? bookAwards;
  List<dynamic>? bookAwardShortlists;
  String? frontCover;
  String? frontCoverFull;
  String? backCoverFull;
  String? backCoverThumbnail;
  String? featuredImage;
  List<RelatedBook>? relatedBooks;
  bool? isUnicode;
  bool? hasTableOfContents;
  dynamic pdf;
  Ebook? ebook;
  dynamic audiobook;
  List<Edition>? editions;
  Publisher? publisher;
  dynamic amazon;
  DateTime? releaseOn;
  bool? released;
  List<Review>? reviews;
  int? averageRating;
  dynamic userReview;
  List<dynamic>? blurbQuotes;

  BookDetailsModel({
    this.id,
    required this.slug,
    this.nepaliTitle,
    this.englishTitle,
    this.nepaliSubtitle,
    this.englishSubtitle,
    this.nepaliDescription,
    this.englishDescription,
    this.backCoverText,
    this.language,
    this.categories,
    this.authors,
    this.contributions,
    this.hasCommonPublisher,
    this.bookAwards,
    this.bookAwardShortlists,
    this.frontCover,
    this.frontCoverFull,
    this.backCoverFull,
    this.backCoverThumbnail,
    this.featuredImage,
    this.relatedBooks,
    this.isUnicode,
    this.hasTableOfContents,
    this.pdf,
    this.ebook,
    this.audiobook,
    this.editions,
    this.publisher,
    this.amazon,
    this.releaseOn,
    this.released,
    this.reviews,
    this.averageRating,
    this.userReview,
    this.blurbQuotes,
  });

  factory BookDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) => BookDetailsModel(
    id: json["id"],
    slug: json["slug"],
    nepaliTitle: json["nepali_title"],
    englishTitle: json["english_title"],
    nepaliSubtitle: json["nepali_subtitle"],
    englishSubtitle: json["english_subtitle"],
    nepaliDescription: json["nepali_description"],
    englishDescription: json["english_description"],
    backCoverText: json["back_cover_text"],
    language: json["language"],
    categories: json["categories"] == null
        ? []
        : List<Category>.from(
            json["categories"]!.map((x) => Category.fromJson(x)),
          ),
    authors: json["authors"] == null
        ? []
        : List<Author>.from(json["authors"]!.map((x) => Author.fromJson(x))),
    contributions: json["contributions"] == null
        ? []
        : List<dynamic>.from(json["contributions"]!.map((x) => x)),
    hasCommonPublisher: json["has_common_publisher"],
    bookAwards: json["book_awards"] == null
        ? []
        : List<dynamic>.from(json["book_awards"]!.map((x) => x)),
    bookAwardShortlists: json["book_award_shortlists"] == null
        ? []
        : List<dynamic>.from(json["book_award_shortlists"]!.map((x) => x)),
    frontCover: json["front_cover"],
    frontCoverFull: json["front_cover_full"],
    backCoverFull: json["back_cover_full"],
    backCoverThumbnail: json["back_cover_thumbnail"],
    featuredImage: json["featured_image"],
    relatedBooks: json["related_books"] == null
        ? []
        : List<RelatedBook>.from(
            json["related_books"]!.map((x) => RelatedBook.fromJson(x)),
          ),
    isUnicode: json["is_unicode"],
    hasTableOfContents: json["has_table_of_contents"],
    pdf: json["pdf"],
    ebook: json["ebook"] == null ? null : Ebook.fromJson(json["ebook"]),
    audiobook: json["audiobook"],
    editions: json["editions"] == null
        ? []
        : List<Edition>.from(json["editions"]!.map((x) => Edition.fromJson(x))),
    publisher: json["publisher"] == null
        ? null
        : Publisher.fromJson(json["publisher"]),
    amazon: json["amazon"],
    releaseOn: json["release_on"] == null
        ? null
        : DateTime.parse(json["release_on"]),
    released: json["released"],
    reviews: json["reviews"] == null
        ? []
        : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    averageRating: json["average_rating"],
    userReview: json["user_review"],
    blurbQuotes: json["blurb_quotes"] == null
        ? []
        : List<dynamic>.from(json["blurb_quotes"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "nepali_title": nepaliTitle,
    "english_title": englishTitle,
    "nepali_subtitle": nepaliSubtitle,
    "english_subtitle": englishSubtitle,
    "nepali_description": nepaliDescription,
    "english_description": englishDescription,
    "back_cover_text": backCoverText,
    "language": language,
    "categories": categories == null
        ? []
        : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "authors": authors == null
        ? []
        : List<dynamic>.from(authors!.map((x) => x.toJson())),
    "contributions": contributions == null
        ? []
        : List<dynamic>.from(contributions!.map((x) => x)),
    "has_common_publisher": hasCommonPublisher,
    "book_awards": bookAwards == null
        ? []
        : List<dynamic>.from(bookAwards!.map((x) => x)),
    "book_award_shortlists": bookAwardShortlists == null
        ? []
        : List<dynamic>.from(bookAwardShortlists!.map((x) => x)),
    "front_cover": frontCover,
    "front_cover_full": frontCoverFull,
    "back_cover_full": backCoverFull,
    "back_cover_thumbnail": backCoverThumbnail,
    "featured_image": featuredImage,
    "related_books": relatedBooks == null
        ? []
        : List<dynamic>.from(relatedBooks!.map((x) => x.toJson())),
    "is_unicode": isUnicode,
    "has_table_of_contents": hasTableOfContents,
    "pdf": pdf,
    "ebook": ebook?.toJson(),
    "audiobook": audiobook,
    "editions": editions == null
        ? []
        : List<dynamic>.from(editions!.map((x) => x.toJson())),
    "publisher": publisher?.toJson(),
    "amazon": amazon,
    "release_on":
        "${releaseOn!.year.toString().padLeft(4, '0')}-${releaseOn!.month.toString().padLeft(2, '0')}-${releaseOn!.day.toString().padLeft(2, '0')}",
    "released": released,
    "reviews": reviews == null
        ? []
        : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "average_rating": averageRating,
    "user_review": userReview,
    "blurb_quotes": blurbQuotes == null
        ? []
        : List<dynamic>.from(blurbQuotes!.map((x) => x)),
  };
}

class Author {
  String? name;
  String? localizedName;
  String? slug;
  String? description;
  String? photo;

  Author({
    this.name,
    this.localizedName,
    this.slug,
    this.description,
    this.photo,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    name: json["name"],
    localizedName: json["localized_name"],
    slug: json["slug"],
    description: json["description"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "localized_name": localizedName,
    "slug": slug,
    "description": description,
    "photo": photo,
  };
}

class Category {
  String? slug;
  String? name;

  Category({this.slug, this.name});

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(slug: json["slug"], name: json["name"]);

  Map<String, dynamic> toJson() => {"slug": slug, "name": name};
}

class Ebook {
  int? mrp;
  int? productId;
  int? sellingPrice;
  OwnershipStatus? ownershipStatus;
  bool? hasAudio;
  bool? isImageBook;
  String? googlePlayPid;
  bool? allowPurchase;
  bool? hasPreview;

  Ebook({
    this.mrp,
    this.productId,
    this.sellingPrice,
    this.ownershipStatus,
    this.hasAudio,
    this.isImageBook,
    this.googlePlayPid,
    this.allowPurchase,
    this.hasPreview,
  });

  factory Ebook.fromJson(Map<String, dynamic> json) => Ebook(
    mrp: json["mrp"],
    productId: json["product_id"],
    sellingPrice: json["selling_price"],
    ownershipStatus: json["ownership_status"] == null
        ? null
        : OwnershipStatus.fromJson(json["ownership_status"]),
    hasAudio: json["has_audio"],
    isImageBook: json["is_image_book"],
    googlePlayPid: json["google_play_pid"],
    allowPurchase: json["allow_purchase"],
    hasPreview: json["has_preview"],
  );

  Map<String, dynamic> toJson() => {
    "mrp": mrp,
    "product_id": productId,
    "selling_price": sellingPrice,
    "ownership_status": ownershipStatus?.toJson(),
    "has_audio": hasAudio,
    "is_image_book": isImageBook,
    "google_play_pid": googlePlayPid,
    "allow_purchase": allowPurchase,
    "has_preview": hasPreview,
  };
}

class OwnershipStatus {
  bool? released;
  int? version;

  OwnershipStatus({this.released, this.version});

  factory OwnershipStatus.fromJson(Map<String, dynamic> json) =>
      OwnershipStatus(released: json["released"], version: json["version"]);

  Map<String, dynamic> toJson() => {"released": released, "version": version};
}

class Edition {
  String? format;
  bool? released;
  DateTime? releaseOn;
  String? editionText;
  String? deliveryTime;
  String? isbn13;
  String? pages;
  dynamic width;
  dynamic height;
  dynamic thickness;
  int? weight;
  int? mrp;
  int? sellingPrice;
  int? productId;
  String? origin;
  String? isbn10;
  dynamic dimensions;
  bool? available;
  Publisher? publisher;
  String? frontCover;
  int? publicationYear;

  Edition({
    this.format,
    this.released,
    this.releaseOn,
    this.editionText,
    this.deliveryTime,
    this.isbn13,
    this.pages,
    this.width,
    this.height,
    this.thickness,
    this.weight,
    this.mrp,
    this.sellingPrice,
    this.productId,
    this.origin,
    this.isbn10,
    this.dimensions,
    this.available,
    this.publisher,
    this.frontCover,
    this.publicationYear,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
    format: json["format"],
    released: json["released"],
    releaseOn: json["release_on"] == null
        ? null
        : DateTime.parse(json["release_on"]),
    editionText: json["edition_text"],
    deliveryTime: json["delivery_time"],
    isbn13: json["isbn13"],
    pages: json["pages"],
    width: json["width"],
    height: json["height"],
    thickness: json["thickness"],
    weight: json["weight"],
    mrp: json["mrp"],
    sellingPrice: json["selling_price"],
    productId: json["product_id"],
    origin: json["origin"],
    isbn10: json["isbn10"],
    dimensions: json["dimensions"],
    available: json["available"],
    publisher: json["publisher"] == null
        ? null
        : Publisher.fromJson(json["publisher"]),
    frontCover: json["front_cover"],
    publicationYear: json["publication_year"],
  );

  Map<String, dynamic> toJson() => {
    "format": format,
    "released": released,
    "release_on":
        "${releaseOn!.year.toString().padLeft(4, '0')}-${releaseOn!.month.toString().padLeft(2, '0')}-${releaseOn!.day.toString().padLeft(2, '0')}",
    "edition_text": editionText,
    "delivery_time": deliveryTime,
    "isbn13": isbn13,
    "pages": pages,
    "width": width,
    "height": height,
    "thickness": thickness,
    "weight": weight,
    "mrp": mrp,
    "selling_price": sellingPrice,
    "product_id": productId,
    "origin": origin,
    "isbn10": isbn10,
    "dimensions": dimensions,
    "available": available,
    "publisher": publisher?.toJson(),
    "front_cover": frontCover,
    "publication_year": publicationYear,
  };
}

class Publisher {
  String? slug;
  String? displayName;
  String? logo;

  Publisher({this.slug, this.displayName, this.logo});

  factory Publisher.fromJson(Map<String, dynamic> json) => Publisher(
    slug: json["slug"],
    displayName: json["display_name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "display_name": displayName,
    "logo": logo,
  };
}

class RelatedBook {
  String? title;
  String? englishTitle;
  String? slug;
  String? frontCover;

  RelatedBook({this.title, this.englishTitle, this.slug, this.frontCover});

  factory RelatedBook.fromJson(Map<String, dynamic> json) => RelatedBook(
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

class Review {
  String? user;
  int? rating;
  String? review;
  String? createdAt;

  Review({this.user, this.rating, this.review, this.createdAt});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    user: json["user"],
    rating: json["rating"],
    review: json["review"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "rating": rating,
    "review": review,
    "created_at": createdAt,
  };
}
