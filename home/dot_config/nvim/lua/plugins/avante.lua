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
      { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
      "folke/snacks.nvim",
      "nvim-mini/mini.icons",
      "MeanderingProgrammer/render-markdown.nvim",
      {
        "zbirenbaum/copilot.lua",
        version = "v2.0.4", -- Avante requires the pre-v3 apps.json credential format.
        build = "mkdir -p copilot",
        opts = { server = { type = "binary" } },
      },
    },
    opts = {
      provider = "copilot",
      providers = {
        -- Avante's default (gpt-4o-2024-11-20) is a legacy model hidden from
        -- Copilot's picker. Switch at runtime with :AvanteModels.
        copilot = { model = "claude-sonnet-5.5" },
      },
    },
  },
}
