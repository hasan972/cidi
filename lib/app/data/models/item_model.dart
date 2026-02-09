import 'package:hive/hive.dart';

// Run the command below to generate the adopter for this model
part 'item_model.g.dart';
// Define the Hive type and fields for the ItemModel
@HiveType(typeId: 1)
// The ItemModel class represents an item with various attributes and is stored in hive for local persistence
class ItemModel extends HiveObject {
  @HiveField(0)
  String itemId;

  @HiveField(1)
  String itemName;

  @HiveField(2)
  String brandId;

  @HiveField(3)
  String brandName;

  @HiveField(4)
  String itemImage;

  @HiveField(5)
  String unitType;

  @HiveField(6)
  String price;
  

  ItemModel({
    required this.itemId,
    required this.itemName,
    required this.brandId,
    required this.brandName,
    required this.itemImage,
    required this.unitType,
    required this.price,
  });

  // Factory method to create an ItemModel instance from a json map, providing default values for missing fields
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json['item_id'] ?? '',
      itemName: json['item_name'] ?? '',
      brandId: json['brand_id'] ?? '',
      brandName: json['brand_name'] ?? '',
      itemImage: json['item_image'] ?? '',
      unitType: json['unit_type'] ?? '',
      price: json['price'] ?? '',
    );
  }
}
