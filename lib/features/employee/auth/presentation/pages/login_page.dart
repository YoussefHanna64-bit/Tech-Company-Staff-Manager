import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/core/theme/app_text_styles.dart';
import 'package:staff_manager/core/utils/validators.dart';
import 'package:staff_manager/core/widgets/custom_button.dart';
import 'package:staff_manager/core/widgets/custom_text_form_field.dart';

class LoginPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const LoginPage(
      {super.key, required this.isDark, required this.onThemeChanged});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Welcome back")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.business_center,
                      size: 80, color: AppColors.primary),
                  const SizedBox(height: 24),
                  const Text(
                    "Tech Company Portal",
                    style: AppTextStyles.bold28Dark,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign in to manage employees and departments",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular16Grey,
                  ),
                  const SizedBox(height: 48),
                  CustomTextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    labelText: "Email",
                    hintText: "example@company.com",
                    icon: Icons.email_outlined,
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: "Password",
                    hintText: "Enter your password",
                    icon: Icons.lock_outline,
                    validator: Validators.validatePassword,
                    obscureText: _obscurePassword,
                    onToggleVisibility: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    label: "Login",
                    icon: Icons.login,
                    onPressed: _onSubmit,
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add),
                    label: const Text("Create account",
                        style: AppTextStyles.medium16Dark),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
