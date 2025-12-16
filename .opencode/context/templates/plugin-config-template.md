# Plugin Configuration Template

Template for lazy.nvim plugin specifications.

```lua
---{Plugin description}
---@see {documentation_url}
return {
  "{owner}/{repo}",
  
  -- Lazy-loading configuration
  event = "VeryLazy",  -- or cmd, ft, keys, lazy = true
  
  -- Dependencies
  dependencies = {
    "{dependency_repo}",
  },
  
  -- Keybindings (triggers lazy-load)
  keys = {
    { "<leader>x", ":Command<CR>", desc = "Description" },
  },
  
  -- Configuration options
  opts = {
    option1 = true,
    option2 = "value",
  },
  
  -- Setup function
  config = function(_, opts)
    require("{plugin}").setup(opts)
  end,
}
```
