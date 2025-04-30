class CategoryModel {
  String id;
  String name;
  int? iconCodePoint; // luu icon trong fluttet.icons
  String? iconColorHex; // color hex string
  String? backgroundColorHex;

  CategoryModel({
    required this.id,
    required this.name,
    this.iconCodePoint,
    this.iconColorHex,
    this.backgroundColorHex,
  });
}
