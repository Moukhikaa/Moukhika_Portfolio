# Gorji Moukhika Portfolio

A responsive Flutter Web portfolio personalized from the original Polymorphism template for Gorji Moukhika.

## Highlights

- Resume-backed profile content
- Personal hero imagery and avatar assets
- Projects from the current resume
- Contact form with Moukhika's email fallback
- Links to LinkedIn, GitHub, CodeChef, LeetCode, portfolio, and resume

## Run Locally

```bash
flutter pub get
flutter run -d chrome
```

## Build

```bash
flutter build web --release
```

## Continuous Deployment

This project is configured for Vercel. After the project is pushed to GitHub,
connect the GitHub repository in Vercel. Every push to the main branch will
automatically rebuild and deploy the Flutter web portfolio.

Use these Vercel settings:

- Framework Preset: Other
- Root Directory: the folder that contains `pubspec.yaml`
- Build Command: already defined in `vercel.json`
- Output Directory: already defined as `build/web`
