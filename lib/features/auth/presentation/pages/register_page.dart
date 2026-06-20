import 'package:flutter/material.dart';
import 'package:staff_manager/core/theme/app_colors.dart';
import 'package:staff_manager/core/theme/app_text_styles.dart';
import 'package:staff_manager/core/utils/validators.dart';
import 'package:staff_manager/core/widgets/custom_button.dart';
import 'package:staff_manager/core/widgets/custom_text_form_field.dart';
import 'package:staff_manager/features/main_layout/presentation/app_shell.dart';

class RegisterPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const RegisterPage({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => AppShell(
            isDark: widget.isDark,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
                  const Icon(Icons.person_add_alt_1,
                      size: 80, color: AppColors.primary),
                  const SizedBox(height: 24),
                  const Text(
                    "Create Account",
                    style: AppTextStyles.bold28Dark,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Join the Tech Company Portal",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular16Grey,
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    keyboardType: TextInputType.name,
                    labelText: "Full Name",
                    hintText: "Example: Legend",
                    icon: Icons.person_outline,
                    validator: (value) =>
                        Validators.validateMinLength(value, 2, "Full name"),
                  ),
                  const SizedBox(height: 16),
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
                    hintText: "Create a password",
                    icon: Icons.lock_outline,
                    validator: Validators.validatePassword,
                    obscureText: _obscurePassword,
                    onToggleVisibility: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: "Confirm Password",
                    hintText: "Re-enter your password",
                    icon: Icons.lock_reset,
                    obscureText: _obscureConfirmPassword,
                    onToggleVisibility: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    validator: (value) => Validators.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    label: "Register",
                    icon: Icons.how_to_reg,
                    onPressed: _onRegister,
                  ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.login),
                    label: const Text(
                      "Already have an account? Login",
                      style: AppTextStyles.medium16Dark,
                    ),
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
