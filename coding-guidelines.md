# 🌍 1) Translation Structure & Guidelines

This document outlines how translations are organized in this project and provides best practices for managing multi-language support in a modular and scalable way.

---

## 📦 Structure Overview

We follow a **context-based (functional)** translation structure. Instead of grouping all translations in a single file, we separate them based on their functional or UI context.

```
lang/
├── de/
│   ├── common.php
│   ├── auth.php
│   ├── validation.php
│   ├── messages.php
│   ├── emails/
│   │   ├── welcome.php
│   │   └── reset_password.php
│   ├── dashboards/
│   │   ├── admin.php
│   │   └── user.php
│   ├── entities/
│   │   ├── users.php
│   │   ├── clients.php
│   │   └── services.php
│   ├── filament/
│   │   ├── auth.php
│   │   ├── navigation.php
│   │   └── resources/
│   │       ├── users.php
│   │       └── posts.php
│   └── api/
│       ├── responses.php
│       └── validation.php
```

---

## ✅ Why this structure?

| Benefit             | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| **Modular**         | Easy to manage and maintain translations per domain or UI section.          |
| **Scalable**        | Can grow with the app (SaaS, admin/user panels, API, emails, etc.).         |
| **Team-friendly**   | Teams can work on translations independently within their modules.          |
| **Context-aware**   | Different translations per interface or target audience are possible.       |
| **Cleaner syntax**  | Avoids bloated translation files by logically separating entries.           |

---

## 🧩 When to Split

Use separate files/folders for:

- `common.php`: Reusable terms like `save`, `cancel`, `yes`, `no`, etc.
- `entities/`: Domain-specific model terms (users, posts, services).
- `dashboards/`: Admin vs user interface language.
- `emails/`: Email templates' language and messaging.
- `filament/`: Filament-specific UI and resource translations.
- `api/`: REST API messages and validation.
- `auth.php`, `validation.php`: Built-in Laravel areas.

---

## 📘 Translation Key Naming

Use **dot notation** with file structure mapping:

```php
__('common.save')
__('entities.users.name')
__('emails.welcome.subject')
__('filament.resources.users.form.name')
```

Avoid short or unclear keys like:

```php
// ❌ Not recommended
__('a.l')
```

Use descriptive keys that reflect their purpose and source.

---

## 🔁 Reusing Keys (Avoid Duplication)

When you need to reuse a translation key across files or contexts, **reference the original key** instead of duplicating the string:

```php
// Instead of duplicating:
'name' => 'Name',

// Use:
'name' => __('entities.users.name'),
```

This ensures consistency across the system and reduces translation maintenance overhead.

---

## ⚠️ Best Practices

- ❌ Do **not** mix unrelated translations in the same file.
- ✅ Keep each file focused on its purpose (auth, user interface, API, etc).
- 🗂 Use folders to organize large sections (filament/resources, dashboards, emails...).
- 🧠 Follow the same structure across all languages (`de`, `en`, `ar`, etc).
- 📁 Store all language files under `/lang/{locale}/...`.

---

## 🔄 Fallback Behavior

Laravel will first look for the key in the current locale (`de`), and fall back to the default locale (`en`) if missing.

---

## 🚀 Example Usage in Blade & PHP

```blade
@lang('common.save')
{{ __('entities.users.email') }}
{{ __('filament.resources.clients.table.created_at') }}
```

---

## 🛠 Tools for Translation Workflow (Optional)

- `Laravel Translation Manager`
- `Poedit` / `PhraseApp` for UI-based translation
- Custom Artisan commands to sync/export translation files

---

## 📂 Suggested File Naming Conventions

- Lowercase, snake_case: `reset_password.php`, `user_dashboard.php`
- File name matches function/module name
- Folder matches UI or domain (e.g., `filament/resources`, `emails`)

---

## 📌 Final Tip

> Choose clarity, modularity, and reusability. This structure will help your project grow smoothly with less confusion and more developer happiness.


## 2) 🛠 Filament Resource Guidelines

### 📦 Folder Structure
- Traits for fields and tables should contain only individual elements for forms, tables, actions, and filters.
- Extra features should be defined in a separate trait (e.g., `HasEntityFeatures.php`).
- RelationManagers and Widgets should be placed in separate folders inside the `EntityResource` folder.

### 🧩 Resource File Organization
- Group and organize tabs directly in the resource file for better overview.
- Always use translation variables for singular and plural naming methods.

### 🛠 Helper Files
- Place global forms, fields, columns, actions, and filters in the `Helper` folder.

### ✅ Validation
- Use `Request` classes for `beforeSave` and `beforeStore` validation of data.

### 🔄 Column Visibility
- Use `->toggleable(isToggledHiddenByDefault: true)` for columns that are not highly relevant.