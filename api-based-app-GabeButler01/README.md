[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/TZiuL-as)
# api-based-app

Use a 3rd Party API with Authentication

## Required

* API needs a developer account to use a private API key
* Must add `*.xcconfig` to your `.gitconfig` file
* Secrets must be stored ONLY EVER in a `Secrets.xcconfig` file

## Use SwiftLint

Xcode -> File -> Add Package Dependencies -> paste into search `https://github.com/SimplyDanny/SwiftLintPlugins` -> Add Package

Click project file, click your app target, go to Build Phases tab, expand Run Build Tool Plug-ins, click +, add SwiftLint

If you are asked about enabling a macro then you should approve the request

Once you have created your Xcode project, move the SwiftLint file into your project folder, next to your Xcode project file

## Gitignore

I have already added a gitignore file for you, no other configuration should be needed