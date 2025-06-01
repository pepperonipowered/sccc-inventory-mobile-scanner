import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sccc_v3/common/bloc/button/button_state_cubit.dart';
import 'package:sccc_v3/core/routes/app_router.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_cubit.dart';
import 'package:sccc_v3/feat/auth/presentation/bloc/auth_states.dart';
import 'package:sccc_v3/feat/borrow_list/presentation/cubit/local_item_list_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/category_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_details_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/equipment_list_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_cubit.dart';
import 'package:sccc_v3/feat/item_list/presentation/cubit/supply_list_cubit.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class SCCCApp extends StatelessWidget {
  const SCCCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Add your Bloc providers here
        BlocProvider(create: (create) => ButtonStateCubit()),
        BlocProvider(create: (create) => AuthCubit()..checkAuth()),
        BlocProvider(create: (create) => SupplyListCubit()),
        BlocProvider(create: (create) => SupplyCubit()),
        BlocProvider(create: (create) => EquipmentListCubit()),
        BlocProvider(create: (create) => EquipmentDetailsCubit()),
        BlocProvider(create: (create) => CategoryCubit()..loadCategories()),
        BlocProvider(create: (create) => LocalItemListCubit()..loadLocalItems()),
      ],
      child: BlocBuilder<AuthCubit, AuthStates>(
        builder: (context, state) {
          final authCubit = context.read<AuthCubit>();
          return MaterialApp.router(
            title: 'Smart City Command Center Inventory Scanner',
            theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(35, 137, 67, 1))),
            routerConfig: AppRouter.getRouter(authCubit),
            scaffoldMessengerKey: rootScaffoldMessengerKey,
          );
        },
      ),
    );
  }
}
