# Exit Code Smiley

Shows a happy/sad smiley face based on whether the last command ran successfully or not.


## Add to wish

```ini
[plugin]
name = exit_code_smiley
```

## Config options

| Key          | Meaning                                                      | Default |
|--------------|--------------------------------------------------------------|---------|
| pass         | Text to show when the last command ran successfully.         | :)      |
| fail         | Text to show when the last command failed.                   | :(      |
| hide_on_pass | Whether to hide the output if command executes successfully. | 0       |
