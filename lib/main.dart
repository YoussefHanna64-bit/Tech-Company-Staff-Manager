import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staff_manager/core/network/dio_client.dart';
import 'package:staff_manager/features/auth/presentation/pages/login_page.dart';
import 'package:staff_manager/features/employee/data/datasources/employee_local_data_source.dart';
import 'package:staff_manager/features/employee/data/datasources/employee_remote_data_source.dart';
import 'package:staff_manager/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:staff_manager/features/employee/domain/repositories/employee_repository.dart';
import 'package:staff_manager/features/employee/presentation/cubit/employee_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();

  final localDataSource = EmployeeLocalDataSource.instance;
  final remoteDataSource = EmployeeRemoteDataSource(dioClient: dioClient);

  final employeeRepository = EmployeeRepositoryImpl(
    localDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );

  runApp(StaffManagerApp(repository: employeeRepository));
}

class StaffManagerApp extends StatefulWidget {
  final EmployeeRepository repository;
  const StaffManagerApp({super.key, required this.repository});

  @override
  State<StaffManagerApp> createState() => _StaffManagerAppState();
}

class _StaffManagerAppState extends State<StaffManagerApp> {
  bool isDark = false;

  void toggleTheme(bool value) {
    setState(() {
      isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(repo: widget.repository),
      child: MaterialApp(
        title: 'Tech Company Portal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        home: LoginPage(
          isDark: isDark,
          onThemeChanged: toggleTheme,
        ),
      ),
    );
  }
}
