-- avante.nvim: AI coding sidebar.
--
-- Auth: the API key is read out of the macOS Keychain at request time via the
-- `cmd:` prefix, so it never lands in this repo, never lands in .zshrc, and
-- works regardless of how Neovide was launched (a GUI launch does not inherit
-- the shell environment). Add the key once with:
--
--   security add-generic-password -s ANTHROPIC_API_KEY -a "$USER" -w
--
-- build = "make" compiles the four Rust cdylibs from source with cargo. The
-- alternative (bash build.sh) downloads a prebuilt tarball from GitHub
-- releases, which can be missing for a given tag; building is slower but
-- cannot fail that way on a fresh machine.
return {
  {
    "avante-corp/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "folke/snacks.nvim",
      "echasnovski/mini.icons",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          auth_type = "api",
          model = "claude-sonnet-5",
          api_key_name = "cmd:security find-generic-password -s ANTHROPIC_API_KEY -w",
        },
      },
    },
  },
}
