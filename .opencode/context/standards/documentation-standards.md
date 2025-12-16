# Documentation Standards

Standards for NeoVim configuration documentation.

## File Documentation

Every module file should have:

1. **Header comment**: Purpose and overview
2. **Function docs**: For all public functions
3. **Usage examples**: For complex APIs
4. **References**: Links to external docs

## Function Documentation

```lua
---Brief description
---
---Longer explanation if needed
---
---@param param1 type Description
---@param param2 type Description
---@return type Description
M.function_name = function(param1, param2)
  -- implementation
end
```

## README Files

- Project overview
- Quick start guide
- Directory structure
- Configuration sections
- Troubleshooting

## Keybinding Documentation

- Document all leader key mappings
- Provide categorized reference
- Include mode and description
- Maintain up-to-date mapping table
