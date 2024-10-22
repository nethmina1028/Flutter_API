import 'package:flutter/material.dart';
import 'package:flutter_api/api/api_service.dart';
import 'package:flutter_api/models/product_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  ApiService apiService = ApiService();

    final _formKey = GlobalKey<FormState>();

    String title = '';
    double price = 0.0;
    String description = '';
    String image = '';
    String category = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Add Product"),
       ),

       body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter title';
                  }
                  return null;
                },
                onSaved: (value){
                  title = value!;
                },
              ),

               TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter price';
                  }
                  return null;
                },
                onSaved: (value){
                  price = double.parse(value!);
                },
              ),

             
               TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
            
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value){
                  description = value!;
                },
              ),

               TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
            
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value){
                  image = value!;
                },
              ),

              
               TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
            
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Please enter an category';
                  }
                  return null;
                },
                onSaved: (value){
                  category = value!;
                },
              ),

              const SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();

                    Product newProduct = Product(
                      title: title,
                      price: price,
                      description: description,
                      image: image,
                      category: category,
                    );
                     
                     apiService.addProduct(newProduct).then((value){
                        Navigator.pop(context);
                     });
                  }
                },
                child: const Text("Add Product"),
                ),
            ],
          ),
        ),
       ),
    );
  }
}