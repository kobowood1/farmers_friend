import 'package:shared_preferences/shared_preferences.dart';


// ===================================== SHARED PREFERENCES =================================== //
  SharedPreferences _farmersFriendPrefs;
  final String _namePref = "namePref";
  final String _countryPref = "countryPref";
  final String _cropPref = "cropPref";

  
  


  Future<bool> saveNameToPref(String name) async{
    _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.setString(_namePref, name);
  }

  Future<bool> saveCountryToPref(String country) async{
    _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.setString(_countryPref, country);
  }

  Future<bool> saveCropToPref(String crop) async{
     _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.setString(_cropPref, crop);
  }

  Future<String> getNameFromPref() async{
    _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.getString(_namePref);
  }

  Future<String> getCountryFromPref() async{
    _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.getString(_countryPref);
  }


  Future<String> getCropFromPref() async{
    _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.getString(_cropPref);
  }

  Future<bool> deleteAllPrefs() async{
    _farmersFriendPrefs = await SharedPreferences.getInstance();
    return _farmersFriendPrefs.clear();
  }