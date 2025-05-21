#!/bin/bash

mkdir -p lib/core/network
touch lib/core/network/api_client.dart
touch lib/core/network/offline_queue.dart

mkdir -p lib/core/local
touch lib/core/local/prefs_service.dart
touch lib/core/local/cache_storage.dart

mkdir -p lib/core/models
mkdir -p lib/core/utils

mkdir -p lib/features/scan/data
touch lib/features/scan/data/scan_repository_impl.dart
mkdir -p lib/features/scan/domain
touch lib/features/scan/domain/scan_repository.dart
mkdir -p lib/features/scan/presentation
touch lib/features/scan/presentation/scan_screen.dart

mkdir -p lib/features/basket/data
touch lib/features/basket/data/basket_local_ds.dart
touch lib/features/basket/data/basket_remote_ds.dart
mkdir -p lib/features/basket/domain
touch lib/features/basket/domain/basket_entity.dart
touch lib/features/basket/domain/basket_usecases.dart
touch lib/features/basket/domain/basket_repository.dart
mkdir -p lib/features/basket/presentation/widgets
touch lib/features/basket/presentation/defect_menu_screen.dart
touch lib/features/basket/presentation/basket_drawer.dart

mkdir -p lib/features/history/data
mkdir -p lib/features/history/domain
mkdir -p lib/features/history/presentation
touch lib/features/history/presentation/history_screen.dart

mkdir -p lib/features/settings

touch lib/providers.dart
touch lib/app_router.dart
touch lib/theme.dart
touch lib/main.dart

echo "✅ Структура проекта создана."
