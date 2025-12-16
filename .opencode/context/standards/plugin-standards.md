# Plugin Standards

Standards for plugin configuration and management.

## Plugin Specification

```lua
return {
  "owner/repo",
  event = "VeryLazy",           -- Lazy-load trigger
  dependencies = {              -- Dependencies
    "dependency/repo",
  },
  keys = {                      -- Keybindings
    { "<leader>x", ":Command", desc = "Description" },
  },
  opts = {                      -- Options (passed to setup)
    option1 = true,
  },
  config = function(_, opts)    -- Setup function
    require("plugin").setup(opts)
  end,
}
```

## Lazy-Loading

- Heavy plugins: `event = "VeryLazy"`
- Language-specific: `ft = "python"`
- Command-triggered: `cmd = "CommandName"`
- Keybinding-triggered: `keys = {...}`

## Organization

- One plugin per file in `lua/plugins/`
- Or group related plugins in category file
- Clear, descriptive filenames

## Dependencies

- List all plugin dependencies
- Automatic loading guaranteed
- Version pinning with commit/tag when needed
