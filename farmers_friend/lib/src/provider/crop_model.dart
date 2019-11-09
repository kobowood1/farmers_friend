import 'package:farmers_friend/src/utility/prefs.dart';
import 'package:scoped_model/scoped_model.dart';

class CropModel extends Model{
  String country;
  String crop;

  Future getCrop() async{
    country = await getCountryFromPref();
    crop = await getCropFromPref();
    notifyListeners();
  }
}