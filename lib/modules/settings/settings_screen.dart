import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).userModel.data.name;
        emailController.text = ShopCubit.get(context).userModel.data.email;
        phoneController.text = ShopCubit.get(context).userModel.data.phone;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if(state is ShopLoadingUpdateUserState)
                LinearProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                controller: nameController,
                label: 'Name',
                prefix: Icons.person,
                validate: (String value) {
                  if (value.isEmpty) return 'Please enter your name';
                },
              ),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                controller: emailController,
                label: 'Email',
                prefix: Icons.email,
                validate: (String value) {
                  if (value.isEmpty) return 'Please enter your email';
                },
              ),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                controller: phoneController,
                label: 'Phone',
                prefix: Icons.phone,
                validate: (String value) {
                  if (value.isEmpty) return 'Please enter your phone number';
                },
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  defaultButton(
                    width: 160,
                    background: Colors.redAccent,
                    text: 'Logout',
                    function: (){
                      ShopCubit.get(context).logout(context);
                    },
                  ),
                  Spacer(),
                  defaultButton(
                    width: 160,
                    text: 'Edit profile',
                    function: (){
                      ShopCubit.get(context).updateUserData(
                        name: nameController.text,
                        phone: phoneController.text,
                        email: emailController.text,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
