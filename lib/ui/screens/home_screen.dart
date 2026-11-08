import 'package:contact_app/core/model/contact_model.dart';
import 'package:contact_app/core/utils/colors.dart';
import 'package:contact_app/core/utils/images.dart';
import 'package:contact_app/ui/screens/widget/add_show_contact_sheet.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> contacts = [];

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

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

      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            backgroundColor: AppColors.redColor,
            onPressed: () {
              setState(() {
                contacts.removeLast(
                
                );
              });
            },
            child: const Icon(Icons.delete, color: AppColors.goldColor),
          ),

          const SizedBox(height: 12),

          FloatingActionButton(
            onPressed: _showAddContactSheet,
            child: const Icon(Icons.add),
          ),
        ],
      ),

      body: contacts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/empty_list.json',
                    height: 250,
                    fit: BoxFit.contain,
                    repeat: true,
                    animate: true,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                        color: AppColors.redColor,
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
                ],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.email,
                  size: 14,
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 17),
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
                SizedBox(width: 17),
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
            ),
          ],
        ),
      ),
    );
  }

  void _showAddContactSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primaryColor,
      builder: (context) {
        return AddContactBottomSheet(
          onAddContact: (name, email, phone, image) {
            setState(() {
              contacts.add(
                Contact(name: name, email: email, phone: phone, image: image),
              );
            });
          },
        );
      },
    );
  }
}
