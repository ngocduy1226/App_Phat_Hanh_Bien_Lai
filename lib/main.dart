import 'package:flutter/material.dart';
import 'package:myshop/ui/brand/add_brand_screen.dart';
import 'package:myshop/ui/brand/brand_manager.dart';
import 'package:myshop/ui/brand/edit_brand_screen.dart';
import 'package:myshop/ui/configuration/config_manager.dart';
import 'package:myshop/ui/configuration/edit_config.dart';
import 'ui/screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => BrandManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ConfigManager(),
        )
      ],
      child: MaterialApp(
          title: 'MyShop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
              secondary: Colors.deepOrange,
            ),
          ),
          home: const AppDrawer(),
          routes: {
            BrandScreen.routeName: (ctx) => const BrandScreen(),
            ConfigScreen.routeName: (ctx) => const ConfigScreen(),
            ResLeaseScreen.routeName: (ctx) => const ResLeaseScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == EditBrandScreen.routeName) {
              final brandId = settings.arguments as String?;
              return MaterialPageRoute(builder: (ctx) {
                return EditBrandScreen(
                  brandId != null
                      ? ctx.read<BrandManager>().findById(brandId)
                      : null,
                );
              });
            }

            if (settings.name == AddBrandScreen.routeName) {
              final brandId = settings.arguments as String?;
              return MaterialPageRoute(builder: (ctx) {
                return AddBrandScreen(
                  brandId != null
                      ? ctx.read<BrandManager>().findById(brandId)
                      : null,
                );
              });
            }

            if (settings.name == EditConfigScreen.routeName) {
              final configId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return EditConfigScreen(
                    configId != null
                        ? ctx.read<ConfigManager>().findById(configId)
                        : null,
                  );
                },
              );
            }

            return null;
          }),
    );
  }
}
