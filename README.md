# dotconf

**dotconf** is a simple script to organize your dotfiles and configs.  
It supports copying files/folders and cloning git repositories to custom locations using an easy configuration file.

## Features

- Pull config files and directories to a project folder
- Push files and directories back to their original locations
- Clone remote git repositories to anywhere you want
- Protocol-aware `dotlist` configuration

## Usage

1. **Edit your `dotlist` file**  
   Use the following format:
   ```
   protocol|source|destination
   ```
   - For files and directories:
     ```
     file|$HOME/.tmux.conf
     file|$CONFIG/nvim/init.vim
     ```
     (`destination` is not needed for files)
   - For git repositories:
     ```
     git|https://github.com/tmux-plugins/tpm.git|$HOME/TMP
     ```

   You can use variables like `$HOME` or `$CONFIG` in your paths.

2. **Run the script**
   | Action  | What it does                                                  |
   |---------|--------------------------------------------------------------|
   | pull    | Copies listed files/dirs from system config to project folder |
   | push    | Copies from project folder back to their original locations. Clones git repos to destination |
   | add     | Adds a new entry to dotlist                                   |

   Examples:
   ```sh
   ./dotconf.sh pull
   ./dotconf.sh push
   ./dotconf.sh add file $HOME/.vimrc
   ./dotconf.sh add git https://github.com/your/repo.git $HOME/myrepo
   ```

## dotlist Example

```
file|$HOME/.bashrc
file|$CONFIG/nvim
git|https://github.com/tmux-plugins/tpm.git|$HOME/TMP
```

## Requirements

- Bash
- Git

## Notes

- `$CONFIG` defaults to `$HOME/.config` if not set.
- The script will automatically create missing directories for file destinations.
- Comment lines in `dotlist` by starting with `#`.

---

**Organize your configs and dotfiles with ease!**
