# Digital Journal

A Flutter App acting as a digital journal that is powered by AI.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Additionally, we use [Riverpod](https://riverpod.dev/de/) as the state management library.

There is a REST backend component which provides the connection to the OpenAI API.

## Setup

Create an `.env` file in the root directory. It should contain:
| Variable         | Description                                    |
| ---------------- | ---------------------------------------------- |
| BACKEND_URL      | URL pointing to the Backend of the application |
