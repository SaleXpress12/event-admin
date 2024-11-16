import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evente_mobile_admin_app/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:evente/evente.dart';

class SearchBloc with ChangeNotifier {


  SearchBloc (){
    getRecentSearchList();
  }


  List<String> _recentSearchData = [];
  List<String> get recentSearchData => _recentSearchData;

  String _searchText = '';
  String get searchText => _searchText;


  bool _searchStarted = false;
  bool get searchStarted => _searchStarted;

  
  final TextEditingController _textFieldCtrl = TextEditingController();
  TextEditingController get textfieldCtrl => _textFieldCtrl;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;




  Future getRecentSearchList() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData = sp.getStringList('recent_search_data') ?? [];
    notifyListeners();
  }


  Future addToSearchList (String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.add(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    notifyListeners();
  }



  Future removeFromSearchList (String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _recentSearchData.remove(value);
    await sp.setStringList('recent_search_data', _recentSearchData);
    notifyListeners();
  }





  Future<List> getData() async {

    List<Event> data = [];
    QuerySnapshot rawData = await firestore
        .collection('event')
        .get();

    List<DocumentSnapshot> snap = [];
    snap.addAll(rawData.docs
    .where((u) => (

      u['title'].toLowerCase().contains(_searchText.toLowerCase()) ||
      u['location'].toLowerCase().contains(_searchText.toLowerCase()) ||
      u['description'].toLowerCase().contains(_searchText.toLowerCase())
      
      )));
    data = snap.map((e) => Event.fromFirestore(e)).toList();
    return data;


  }

  Future<List> getDataUser() async {

    List<UserModel> data = [];
    QuerySnapshot rawData = await firestore
        .collection('users')
        .get();

    List<DocumentSnapshot> snap = [];
    snap.addAll(rawData.docs
    .where((u) => (

      u['name'].toLowerCase().contains(_searchText.toLowerCase()) ||
      u['email'].toLowerCase().contains(_searchText.toLowerCase())
      
      )));
    data = snap.map((e) => UserModel.fromFirestore(e)).toList();
    return data;


  }





  setSearchText (value){
    _textFieldCtrl.text = value;
    _searchText = value;
    _searchStarted = true;
    notifyListeners();
  }


  saerchInitialize (){
    _textFieldCtrl.clear();
    _searchStarted = false;
    notifyListeners();
    
  }



  
}