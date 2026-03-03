# dartpedia (CLI)

The main command-line interface for browsing Wikipedia from your terminal.

## Features
- **Search:** Search articles using the `search` command.
- **Cache Management:** List or clear cached articles with the `cache` command.
- **Theming:** Customize terminal output with built-in themes.
- **Logging:** Enable detailed logging for debugging.

## Installation

### From Local Source
Activate globally using `dart pub global activate`:
```bash
dart pub global activate --source path .
```

### From GitHub
```bash
dart pub global activate --source git https://github.com/benexl/dartpedia --git-path apps/cli
```

## Usage

```bash
# Basic search
dartpedia search "Dart"

# Search in a specific language
dartpedia search "Dart" --lang fr

# List cached articles
dartpedia cache list

# Clear cache
dartpedia cache clear

# Show help
dartpedia --help
```

## Configuration

Dartpedia uses a configuration file located at `~/.dartpedia/config.yaml`.
This file is automatically created on first run.

### Available Settings
- `theme`: Choose a visual theme (`arcticPetrol`, `electricSolarized`, `nordicFrost`, `wikipediaClassic`).
- `language`: Default language for searches (e.g., `en`, `fr`).

### Example `config.yaml`
```yaml
theme: wikipediaClassic
language: en
```

## Shell Completions

Shell completion scripts for Bash, Zsh, and Fish are available in the `completions/` directory.

### Bash
Add this to your `~/.bashrc`:
```bash
source path/to/dartpedia/completions/dartpedia.bash
```

### Zsh
Add the directory to your `$fpath` in `~/.zshrc`:
```zsh
fpath=(path/to/dartpedia/completions $fpath)
autoload -U compinit
compinit
```

### Fish
Copy the completion file to your fish configuration:
```fish
cp path/to/dartpedia/completions/dartpedia.fish ~/.config/fish/completions/
```

## Options
- `-v, --version`: Show version information.
- `-h, --help`: Show help.
- `-t, --theme`: Choose a theme (e.g., `wikipediaClassic`).
- `--log`: Enable logging to console.
- `-l, --loglevel`: Set the log level (all, fine, debug, info, warning, error).
