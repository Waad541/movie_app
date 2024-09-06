import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/categories_response.dart';
import 'package:movie_app/models/home_screen_details_response.dart';
import 'package:movie_app/models/more_like_response.dart';

import 'package:movie_app/models/popResponse.dart';

import 'models/category_details.dart';
import 'search/search_response.dart';
import 'models/toprated_response.dart';
import 'models/upcoming_response.dart';


class ApiManager{

  static Future<popularRespones> getPopSource()async{

    Uri url=Uri.https('api.themoviedb.org','/3/movie/popular',{
      "api_key":"02d767f9f511178360f503264f143f68"
    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    popularRespones popresponse= popularRespones.fromJson(json);
    return popresponse;
  }

  static Future<upComingResponse> getUpcomingSource()async{

    Uri url=Uri.https('api.themoviedb.org','/3/movie/upcoming',{
      "api_key":"02d767f9f511178360f503264f143f68"
    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    upComingResponse upComingresponse= upComingResponse.fromJson(json);
    return upComingresponse;
  }

  static Future<topRatedResponse> getTopRatedSource()async{

    Uri url=Uri.https('api.themoviedb.org','/3/movie/top_rated',{
      "api_key":"02d767f9f511178360f503264f143f68"
    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    topRatedResponse topRatedresponse= topRatedResponse.fromJson(json);
    return topRatedresponse;
  }

  static Future<homeScreenDetails> getHomeDetailsSource(int id) async {
    Uri url = Uri.https('api.themoviedb.org', '/3/movie/$id', {
      "api_key": "02d767f9f511178360f503264f143f68"
    });

    final response = await http.get(url);
    print('Response Body: ${response.body}'); // Debugging line
    final Map<String, dynamic> json = jsonDecode(response.body) as Map<String, dynamic>;
    print('Parsed JSON: $json'); // Debugging line

    homeScreenDetails homeDetailsResponse = homeScreenDetails.fromJson(json);
    return homeDetailsResponse;
  }

  static Future<MoreLikeResponse> getMoreLikeSource(int id)async{

    Uri url=Uri.https('api.themoviedb.org','/3/movie/$id/similar',{
      "api_key":"02d767f9f511178360f503264f143f68"
    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    MoreLikeResponse moreLikeResponse= MoreLikeResponse.fromJson(json);
    return moreLikeResponse;
  }

  static Future<SearchResponse> getSearchSource(String q)async{

    Uri url=Uri.https('api.themoviedb.org','/3/search/movie',{
      "api_key":"02d767f9f511178360f503264f143f68",
      "query":q
    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    SearchResponse searchResponse= SearchResponse.fromJson(json);
    return searchResponse;
  }

  static Future<CategoriesResponse> getCategoriesNameSource()async{

    Uri url=Uri.https('api.themoviedb.org','/3/genre/movie/list',{
      "api_key":"02d767f9f511178360f503264f143f68"
    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    CategoriesResponse categoriesResponse= CategoriesResponse.fromJson(json);
    return categoriesResponse;
  }

  static Future<CategoryDetailsResponse> getCategoryDetailsSource(String id)async{

    Uri url=Uri.https('api.themoviedb.org','/3/discover/movie',{
      "api_key":"02d767f9f511178360f503264f143f68",
      "with_genres":id

    });

    http.Response response = await http.get(url);
    var json=jsonDecode(response.body);
    CategoryDetailsResponse categorydetailsResponse= CategoryDetailsResponse.fromJson(json);
    return categorydetailsResponse;
  }

}