import 'package:realm/realm.dart'; // import realm package

part 'category_realm_entity.realm.dart'; // declare a part file.

@RealmModel() // define a data model class named `_Car`.
class $CategoryRealmEntity {
  @PrimaryKey()
  late ObjectId id;
  late String name;
  late int? iconCodePoint; // luu icon trong fluttet.icons
  late String? iconColorHex; // color hex string
  late String? backgroundColorHex; // color hex string
}
