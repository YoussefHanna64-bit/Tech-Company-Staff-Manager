import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_manager/features/employee/domain/entities/employee.dart';
import 'package:staff_manager/features/employee/domain/repositories/employee_repository.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repo;

  EmployeeCubit({required this.repo}) : super(EmployeeLoading()) {
    loadEmployees();
  }

  Future<void> loadEmployees() async {
    emit(EmployeeLoading());
    try {
      final employees = await repo.getEmployees();
      emit(EmployeeLoaded(employees: employees));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      emit(EmployeeError(message: errorMessage));
    }
  }

  Future<void> addEmployee(Employee employee) async {
    try {
      await repo.addEmployee(employee);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(message: "Failed to add employee: $e"));
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      await repo.updateEmployee(employee);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(message: "Failed to update employee: $e"));
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      await repo.deleteEmployee(id);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(message: "Failed to delete employee: $e"));
    }
  }

  Future<void> toggleFavorite(Employee employee) async {
    try {
      await repo.toggleFavorite(employee);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(message: "Failed to update favorite status: $e"));
    }
  }
}
