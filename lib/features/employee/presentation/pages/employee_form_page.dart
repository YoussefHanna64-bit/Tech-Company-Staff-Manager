import 'package:flutter/material.dart';
import 'package:staff_manager/core/constants/app_icons.dart';
import 'package:staff_manager/core/utils/validators.dart';
import 'package:staff_manager/core/widgets/custom_button.dart';
import 'package:staff_manager/core/widgets/custom_drop_down_form_field.dart';
import 'package:staff_manager/core/widgets/custom_text_form_field.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';

class EmployeeFormPage extends StatefulWidget {
  final Employee? existingEmployee;

  const EmployeeFormPage({super.key, this.existingEmployee});

  bool get isEditing => existingEmployee != null;

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  EmployeeDepartment _selectedDepartment = EmployeeDepartment.engineering;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      final emp = widget.existingEmployee!;
      _nameController.text = emp.fullName;
      _jobTitleController.text = emp.jobTitle;
      _salaryController.text = emp.salary.toString();
      _selectedDepartment = emp.department;
      _isFavorite = emp.isFavorite;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.existingEmployee?.id ?? 0,
        fullName: _nameController.text.trim(),
        jobTitle: _jobTitleController.text.trim(),
        department: _selectedDepartment,
        salary: double.parse(_salaryController.text.trim()),
        isFavorite: _isFavorite,
      );

      Navigator.of(context).pop(employee);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = widget.isEditing ? 'Edit Employee' : 'Add Employee';
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    titleText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomTextFormField(
                  controller: _nameController,
                  labelText: 'Full name',
                  hintText: 'Example: Legend',
                  icon: AppIcons.personOutline,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      Validators.validateMinLength(value, 2, "Full name"),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _jobTitleController,
                  labelText: 'Job title',
                  hintText: 'Example: Flutter Developer',
                  icon: AppIcons.workOutline,
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      Validators.validateMinLength(value, 2, "Job title"),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: _salaryController,
                  labelText: 'Salary',
                  hintText: 'Example: 22000',
                  icon: AppIcons.paymentsOutlined,
                  keyboardType: TextInputType.number,
                  validator: (value) => Validators.validateSalary(value),
                ),
                const SizedBox(height: 16),
                CustomDropdownFormField<EmployeeDepartment>(
                  value: _selectedDepartment,
                  labelText: "Department",
                  icon: AppIcons.accountTreeOutlined,
                  items: EmployeeDepartment.values.map((dept) {
                    return DropdownMenuItem(
                      value: dept,
                      child: Text(dept.label),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedDepartment = value!);
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Mark as favorite'),
                  value: _isFavorite,
                  onChanged: (value) => setState(() => _isFavorite = value),
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  label: widget.isEditing ? "Save Employee" : "Add Employee",
                  onPressed: _submitForm,
                  icon: AppIcons.save,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(AppIcons.close),
                    label: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
