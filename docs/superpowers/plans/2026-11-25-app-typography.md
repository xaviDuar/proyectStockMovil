# App Typography Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Give the implemented Stock Móvil screens a clear two-font hierarchy: DotGothic16 for headings and Inter for readable body/UI text.

**Architecture:** Bundle both Google Fonts locally and expose their family names through `AppTheme`. Use the shared theme for body text and explicit heading styles for screen titles, preserving the current colors and layout while increasing undersized text.

**Tech Stack:** Flutter/Dart, local TTF assets, Material 3, Flutter widget/golden tests.

**Spec:** `docs/superpowers/specs/2026-11-25-typography-design.md`

## Global Constraints

- DotGothic16 is only for main titles and headings; Inter is for body text, subtitles, form controls, buttons, labels, and messages.
- Bundle fonts locally; no runtime font download or network requirement.
- Keep the existing dark theme, colors, navigation, and screen composition.
- Use body text around 14–16sp, supporting text around 12–14sp, and headings around 18–24sp, adjusted to fit the component.
- Keep the existing Workbench files; stop referencing them from the active theme.

## Review Focus

- Spanish punctuation and accented text render with the intended fonts — pin with title/body widget assertions and screen goldens.
- Body and heading roles do not accidentally use the same family — pin with theme and screen widget tests.
- Emphasized Inter text selects the declared weight instead of falling back — pin with theme font-weight assertions.
- Larger text does not clip on the 390×844 mobile layout — pin with login and Home goldens.
- Font assets are packaged for web without network access — verify `flutter build web` and the generated asset bundle.

---

### Task 1: Bundle fonts and define shared typography roles

**Files:**
- Create: `src/frontend/assets/fonts/DotGothic16-Regular.ttf`
- Create: `src/frontend/assets/fonts/Inter-Variable.ttf`
- Create: `src/frontend/assets/fonts/OFL-DotGothic16.txt`
- Create: `src/frontend/assets/fonts/OFL-Inter.txt`
- Modify: `src/frontend/pubspec.yaml`
- Modify: `src/frontend/lib/core/theme/app_theme.dart`
- Test: `src/frontend/test/app_theme_test.dart`

**Interfaces:**
- Produces `AppTheme.headingFontFamily == 'DotGothic16'` and `AppTheme.bodyFontFamily == 'Inter'`.
- `AppTheme.dark.fontFamily` is Inter; display/headline styles and AppBar title style use DotGothic16. Title/subtitle and body styles remain Inter.

- [ ] **Step 1: Write failing theme tests**

Add tests asserting that the global body family is Inter, headline and AppBar title families are DotGothic16, and Inter medium/bold weights are registered.

- [ ] **Step 2: Run the theme tests and confirm they fail** because the current theme declares Workbench and has no heading family.

Run: `flutter test test/app_theme_test.dart`

- [ ] **Step 3: Add the licensed local font files, register them, and resolve Flutter assets**

Use the official Google Fonts files; register the Inter variable font at weights 400, 500, 600, and 700, and DotGothic16 at its available regular weight. Preserve the existing Workbench files but remove their active font registration. Run `flutter pub get` from `src/frontend/`.

- [ ] **Step 4: Implement the two families in `AppTheme.dark`**

Set Inter as the global family, DotGothic16 on display/headline roles and AppBar titles, and preserve Inter on subtitle/title/body roles, along with the existing palette and component shapes.

- [ ] **Step 5: Run the theme tests and confirm they pass**

Run: `flutter test test/app_theme_test.dart`

---

### Task 2: Apply the hierarchy to screens and refresh visual references

**Files:**
- Modify: `src/frontend/lib/features/auth/presentation/login_screen.dart`
- Modify: `src/frontend/lib/features/home/presentation/home_screen.dart`
- Modify: `src/frontend/lib/features/home/presentation/proximamente_screen.dart`
- Create: `src/frontend/test/typography_test.dart`
- Modify: `src/frontend/test/pantallas_golden_test.dart`
- Modify: `src/frontend/test/goldens/login.png`
- Modify: `src/frontend/test/goldens/home.png`
- Modify: `docs/architecture/pantallas/login_screen.md`
- Modify: `docs/architecture/pantallas/home_screen.md`

**Interfaces:**
- Consumes the family names and theme roles from Task 1.
- Screen titles, section headings, and the login brand heading use DotGothic16; subtitle/body/control text uses Inter.

- [ ] **Step 1: Add failing screen assertions**

Assert that the login brand title and Home screen/section titles use DotGothic16, while login subtitle and representative body text use Inter.

- [ ] **Step 2: Run the screen typography tests and confirm they fail** against the current inline styles.

Run: `flutter test test/typography_test.dart`

- [ ] **Step 3: Apply heading and body roles to the three implemented screen files**

Use DotGothic16 only for primary/section headings; keep subtitles and all reading/control text in Inter. Raise currently tiny sizes to the spec's mobile-readable ranges without changing screen composition.

- [ ] **Step 4: Run the screen typography tests and confirm they pass**

Run: `flutter test test/typography_test.dart`

- [ ] **Step 5: Load local fonts in the visual tests, then regenerate and verify login/Home goldens**

Load DotGothic16 and Inter with `FontLoader` before rendering; Flutter widget tests otherwise use their fallback test font. Run `flutter test test/pantallas_golden_test.dart --update-goldens`, then rerun `flutter test test/pantallas_golden_test.dart` without the update flag.

- [ ] **Step 6: Update the screen widget documentation**

Record the font family used for headings and body text in each screen's existing Markdown documentation.

- [ ] **Step 7: Run full verification**

Run `flutter test`, `flutter analyze`, and `flutter build web` from `src/frontend/`; all must exit successfully.
