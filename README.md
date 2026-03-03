# Dartpedia

Browse Wikipedia from your terminal with zero upstream dependencies other than core Dart.

## Project Structure

This project is a Dart monorepo managed with [Melos](https://melos.invertase.dev/).

### Applications
- `apps/cli`: The main command-line interface for Dartpedia.

### Packages
- `packages/arg_parse`: A custom library for parsing command-line arguments and commands.
- `packages/console`: Terminal UI utilities for rich console output (cards, lists, text styling).
- `packages/wikipedia`: A wrapper around the Wikipedia REST API.

## Getting Started

### Prerequisites
- [Dart SDK](https://dart.dev/get-dart)
- [Melos](https://melos.invertase.dev/getting-started#installation) (`dart pub global activate melos`)

### Setup
1. Clone the repository.
2. Run `melos bootstrap` to install dependencies and link packages.

### Installation
You can install the CLI directly from source:

#### From Local Source
```bash
dart pub global activate --source path apps/cli
```

#### From GitHub
```bash
dart pub global activate --source git https://github.com/benexl/dartpedia --git-path apps/cli
```

## Features
- **Search:** Search for articles on Wikipedia in different languages.
- **Cache:** Manage local cache of viewed articles.
- **Themes:** Customizable console output themes.
- **Configuration:** Persistent user settings stored in `~/.dartpedia/config.yaml`.
- **Shell Completions:** Native completion scripts for Bash, Zsh, and Fish.
