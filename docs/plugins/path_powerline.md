# Path Powerline

Shows the current path and whether it is writeable.

## Features

- Powerline symbols used as path separators.
- Long paths are shrunk down to allow for more space for other plugins.
	- e.g. `/usr/lib/systemd/system/` might get shortened to one of the
	  following based on config + screen width: `/u/l/s/system`,
	  `/u/l/systemd/system` or `/u/lib/systemd/system`
	- This is configurable and disabled by default (check `max_perc` config)
	- Recommended value for `max_perc` is `50`


## Add to wish

```ini
[plugin]
name = path
```

## Config options

| Key             | Meaning                                                      | Default      |
|-----------------|--------------------------------------------------------------|--------------|
| no_write_suffix | Suffix if the current path is not writeable.                 |             |
| max_perc        | Maximum percentage of screen width path should take. (0-100) | 0 (disabled) |
