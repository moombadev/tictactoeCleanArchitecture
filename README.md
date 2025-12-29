# 🎮 Tic Tac Toe - Flutter

Un jeu de Tic Tac Toe moderne et élégant développé avec Flutter

## 📋 Table des matières

- [À propos](#-à-propos)
- [Fonctionnalités](#-fonctionnalités)
- [Architecture](#-architecture)
- [Technologies](#-technologies)
- [Prérequis](#-prérequis)
- [Installation](#-installation)
- [Utilisation](#-utilisation)
- [Structure du projet](#-structure-du-projet)
- [Tests](#-tests)
- [Contribution](#-contribution)
- [Licence](#-licence)

## 🎯 À propos
Ce projet est une implémentation  d'un jeu de Tic Tac Toe (Morpion) développé avec Flutter. L'objectif principal est de démontrer une maîtrise approfondie de Flutter à travers :

- Une architecture propre et scalable (Clean Architecture)
- L'utilisation des meilleures pratiques et outils modernes
- Un code maintenable et testable
- Une interface utilisateur moderne et fluide

## ✨ Fonctionnalités

- 🎮 **Jeu classique de Tic Tac Toe** : Grille 3x3 interactive
- 👥 **Mode deux joueurs** : Jouez contre un ami
- 💾 **Sauvegarde automatique** : La partie en cours est sauvegardée automatiquement
- 🎨 **Design moderne** : Interface utilisateur élégante avec animations fluides
- 🔊 **Effets sonores** : Sons pour les actions du jeu
- 🌍 **Internationalisation** : Support du français et de l'anglais
- 📱 **Responsive** : Design adaptatif pour différentes tailles d'écran

## 🏗️ Architecture

Le projet suit les principes de **Clean Architecture** avec une séparation claire des responsabilités :

```
lib/
├── core/                    # Fichiers partagés
│   ├── routing/             # Configuration GoRouter
│   ├── ui/
│   │   └── design_system/   # Design system (theme, colors, buttons)
│   ├── services/            # Services partagés
│   └── constants/           # Constantes partagées
├── features/                # Features organisées par domaine
│   ├── home/                # Feature d'accueil
│   │   └── presentation/
│   └── game/                # Feature de jeu
│       ├── data/            # Couche données (repositories, data sources)
│       ├── domain/          # Couche domaine (entities, use cases)
│       └── presentation/     # Couche présentation (widgets, providers)
└── main.dart
```

### Principes architecturaux

- **Séparation des couches** : Data, Domain, Presentation
- **Feature-driven development** : Organisation par features
- **Dependency Injection** : Via Riverpod avec code generation
- **Use Cases** : Logique métier isolée et testable
- **Repository Pattern** : Abstraction de la persistance

## 🛠️ Technologies

### Framework & Langage
- **Flutter** : 3.27.0+
- **Dart** : 3.7.0+ avec null safety

### State Management
- **Riverpod V2** avec code generation (`riverpod_generator`)
- Dependency injection via code generation

### Navigation
- **GoRouter** avec type-safe routing et code generation

### Code Generation
- `build_runner` : Génération de code
- `freezed` : Unions, classes immutables
- `json_serializable` : Sérialisation JSON automatique
- `riverpod_generator` : Génération des providers

### Persistance
- **SharedPreferences** : Stockage local avec abstraction

### Internationalisation
- `flutter_localizations` et `intl`
- Support français et anglais

### Audio
- `audioplayers` : Gestion des effets sonores

## 📦 Prérequis

Avant de commencer, assurez-vous d'avoir installé :

- **Flutter SDK** : Version 3.27.0 ou supérieure
- **Dart SDK** : Version 3.7.0 ou supérieure
- Un éditeur de code (VS Code, Android Studio, etc.)
- Un émulateur ou un appareil physique pour tester

## 🚀 Installation

1. **Cloner le repository**
   ```bash
   git clone https://github.com/votre-username/tic_tac_toe.git
   cd tic_tac_toe
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Générer le code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Lancer l'application**
   ```bash
   flutter run
   ```

## 💻 Utilisation

### Démarrage rapide

1. Lancez l'application
2. Sur la page d'accueil, cliquez sur "Start"
3. Choisissez votre côté (X ou O)
4. Commencez à jouer !

### Fonctionnalités du jeu

- **Jouer un coup** : Cliquez sur une case vide de la grille
- **Recommencer** : Utilisez le bouton "Recommencer" pour réinitialiser la partie
- **Sauvegarde automatique** : Votre partie est automatiquement sauvegardée

## 📁 Structure du projet

```
lib/
├── core/
│   ├── constants/          # Constantes partagées
│   ├── routing/            # Configuration GoRouter
│   ├── services/           # Services partagés (audio, shared preferences)
│   └── ui/
│       └── design_system/ # Design system (theme, colors, buttons, text styles)
│
├── features/
│   ├── home/
│   │   └── presentation/
│   │       └── pages/      # HomePage, ChooseSidePage
│   │
│   └── game/
│       ├── data/
│       │   └── repositories/ # Implémentation des repositories
│       ├── domain/
│       │   ├── entities/      # Game, Player, GameState, etc.
│       │   ├── exceptions/    # Exceptions métier
│       │   ├── repositories/  # Interfaces des repositories
│       │   ├── services/      # Services du domaine (GameServices)
│       │   └── use_cases/     # Use cases métier
│       └── presentation/
│           ├── pages/         # BoardGamePage
│           ├── providers/     # Controllers Riverpod
│           └── widgets/       # Widgets réutilisables
│
├── l10n/                    # Fichiers de localisation
└── main.dart                # Point d'entrée de l'application
```

## 🧪 Tests

Le projet inclut des tests pour garantir la qualité du code :

### Exécuter les tests

```bash
flutter test
```

### Tests disponibles

- ✅ **Tests des services du domaine** : Tests complets pour `GameServices`
  - Vérification de la logique du jeu (victoire, match nul, etc.)
  - Tests pour toutes les fonctions utilitaires

### Structure des tests

```
test/
└── features/
    └── game/
        └── domain/
            └── services/
                └── game_services_test.dart
```

## 🎨 Design System

Le projet utilise un design system personnalisé avec un style moderne :

- **AppColors** : Palette de couleurs cohérente
- **AppTextStyles** : Styles de texte réutilisables
- **AppButton** : Composant bouton personnalisé
- **AppTheme** : Thème Material 3 configuré

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez une branche pour votre feature (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

### Standards de code

- Suivre les conventions Dart/Flutter
- Utiliser Clean Architecture
- Écrire des tests pour les nouvelles fonctionnalités
- Documenter le code complexe



---

⭐ Si ce projet vous a été utile, n'hésitez pas à lui donner une étoile !
