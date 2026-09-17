-- avante.nvim: AI coding sidebar using a GitHub Copilot subscription.
-- Authenticate once with `:Copilot auth`.
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
      "nvim-mini/mini.icons",
      "MeanderingProgrammer/render-markdown.nvim",
      {
        "zbirenbaum/copilot.lua",
        version = "v2.0.4", -- Avante requires the pre-v3 apps.json credential format.
        opts = {},
      },
    },
    opts = {
      provider = "copilot",
    },
  },
}
