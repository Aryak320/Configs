# Lua Coding Standards

Extracted from `/home/benjamin/.config/STANDARDS.md`.

## Naming Conventions

- **Files**: snake_case (e.g., `plugin_name.lua`)
- **Functions**: snake_case (e.g., `setup_keybindings()`)
- **Variables**: snake_case (e.g., `local buffer_id`)
- **Constants**: SCREAMING_SNAKE_CASE (e.g., `local MAX_RETRIES = 3`)
- **Modules**: snake_case matching filename

## Module Pattern

```lua
local M = {}

-- Private functions (local)
local function private_helper()
  -- implementation
end

-- Public functions (on M table)
M.public_function = function()
  -- implementation
end

return M
```

## Documentation

- Module-level doc comment at top
- Function doc comments with @param, @return
- Inline comments for complex logic

```lua
---Setup plugin configuration
---@param opts table Configuration options
---@return boolean success Whether setup succeeded
M.setup = function(opts)
  -- implementation
end
```

## Error Handling

- Use pcall for risky operations
- Validate function inputs
- Return meaningful error messages

```lua
local ok, result = pcall(function()
  -- risky operation
end)
if not ok then
  vim.notify("Error: " .. result, vim.log.levels.ERROR)
  return false
end
```
