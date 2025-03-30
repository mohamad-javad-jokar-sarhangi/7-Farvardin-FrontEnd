import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfront/presentation/blocs/admin/user_bloc.dart';
import 'package:myfront/presentation/blocs/admin/user_event.dart';
import 'package:myfront/presentation/blocs/admin/user_state.dart';


class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  // لیست نقش‌ها
  final List<String> roles = ['روستایی', 'راننده', 'فروشنده', 'نانوا', 'دهیار', 'شورا'];

  String? _selectedRole; // مقدار انتخاب‌شده

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت نام کاربر جدید'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserLoading) {
            // نمایش dialog بارگذاری
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 20),
                      Text("در حال ثبت نام..."),
                    ],
                  ),
                );
              },
            );
          } else if (state is UserAdded) {
            // بستن dialog بارگذاری
            Navigator.of(context).pop();
            // نمایش SnackBar موفقیت
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('کاربر با موفقیت ثبت شد!')),
            );
            // بازگشت به صفحه قبلی
            Navigator.pop(context);
          } else if (state is UserError) {
            // بستن dialog بارگذاری
            Navigator.of(context).pop();
            // نمایش خطا در SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطا در ثبت نام: ${state.error}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // فیلد نام
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'نام کاربر',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً نام را وارد کنید';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // فیلد شماره تلفن
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'شماره تلفن',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً شماره تلفن را وارد کنید';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // فیلد انتخاب نقش
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'نقش کاربر',
                    border: OutlineInputBorder(),
                  ),
                  items: roles.map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفاً نقش کاربر را انتخاب کنید';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _selectedRole = value; // ذخیره مقدار انتخاب‌شده
                  },
                ),
                const SizedBox(height: 16),

                // دکمه‌ی افزودن کاربر
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<UserBloc>().add(
                        AddUser(
                          _nameController.text,
                          _phoneController.text,
                          _selectedRole!,
                        ),
                      );
                    } else {
                      // نمایش پیام خطا در صورت برقرار نبودن شرط
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('خطا در ثبت اطلاعات'),
                            content: const Text('لطفاً تمامی فیلدها را صحیح وارد کنید.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('باشه'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('افزودن کاربر'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
