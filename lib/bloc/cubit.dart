import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/bloc/states.dart';

import '../models/categories_response.dart';
import '../models/category_details.dart';
import '../models/home_screen_details_response.dart';
import '../models/more_like_response.dart';
import '../models/popResponse.dart';
import '../models/toprated_response.dart';
import '../models/upcoming_response.dart';
import '../search/search_response.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());
  static HomeCubit get(context) => BlocProvider.of(context);
  popularRespones? popresponse;
  upComingResponse? upComingresponse;
  topRatedResponse? topRatedresponse;
  homeScreenDetails? homeDetailsResponse;
  MoreLikeResponse? moreLikeResponse;
  SearchResponse? searchResponse;
  CategoriesResponse? categoriesResponse;
  CategoryDetailsResponse? categorydetailsResponse;

  Future<void> getPopSource() async {
    try {
      emit(HomeGetSourceLoadingState());
      Uri url = Uri.https('api.themoviedb.org', '/3/movie/popular',
          {"api_key": "02d767f9f511178360f503264f143f68"});

      http.Response response = await http.get(url);
      var json = jsonDecode(response.body);
      popresponse = popularRespones.fromJson(json);
      emit(HomeGetSourceSuccessState());
    } catch (e) {
      emit(HomeGetSourceErrorState());
    }
  }

  Future<void> getUpcomingSource() async {
    try {
      emit(HomeGetSourceLoadingState());

      Uri url = Uri.https('api.themoviedb.org', '/3/movie/upcoming',
          {"api_key": "02d767f9f511178360f503264f143f68"});

      http.Response response = await http.get(url);
      var json = jsonDecode(response.body);
      upComingresponse = upComingResponse.fromJson(json);
      emit(HomeGetSourceSuccessState());
    } catch (e) {
      emit(HomeGetSourceErrorState());
    }
  }

  Future<void> getTopRatedSource() async {
    try {
      emit(HomeGetSourceLoadingState());
      Uri url = Uri.https('api.themoviedb.org', '/3/movie/top_rated',
          {"api_key": "02d767f9f511178360f503264f143f68"});

      http.Response response = await http.get(url);
      var json = jsonDecode(response.body);
      topRatedresponse = topRatedResponse.fromJson(json);
      emit(HomeGetSourceSuccessState());
    } catch (e) {
      emit(HomeGetSourceErrorState());
    }
  }

  Future<void> getHomeDetailsSource(int id) async {
    try {
      Uri url = Uri.https('api.themoviedb.org', '/3/movie/$id',
          {"api_key": "02d767f9f511178360f503264f143f68"});

      final response = await http.get(url);

      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;

      homeDetailsResponse = homeScreenDetails.fromJson(json);
    } catch (e) {
      emit(HomeGetSourceErrorState());
    }
  }

   Future<void> getMoreLikeSource(int id)async{

   try{
     emit(HomeGetSourceLoadingState());
     Uri url=Uri.https('api.themoviedb.org','/3/movie/$id/similar',{
       "api_key":"02d767f9f511178360f503264f143f68"
     });

     http.Response response = await http.get(url);
     var json=jsonDecode(response.body);
     moreLikeResponse= MoreLikeResponse.fromJson(json);
     emit(HomeGetSourceSuccessState());
   }catch(e){
     emit(HomeGetSourceErrorState());
   }

  }

   Future<void> getSearchSource(String q)async{

   try{
     emit(HomeGetSourceLoadingState());
     Uri url=Uri.https('api.themoviedb.org','/3/search/movie',{
       "api_key":"02d767f9f511178360f503264f143f68",
       "query":q
     });

     http.Response response = await http.get(url);
     var json=jsonDecode(response.body);
      searchResponse= SearchResponse.fromJson(json);
     emit(HomeGetSourceSuccessState());
   }catch(e){
     emit(HomeGetSourceErrorState());
   }

  }

   Future<void> getCategoriesNameSource()async{

   try{
     emit(HomeGetSourceLoadingState());
     Uri url=Uri.https('api.themoviedb.org','/3/genre/movie/list',{
       "api_key":"02d767f9f511178360f503264f143f68"
     });

     http.Response response = await http.get(url);
     var json=jsonDecode(response.body);
     categoriesResponse= CategoriesResponse.fromJson(json);
     emit(HomeGetSourceSuccessState());
   }catch(e){
     emit(HomeGetSourceErrorState());
   }

  }

   Future<void> getCategoryDetailsSource(String id)async{

   try{
     emit(HomeGetSourceLoadingState());
     Uri url=Uri.https('api.themoviedb.org','/3/discover/movie',{
       "api_key":"02d767f9f511178360f503264f143f68",
       "with_genres":id

     });

     http.Response response = await http.get(url);
     var json=jsonDecode(response.body);
     categorydetailsResponse= CategoryDetailsResponse.fromJson(json);
     emit(HomeGetSourceSuccessState());
   }
   catch(e){
     emit(HomeGetSourceErrorState());
   }

  }
}
