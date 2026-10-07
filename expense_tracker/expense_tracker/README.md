# expense_tracker

A Flutter expense tracker for the Lesson 5 (Interactivity & Theming) asynchronous activity. The structure follows the course's Expense Tracker snapshots (`lib/expenses.dart`, `models/`, `widgets/expenses_list/`, `widgets/chart/`), with my own additions on top.

## Lesson 5 features

- Expense model, dummy data, list view, icons, and formatted dates
- Modal bottom sheet with `TextField` + `TextEditingController`, date picker, and input validation
- Swipe-to-delete with `Dismissible` and an Undo snackbar
- `ExpenseBucket.forCategory` alternative constructor and a `Chart` built from `ChartBar` widgets
- Color scheme, text themes, theme data used inside widgets, and dark mode

## My customizations

- Custom teal, marigold, and berry palette
- Custom fonts: Sora (headings and numbers) and DM Sans (body) via `google_fonts`
- Category chips instead of a dropdown, with per-category icons and colors
- Animated peso total in the summary card and animated chart bars
- Light and dark mode toggle in the app bar
- Reusable `AppPanel` container, Philippine peso formatting
- Chart tooltips showing each category's total

## Setup

This folder has `lib/` and `pubspec.yaml` only. Generate the platform folders with:

```bash
cd expense_tracker
flutter create .
flutter pub get
flutter run
```

`flutter create .` adds a default `test/widget_test.dart` that references `MyApp` and will fail. Delete it (or rewrite it) before running `flutter test`.

## Project structure

```
lib/
  main.dart                        MaterialApp, themes, theme mode switching
  expenses.dart                    main Expenses widget (state, add/remove)
  models/expense.dart              Expense, Category, ExpenseBucket
  theme/app_theme.dart             palette, fonts, component themes
  utils/format.dart                peso formatter
  widgets/
    app_panel.dart                 reusable rounded container
    summary_card.dart              animated monthly total
    new_expense.dart               add-expense bottom sheet
    chart/chart.dart               builds buckets and bars
    chart/chart_bar.dart           one animated bar
    expenses_list/expenses_list.dart
    expenses_list/expense_item.dart
```

## Suggested Git milestones

Your history is reviewed, so build in stages and commit as you go. Here is a possible order (the last column is the matching course snapshot):

| Milestone | Files | Course step |
|---|---|---|
| Initial project setup | `flutter create .`, starter `main.dart`, `pubspec.yaml` | 01 |
| Expense data model | `models/expense.dart` (Expense, Category) | 02 to 03 |
| Expenses list UI | `widgets/expenses_list/*`, `utils/format.dart`, dummy data in `expenses.dart` | 04 to 06 |
| Add-expense modal | `widgets/new_expense.dart`, FAB in `expenses.dart` | 07 to 15 |
| Delete with undo | `Dismissible` and snackbar | 16 to 17 |
| Theme configuration | `theme/app_theme.dart`, `main.dart` themes | 18 to 21 |
| Chart | `ExpenseBucket`, `widgets/chart/*` | 22 to 24 |
| UI redesign | `app_panel.dart`, `summary_card.dart`, animations | my own |
| Final testing and polish | bug fixes, README | my own |

Example commands:

```bash
git init
git branch -M main
git remote add origin <your-repo-url>
git add . && git commit -m "Initial project setup"
git push -u origin main
# ...then one commit per milestone:
git add lib/models && git commit -m "Add Expense model and categories"
git push
```

Push everything to the same repository you submit, before 3:00 PM on September 30.
