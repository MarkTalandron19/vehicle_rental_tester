import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  Widget edit(String title, TextEditingController controller) {
    return Row(
      children: [
        Text('$title:'),
        const SizedBox(
          width: 10,
        ),
        TextField(
          controller: controller,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameEditor = TextEditingController();
    TextEditingController firstNameEditor = TextEditingController();
    TextEditingController lastNameEditor = TextEditingController();
    userNameEditor.text = context.read<AccountProvider>().username!;
    firstNameEditor.text = context.read<AccountProvider>().firstName!;
    lastNameEditor.text = context.read<AccountProvider>().lastName!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text('Username:'),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: userNameEditor,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Username'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text('First Name:'),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: firstNameEditor,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'First Name'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Text('Last Name:'),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: lastNameEditor,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Last Name'),
                ),
              ),
            ],
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Submit')),
        ],
      ),
    );
  }
}
