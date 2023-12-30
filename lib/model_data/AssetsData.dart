
class AssetsVarify{
  final String assetsItemeName;
  final String mainAssetsType;
  final String itemCode;
  final String Division;
  final String location;
  //final DateTime itemLastCheck;
  final bool isNotverifyCurentYear;
  final bool allredyVerify;
  final bool dublicate;
  AssetsVarify({
    required this.assetsItemeName,
    required this.mainAssetsType,
    required this.itemCode,
    required this.Division,
    required this.location,
    this.isNotverifyCurentYear=false,
    this.allredyVerify=false,
    this.dublicate=false

  });

}

class AssetsLocation{
  final String locationId;
  final String locationCode;
  AssetsLocation({required this.locationId,required this.locationCode});
}