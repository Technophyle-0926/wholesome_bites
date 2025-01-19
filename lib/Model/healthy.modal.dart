class HealthyRecipe {
  List<AllCategories>? allCategories;
  List<AllPosts>? allPosts;

  HealthyRecipe({this.allCategories, this.allPosts});

  HealthyRecipe.fromJson(Map<String, dynamic> json) {
    allCategories = json["all_categories"] == null
        ? null
        : (json["all_categories"] as List)
            .map((e) => AllCategories.fromJson(e))
            .toList();
    allPosts = json["all_posts"] == null
        ? null
        : (json["all_posts"] as List).map((e) => AllPosts.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allCategories != null) {
      data["all_categories"] = allCategories?.map((e) => e.toJson()).toList();
    }
    if (allPosts != null) {
      data["all_posts"] = allPosts?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class AllPosts {
  String? postId;
  String? calories;
  String? ingredients;
  String? methods;
  String? postImage;
  String? thumbImage;
  List<String>? catId;

  AllPosts(
      {this.postId,
      this.calories,
      this.ingredients,
      this.methods,
      this.postImage,
      this.thumbImage,
      this.catId});

  AllPosts.fromJson(Map<String, dynamic> json) {
    postId = json["post_id"];
    calories = json["calories"];
    ingredients = json["ingredients"];
    methods = json["methods"];
    postImage = json["post_image"];
    thumbImage = json["thumb_image"];
    catId = json["cat_id"] == null ? null : List<String>.from(json["cat_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["post_id"] = postId;
    data["calories"] = calories;
    data["ingredients"] = ingredients;
    data["methods"] = methods;
    data["post_image"] = postImage;
    data["thumb_image"] = thumbImage;
    if (catId != null) {
      data["cat_id"] = catId;
    }
    return data;
  }
}

class AllCategories {
  String? id;
  String? catName;
  String? catImage;
  String? thumbImage;

  AllCategories({this.id, this.catName, this.catImage, this.thumbImage});

  AllCategories.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    catName = json["cat_name"];
    catImage = json["cat_image"];
    thumbImage = json["thumb_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["cat_name"] = catName;
    data["cat_image"] = catImage;
    data["thumb_image"] = thumbImage;
    return data;
  }
}
