import 'dart:io';
import 'package:contact_app/core/utils/colors.dart';
import 'package:contact_app/ui/screens/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddContactBottomSheet extends StatefulWidget {
  final Function(String name, String email, String phone, File? image)
      onAddContact;

   const AddContactBottomSheet({
    super.key,
    required this.onAddContact,
  });


  @override
  State<AddContactBottomSheet> createState() =>
      _AddContactBottomSheetState();
}

class _AddContactBottomSheetState
    extends State<AddContactBottomSheet> {
  final TextEditingController _nameController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _phoneController =
      TextEditingController();

  File? selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
      final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    
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
                          setState(() {
                            selectedImage = image;
                          });
                        }
                      },
                      child: Container(
                        height: 124,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius:
                              const BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: selectedImage != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12),
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
                    child: Column(
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
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextFieldContact(
                controller: _nameController,
                hintText: 'Enter User Name',
                outlineInputBorder: _border(),
              ),

              const SizedBox(height: 12),

              TextFieldContact(
                controller: _emailController,
                hintText: 'Enter User Email',
                outlineInputBorder: _border(),
              ),

              const SizedBox(height: 12),

              TextFieldContact(
                controller: _phoneController,
                hintText: 'Enter User Phone',
                outlineInputBorder: _border(),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter all information',
                          ),
                        ),
                      );
                      return;
                    }

                    widget.onAddContact(
                      _nameController.text.trim(),
                      _emailController.text.trim(),
                      _phoneController.text.trim(),
                      selectedImage,
                    );

                    Navigator.pop(context);
                  },
                  child: const Text('Enter User'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.whiteColor,
      ),
    );
  }

Future<File?> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return null;

    return File(image.path);
  }
}
