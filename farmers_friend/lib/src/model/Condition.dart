
class Condition {
  int id;
  String description;

  Condition({this.id, this.description});

  String getAssetString() {
    if (id >= 200 && id <= 299)
      return "assets/images/thunderstorm.png";
    else if (id >= 300 && id <= 399)
      return "assets/images/d6s.png";
    else if (id >= 500 && id <= 599)
      return "assets/images/thunderstorm.png";
    else if (id >= 600 && id <= 699)
      return "assets/images/d8s.png";
    else if (id >= 700 && id <= 799)
      return "assets/images/d9s.png";
    else if (id >= 300 && id <= 399)
      return "assets/images/d6s.png";
    else if (id == 800)
      return "assets/images/sun.png";
    else if (id == 801)
      return "assets/images/sunshine.png";
    else if (id == 802)
      return "assets/images/sunshine.png";
    else if (id == 803 || id == 804)
      return "assets/images/d4s.png";

    print("Unknown condition $id");
    return "assets/images/n1s.png";
  }
}