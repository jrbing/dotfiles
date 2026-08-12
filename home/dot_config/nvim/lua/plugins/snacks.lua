-- Skip the LazyVim startup menu (snacks dashboard)
return {
  {
    "snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },
}
