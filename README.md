# Dotfiles

My terminal-centric development environment: Ghostty, zsh, Neovim, and a few AI tools, all themed with Rosé Pine. I use it every day on a MacBook. My other computer runs Fedora, my Linux distro of choice, so the repository also includes an install script for it.

Each tool's configuration directory is a [GNU Stow](https://www.gnu.org/software/stow/) package, so a single `stow <name>` from `~/dotfiles` links that tool's config into `$HOME`.

> [!NOTE]
> This is my personal setup, tuned to my own workflow.
>
> Feel free to borrow anything, but read each config before stowing it instead of linking everything at once.

![Screenshot](assets/screenshot.png)

## What this sets up

| Area | Current choice |
|------|----------------|
| Dotfile management | GNU Stow, one package per tool |
| Terminal | Ghostty with transparency, blur, and custom cursor shaders |
| Shell and prompt | zsh with autosuggestions and syntax highlighting, Starship, and zoxide |
| Runtime versions and CLI tools | mise (Node.js, Python, Go, Terraform, pnpm, uv, AWS CLI) |
| Multiplexer | herdr |
| Editor | Neovim with LazyVim, plus Zed as a secondary editor |
| AI tools | Claude Code (via claudecode.nvim), Pi, and minuet-ai inline completion with DeepSeek |
| System info | fastfetch with a minimal module list |
| Fonts and color | Maple Mono and Rosé Pine |

## Ghostty cursor shaders

Ghostty draws an animated trail when the cursor moves. The shaders live in `ghostty/.config/ghostty/shaders/`:

| Shader | Effect |
|--------|--------|
| `cursor_personal.glsl` | **Active.** Trail in the Rosé Pine colors pine, iris, and love (0.2 s) |
| `cursor_blink.glsl` | Short trail in Rosé Pine foam and iris (0.1 s) |
| `cursor_starwars.glsl` | Cyan and blue trail (0.3 s) |
| `cursor_white.glsl` | Subtle, semi-transparent trail (0.1 s) |

To switch shaders, change this line in `ghostty/.config/ghostty/config` and reload Ghostty:

```ini
custom-shader = ./shaders/cursor_personal.glsl
```

Each file sets its duration in `DURATION`. The colors are in `TRAIL_COLOR`, or in the `colors` array in `cursor_personal.glsl`. The shaders are based on Inigo Quilez's [2D distance functions](https://iquilezles.org/articles/distfunctions2d/), and `cursor_personal.glsl` is a contribution by [PremModhaOfficial](https://github.com/PremModhaOfficial).

## Install

### 1. Clone the repository

```bash
git clone https://github.com/cristoge/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install the packages

**macOS** (requires [Homebrew](https://brew.sh)):

```bash
brew install git stow neovim starship zoxide fzf ripgrep fd lazygit eza mise fastfetch luarocks herdr
brew install --cask ghostty zed font-maple-mono claude-code
```

**Fedora**:

```bash
./script.sh
```

The script updates the system and installs the base CLI tools, Neovim, mise, lazygit, Ghostty, Starship, and Zed. It enables the `jdxcode/mise`, `dejan/lazygit`, and `scottames/ghostty` COPR repositories. Python tooling is managed through mise rather than pipx.

The Fedora script is not a complete equivalent of the Homebrew commands: zsh, fastfetch, herdr, Maple Mono, and Claude Code must be installed separately if needed.

### 3. Link the configs

```bash
stow zsh nvim ghostty starship herdr zed mise
```

Stow only the packages you need. It refuses to overwrite existing files, so back up or remove any previous config first.

### 4. Install the configured tool versions

[mise](https://mise.jdx.dev/) reads the versions from `mise/.config/mise/config.toml`, linked to `~/.config/mise/config.toml` by Stow. The current configuration selects Node.js 24, Python 3.15, Go 1.27, Terraform 1.17, and the latest pnpm, uv, and AWS CLI.

mise is installed in step 2 on both platforms: through Homebrew on macOS and the `jdxcode/mise` COPR repository on Fedora. Linking its config alone does not install the configured tool versions.

Once mise is available on your `PATH`, add this line to your `~/.zshrc` so it activates automatically in each new zsh session. The checked-in zsh config does not include it:

```bash
eval "$(mise activate zsh)"
```

Then reload your zsh configuration and install the configured tools:

```bash
source ~/.zshrc
mise install
```

### 5. Extra requirements

- **zsh plugins**: `.plugins.zsh` loads them from `~/.zsh/`, so clone them there:

  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
  ```

## Pi

The optional `pi` package configures [Pi](https://pi.dev/) with a fullscreen interface, Vim bindings, persistent memory through gentle-engram, goal and task management, and a usage bar. Its extension list lives in `pi/.pi/agent/settings.json`.

Pi is not installed by the package commands or Fedora script above. Install it separately using the [official instructions](https://pi.dev/), then link its configuration:

```bash
stow pi
```

Back up any existing `~/.pi/agent/` configuration before linking. This package includes settings, MCP servers, and usage-bar preferences, not credentials or session history.

### Requirements

- **mise and Node.js 24**: Pi's package commands use `mise exec node@24 -- npm`. Complete the mise setup above first.
- **`npx` on `PATH`**: the Context7 MCP server launches through `npx`. Activating mise makes the configured Node.js tools available to Pi.
- **GitHub CLI**: the GitHub MCP server obtains its token dynamically with `gh auth token`. Install `gh` (`brew install gh` on macOS or `sudo dnf install gh` on Fedora), then authenticate:

  ```bash
  gh auth login
  ```

The MCP configuration is in `pi/.pi/agent/mcp.json` and includes Context7 and GitHub. No GitHub token is stored in that file. Configure your AI provider separately inside Pi with `/login`.
