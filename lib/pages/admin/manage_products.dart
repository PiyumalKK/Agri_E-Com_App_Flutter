import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productOldPriceController =
      TextEditingController();
  final TextEditingController _offerTextController = TextEditingController();

  bool _isLoading = false;
  String? _selectedCategory;

  final List<String> _categories = [
    "tools",
    "Fruits & Vegetables",
    "Seeds & Plants",
    "Soil & Fertilizers",
    "Flowers",
    "Pesticides & Herbicides",
    "Dairy Products",
  ];

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('product_images/$fileName');
      await storageRef.putFile(image);
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      throw Exception("Image upload failed: $e");
    }
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
        );
        return;
      }

      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a category')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Upload the image and get its URL
        String imageUrl = await _uploadImage(_image!);

        // Add product to Firestore under the selected category
        await FirebaseFirestore.instance.collection(_selectedCategory!).add({
          'productTitle': _productTitleController.text.trim(),
          'productPrice': _productPriceController.text.trim(),
          'productOldPrice': _productOldPriceController.text.trim(),
          'offerText': _offerTextController.text.trim(),
          'productImage': imageUrl,
          'productId': DateTime.now().millisecondsSinceEpoch,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );

        // Reset form
        _formKey.currentState!.reset();
        setState(() {
          _image = null;
          _selectedCategory = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Product',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _image == null
                        ? const Icon(Icons.add_a_photo,
                            size: 50, color: Colors.grey)
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Select Category',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _productTitleController,
                  decoration: const InputDecoration(
                    labelText: 'Product Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter product title' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _productPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Product Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter product price' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _productOldPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Product Old Price',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter product old price' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _offerTextController,
                  decoration: const InputDecoration(
                    labelText: 'Offer Text',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter offer text' : null,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _addProduct,
                        child: const Text('Add Product'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
