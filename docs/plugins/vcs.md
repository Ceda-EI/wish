# Version Control System (Git)

Provides the state of the git repository in the current directory.

## Features

- Notifies if there are any untracked symbols
- Name of the current branch
- Amount of changes (additions/subtractions)

## Add to wish

```ini
[plugin]
name = vcs
```

## Config options

| Key                  | Meaning                                                         | Default |
|----------------------|-----------------------------------------------------------------|---------|
| git_symbol           | Symbol to indicate that the current directory is a git repo.    |        |
| default              | Symbol to display when the current directory is not a git repo. | $       |
| git_untracked_symbol | Symbol to show if the current git repo has untracked files.     | ●       |
