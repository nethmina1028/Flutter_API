import 'dart:convert';
import 'package:flutter_api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  //fetcch all products from api
  Future<List<Product>> fetchAllProducts() async {
  const String url = 'https://fakestoreapi.com/products';

  try{
    final responce = await http.get(Uri.parse(url));
    
    if(responce.statusCode == 200){
      List<dynamic> responceData = json.decode(responce.body);
      List<Product> products = responceData.map((json){
        return Product.fromJson(json);
      }).toList();
      return products;

    }
    else{
      print("Faild to fetch products the statistus code is ${responce.statusCode}");
      throw Exception("Faild to fetch products");
    }
  } catch (error){
    print("Error: $error");
    throw Exception("Faild to fetch products");
  }
  }

         // Fetch a single product from the API
  Future<Product> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Product product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
        throw Exception("Failed to fetch product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch product");
    }
  }


      // Add a new product to the API
     
     Future<Product> addProduct(Product product) async {
       const String url = 'https://fakestoreapi.com/products';

       try{
         final response = await http.post(
           Uri.parse(url),
           headers:{'Content-Type': 'application/json'},
           body: json.encode(product.toJson()),
         );

         print("response status code: ${response.statusCode}");

         if(response.statusCode == 201 || response.statusCode == 200){
          print("response:${response.body}");
           Product newProduct = Product.fromJson(json.decode(response.body));
           return newProduct;
         } else{

           print("Failed to add product. Status code: ${response.statusCode}");
           print("Response body: ${response.body}");
           throw Exception("Failed to add product");
         }
       } catch (error){
         print("Error: $error");
         throw Exception("Failed to add product");
       }
     }
  


}