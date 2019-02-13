import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';

class StringUtils {
  static String getCategory(Opportunity opportunity) {
    switch (opportunity.category) {
      case Category.DIGITALEGELETTERDHEID:
        return "Digitale geletterdheid";
      case Category.DUURZAAMHEID:
        return "Duurzaamheid";
      case Category.ONDERNEMINGSZIN:
        return "Ondernemingszin";
      case Category.ONDERZOEK:
        return "Onderzoek";
      case Category.WERELDBURGERSCHAP:
        return "Wereldburgerschap";
    }
    return "Algemeen";
  }

  static Category getCategoryEnum(String category) {
    Category value;
    switch (category) {
      case "Digitale geletterdheid":
        value = Category.DIGITALEGELETTERDHEID;
        break;
      case "Duurzaamheid":
        value = Category.DUURZAAMHEID;
        break;
      case "Ondernemingszin":
        value = Category.ONDERNEMINGSZIN;
        break;
      case "Onderzoek":
        value = Category.ONDERZOEK;
        break;
      case "Wereldburgerschap":
        value = Category.WERELDBURGERSCHAP;
        break;
    }
    return value;
  }

  static String getDifficulty(Opportunity opportunity) {
    switch (opportunity.difficulty) {
      case Difficulty.BEGINNER:
        return "Niveau 1";
      case Difficulty.INTERMEDIATE:
        return "Niveau 2";
      case Difficulty.EXPERT:
        return "Niveau 3";
    }
    return "Niveau 0";
  }

  static Difficulty getDifficultyEnum(String difficulty) {
    Difficulty value;
    switch (difficulty) {
      case "Beginner":
        value = Difficulty.BEGINNER;
        break;
      case "Intermediate":
        value = Difficulty.INTERMEDIATE;
        break;
      case "Expert":
        value = Difficulty.EXPERT;
        break;
    }
    return value;
  }
}
