import 'package:healthy_care/model/detail_recipe_model.dart';

class SearchModel{
  int totalResults;
  List<RecipeModel> recipes;

  SearchModel(this.totalResults, this.recipes);
}