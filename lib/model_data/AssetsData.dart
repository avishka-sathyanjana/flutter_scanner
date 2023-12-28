
class AssetsVarify{
  final String assetsItemeName;
  final String mainAssetsType;
  final String itemCode;
  final String Division;
  final String location;
  AssetsVarify({
    required this.assetsItemeName,
    required this.mainAssetsType,
    required this.itemCode,
    required this.Division,
    required this.location,
  });

}

class AssetsLocation{
  final String locationId;
  final String locationCode;
  AssetsLocation({required this.locationId,required this.locationCode});
}