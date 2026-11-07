import 'dart:io';

import 'package:contact_app/core/model/contact_model.dart';
import 'package:contact_app/core/utils/colors.dart';
import 'package:contact_app/core/utils/images.dart';
import 'package:contact_app/ui/screens/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  final List<Contact> contacts = [];

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  Future<File?> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return null;

    return File(image.path);
  }

  void _showAddContactSheet() {
    File? selectedImage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryColor,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                height: 467,
                
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final image = await _pickImage();

                                if (image != null) {
                                  setModalState(() {
                                    selectedImage = image;
                                  });
                                }
                              },
                              child: Container(
                                height: 124,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                child: selectedImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          selectedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Lottie.asset(
                                        'assets/animations/image_picker.json',
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: AnimatedBuilder(
                              animation: Listenable.merge([
                                _nameController,
                                _emailController,
                                _phoneController,
                              ]),
                              builder: (context, child) {
                                return Column(
                                  children: [
                                    TextFieldContact(
                                      controller: _nameController,
                                      hintText: 'User Name',
                                    ),
                                    TextFieldContact(
                                      controller: _emailController,
                                      hintText: 'example@email.com',
                                    ),
                                    TextFieldContact(
                                      controller: _phoneController,
                                      hintText: '+200000000000',
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      TextFieldContact(
                        controller: _nameController,
                        hintText: 'Enter User Name',
                        outlineInputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.whiteColor,
                            
                          ),
                          
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFieldContact(
                        controller: _emailController,
                        hintText: 'Enter User Email',
                        outlineInputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      TextFieldContact(
                        controller: _phoneController,
                        hintText: 'Enter User Phone',
                        outlineInputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.goldColor,
                            foregroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_nameController.text.trim().isEmpty ||
                                _emailController.text.trim().isEmpty ||
                                _phoneController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(sheetContext).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter all information'),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              contacts.add(
                                Contact(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  phone: _phoneController.text.trim(),
                                  image: selectedImage,
                                ),
                              );
                            });

                            _nameController.clear();
                            _emailController.clear();
                            _phoneController.clear();

                            Navigator.pop(sheetContext);
                          },
                          child: const Text('Enter User'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildContactCard(Contact contact, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.goldColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: contact.image != null
                        ? Image.file(
                            contact.image!,
                            width: double.infinity,
                          fit: BoxFit.fill,
                        )
                      : const Center(
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: AppColors.primaryColor,
                          ),
                        ),
                ),
           ] ),
            ),


          

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(
                  Icons.email,
                  size: 14,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 17,),
                Text(
                  contact.email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 14,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 17,),
                Text(
                  contact.phone,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

          
            Container(
              width: double.infinity,
              height: 30,
              margin: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.redColor,
                  foregroundColor: AppColors.goldColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: const Text('Delete'),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Image(image: AssetImage(AppImages.logo), height: 40),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactSheet,
        backgroundColor: AppColors.goldColor,
        child: const Icon(Icons.add, color: AppColors.primaryColor),
      ),

      body: contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/list purple.json',
                    height: 250,
                    fit: BoxFit.contain,
                    repeat: true,
                    animate: true,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      );
                    },
                  ),

                  const Text(
                    'There is No Contacts Added Here',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: contacts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  return _buildContactCard(contacts[index], index);
                },
              ),
            ),
    );
  }
}
