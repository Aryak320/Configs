# OpenCode.nvim Hover Scrolling Research

**Date**: 2025-12-15
**Research Prompt**: Research opencode.nvim hover scrolling configuration and issues
**Researcher**: Claude (Anthropic AI Assistant)

---

## Executive Summary

OpenCode.nvim does not implement true "hover windows" - it displays the opencode TUI (Terminal User Interface) in a terminal buffer. The inability to scroll when the terminal doesn't have focus is a fundamental limitation of Neovim terminal buffers, not a bug in opencode.nvim. The recommended solution is to use the provided command API with keybindings.

---

## Key Findings

### 1. Architecture Understanding

**OpenCode.nvim Design Philosophy:**
- Uses opencode's TUI for simplicity (not a custom Neovim UI)
- Connects to opencode via RPC/MessagePack protocol
- Terminal provider renders the TUI in a Neovim terminal buffer
- Alternative: [sudo-tee/opencode.nvim](https://github.com/sudo-tee/opencode.nvim) implements a native Neovim frontend

**Terminal Provider Options:**
```lua
vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",  -- Default if available
    -- Alternatives:
    -- enabled = "terminal",  -- Neovim built-in
    -- enabled = "kitty",     -- External terminal
    -- enabled = "wezterm",   -- External terminal
    -- enabled = "tmux",      -- External terminal
  }
}
```

### 2. Available Scrolling Commands

OpenCode.nvim provides a command API for controlling the TUI:

| Command | Description |
|---------|-------------|
| `session.page.up` | Scroll up one page |
| `session.page.down` | Scroll down one page |
| `session.half.page.up` | Scroll up half page |
| `session.half.page.down` | Scroll down half page |
| `session.first` | Jump to first message |
| `session.last` | Jump to last message |

**Usage:**
```lua
require("opencode").command("session.half.page.up")
```

### 3. Root Cause Analysis

**Why scrolling doesn't work without focus:**

1. **Terminal Buffer Behavior**: Neovim terminal buffers require focus to receive input
2. **Input Routing**: Scroll commands must reach the opencode TUI process
3. **Window Scrolling Limitation**: Standard Neovim window scrolling (`<C-u>`, `<C-d>`) doesn't work on terminal buffers when unfocused

This is **not a bug** - it's how Neovim terminal buffers are designed to work.

### 4. Snacks.nvim Integration

**Current Status:**
- No specific configuration found for scrolling unfocused terminal windows
- Snacks.nvim terminal provider follows standard Neovim terminal behavior
- No documented workarounds in snacks.nvim for this limitation

**Snacks Terminal Configuration:**
```lua
{
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = {
        -- Window configuration options
        -- No scrolling-without-focus options available
      }
    }
  }
}
```

---

## Configuration Recommendations

### Solution 1: Use Command API with Keybindings (Recommended)

**Implementation:**
```lua
-- Add to your opencode.nvim configuration
vim.keymap.set("n", "<leader>ok", function() 
  require("opencode").command("session.half.page.up") 
end, { desc = "OpenCode scroll up" })

vim.keymap.set("n", "<leader>oj", function() 
  require("opencode").command("session.half.page.down") 
end, { desc = "OpenCode scroll down" })

-- Full page scrolling
vim.keymap.set("n", "<leader>oK", function() 
  require("opencode").command("session.page.up") 
end, { desc = "OpenCode page up" })

vim.keymap.set("n", "<leader>oJ", function() 
  require("opencode").command("session.page.down") 
end, { desc = "OpenCode page down" })

-- Jump to boundaries
vim.keymap.set("n", "<leader>og", function() 
  require("opencode").command("session.first") 
end, { desc = "OpenCode jump to first" })

vim.keymap.set("n", "<leader>oG", function() 
  require("opencode").command("session.last") 
end, { desc = "OpenCode jump to last" })
```

**Advantages:**
- Works from any window
- No focus switching required
- Uses official API
- Reliable and maintainable

### Solution 2: Quick Focus Switching

**Implementation:**
```lua
-- Jump to opencode window for manual scrolling
vim.keymap.set("n", "<leader>of", function()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match("term://") and bufname:match("opencode") then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.notify("OpenCode window not found", vim.log.levels.WARN)
end, { desc = "Focus OpenCode terminal" })

-- Return to previous window
vim.keymap.set("n", "<leader>op", "<C-w>p", { desc = "Return to previous window" })
```

**Workflow:**
1. Press `<leader>of` to focus opencode window
2. Use standard Neovim scrolling (`<C-u>`, `<C-d>`, etc.)
3. Press `<leader>op` to return to previous window

### Solution 3: External Terminal Provider

**Implementation:**
```lua
vim.g.opencode_opts = {
  provider = {
    enabled = "terminal",  -- Use Neovim built-in
    -- OR for external terminals with independent scrolling:
    -- enabled = "kitty",
    -- enabled = "wezterm",
    -- enabled = "tmux",
  }
}
```

**Advantages:**
- External terminals have native scrollback
- Independent window management
- May support scrolling without focus (terminal-dependent)

**Disadvantages:**
- Requires external terminal emulator
- Less integrated with Neovim
- Additional configuration needed

### Solution 4: Window Layout Optimization

**Implementation:**
```lua
-- Configure opencode to open in a specific layout
vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",
    snacks = {
      win = {
        position = "right",  -- or "bottom", "left", "top"
        width = 0.4,         -- 40% of screen width
        height = 0.6,        -- 60% of screen height
      }
    }
  }
}
```

**Workflow:**
- Keep opencode visible in a split
- Use keybindings to scroll without switching focus
- Maintain visibility of both code and AI responses

---

## Keybinding Suggestions

### Comprehensive Keybinding Set

```lua
-- OpenCode scrolling (works from any window)
vim.keymap.set("n", "<leader>ok", function() 
  require("opencode").command("session.half.page.up") 
end, { desc = "OpenCode scroll up" })

vim.keymap.set("n", "<leader>oj", function() 
  require("opencode").command("session.half.page.down") 
end, { desc = "OpenCode scroll down" })

vim.keymap.set("n", "<leader>oK", function() 
  require("opencode").command("session.page.up") 
end, { desc = "OpenCode page up" })

vim.keymap.set("n", "<leader>oJ", function() 
  require("opencode").command("session.page.down") 
end, { desc = "OpenCode page down" })

vim.keymap.set("n", "<leader>og", function() 
  require("opencode").command("session.first") 
end, { desc = "OpenCode jump to top" })

vim.keymap.set("n", "<leader>oG", function() 
  require("opencode").command("session.last") 
end, { desc = "OpenCode jump to bottom" })

-- Window management
vim.keymap.set("n", "<leader>of", function()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if bufname:match("term://") and bufname:match("opencode") then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.notify("OpenCode window not found", vim.log.levels.WARN)
end, { desc = "Focus OpenCode window" })

-- Alternative: Use Shift+Ctrl for scrolling (like README examples)
vim.keymap.set("n", "<S-C-u>", function() 
  require("opencode").command("session.half.page.up") 
end, { desc = "OpenCode half page up" })

vim.keymap.set("n", "<S-C-d>", function() 
  require("opencode").command("session.half.page.down") 
end, { desc = "OpenCode half page down" })
```

---

## Known Issues

### Issue 1: Terminal Buffer Focus Requirement

**Status**: Not a bug - expected behavior
**Impact**: Cannot scroll terminal without focus using standard Neovim commands
**Workaround**: Use command API with keybindings (Solution 1)

### Issue 2: No GitHub Issues Found

**Search Results**: No open issues for "hover scroll" or "scrolling without focus"
**Implication**: This is either:
- Not commonly reported (users find workarounds)
- Understood as expected terminal behavior
- Not considered a priority feature

### Issue 3: Snacks.nvim Terminal Limitations

**Status**: No configuration options for unfocused scrolling
**Impact**: Snacks terminal provider follows standard Neovim terminal behavior
**Alternative**: Try external terminal providers (kitty, wezterm, tmux)

---

## Best Practices

### 1. Workflow Optimization

**Recommended Setup:**
```lua
-- Keep opencode visible in a split
vim.g.opencode_opts = {
  provider = {
    enabled = "snacks",
    snacks = {
      win = {
        position = "right",
        width = 0.4,
      }
    }
  }
}

-- Use keybindings for scrolling
-- (See "Comprehensive Keybinding Set" above)
```

**Workflow:**
1. Open opencode in a split (visible while coding)
2. Use `<leader>ok`/`<leader>oj` to scroll from any window
3. Focus opencode window only when needed for interaction

### 2. Keybinding Strategy

**Option A: Leader-based (Recommended)**
- `<leader>ok` - Scroll up
- `<leader>oj` - Scroll down
- Mnemonic: "o" for opencode, "k/j" for up/down

**Option B: Shift+Ctrl (README Style)**
- `<S-C-u>` - Scroll up
- `<S-C-d>` - Scroll down
- Familiar to Vim users (similar to `<C-u>`/`<C-d>`)

**Option C: Custom Prefix**
- `<C-o>k` - Scroll up
- `<C-o>j` - Scroll down
- Quick access without leader key

### 3. Terminal Provider Selection

**Decision Matrix:**

| Provider | Pros | Cons | Use When |
|----------|------|------|----------|
| `snacks` | Integrated, feature-rich | Standard terminal limitations | Default choice |
| `terminal` | Built-in, no dependencies | Basic features | Minimal setup |
| `kitty` | Native scrollback, GPU-accelerated | Requires kitty terminal | Using kitty |
| `wezterm` | Cross-platform, configurable | Requires wezterm | Using wezterm |
| `tmux` | Session persistence | Requires tmux | Using tmux |

---

## Next Steps for Investigation

### 1. Verify Current Configuration

```lua
-- Check current provider
:lua print(vim.inspect(vim.g.opencode_opts.provider))

-- Check if opencode is running
:lua print(vim.inspect(require("opencode").get_status()))
```

### 2. Test Different Providers

```lua
-- Try built-in terminal
vim.g.opencode_opts = {
  provider = { enabled = "terminal" }
}

-- Restart Neovim and test scrolling behavior
```

### 3. Monitor for Updates

- Watch opencode.nvim repository for new features
- Check snacks.nvim for terminal enhancements
- Review Neovim core for terminal buffer improvements

### 4. Consider Filing Feature Request

**If this is a critical workflow issue:**

**Title**: "Support scrolling opencode output when window doesn't have focus"

**Description**:
```
**Use Case**: Reading AI responses while editing code

**Current Behavior**: Must focus terminal window to scroll

**Desired Behavior**: Scroll opencode output from any window

**Suggested Implementation**:
- Add configuration option for "scroll-without-focus"
- Implement window-aware scrolling commands
- Or document recommended keybinding patterns
```

---

## Alternative Solutions

### Option 1: Use sudo-tee/opencode.nvim

**Repository**: https://github.com/sudo-tee/opencode.nvim

**Advantages:**
- Native Neovim frontend (no TUI)
- Full control over UI rendering
- May support custom scrolling behavior

**Disadvantages:**
- Different plugin (migration required)
- May have different feature set
- Less mature than NickvanDyke/opencode.nvim

### Option 2: Custom Floating Window

**Concept**: Create a custom floating window that displays opencode output

**Implementation Sketch:**
```lua
-- Capture opencode output and display in floating window
local function create_opencode_viewer()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = 80,
    height = 20,
    col = 10,
    row = 10,
    style = "minimal",
    border = "rounded",
  })
  
  -- Populate buffer with opencode output
  -- (Would require custom integration)
end
```

**Feasibility**: Low - would require significant custom development

---

## Sources and References

### Primary Documentation

1. **OpenCode.nvim README**
   - URL: https://github.com/NickvanDyke/opencode.nvim
   - Sections: Provider configuration, command API, keybindings
   - Key findings: Terminal provider options, scroll commands

2. **Neovim API Documentation**
   - URL: https://neovim.io/doc/user/api.html
   - Sections: Floating windows, terminal buffers
   - Key findings: Terminal buffer behavior, window management

3. **Snacks.nvim Documentation**
   - URL: https://github.com/folke/snacks.nvim
   - Sections: Terminal provider
   - Key findings: No special scrolling configuration

### Related Issues

**Search Performed:**
- GitHub: `repo:NickvanDyke/opencode.nvim hover scroll`
- GitHub: `repo:NickvanDyke/opencode.nvim scrolling focus`
- GitHub: `repo:folke/snacks.nvim terminal scroll`

**Results**: No relevant open issues found

### Community Resources

**Neovim Discourse**: No discussions found on this specific topic
**Reddit r/neovim**: No recent posts about opencode scrolling

---

## Conclusion

The inability to scroll opencode output without focusing the terminal window is a **fundamental limitation of Neovim terminal buffers**, not a bug in opencode.nvim or snacks.nvim. 

**Recommended Solution**: Use the command API with keybindings (Solution 1) for the best user experience. This approach:
- Works from any window
- Uses the official API
- Requires minimal configuration
- Is reliable and maintainable

**Alternative Approaches**: External terminal providers or focus-switching workflows may suit specific use cases, but the keybinding approach is the most practical for most users.

**Future Outlook**: This limitation is unlikely to change unless Neovim core adds support for sending input to unfocused terminal buffers, or opencode.nvim implements a native Neovim frontend (like sudo-tee/opencode.nvim).

---

## Appendix: Complete Configuration Example

```lua
-- Complete opencode.nvim configuration with scrolling support

return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { terminal = {} } },
  },
  config = function()
    -- Configure opencode
    vim.g.opencode_opts = {
      provider = {
        enabled = "snacks",
        snacks = {
          win = {
            position = "right",
            width = 0.4,
            height = 0.8,
          }
        }
      }
    }

    -- Enable autoread for file reloading
    vim.o.autoread = true

    -- Main keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function() 
      require("opencode").ask("@this: ", { submit = true }) 
    end, { desc = "Ask opencode" })
    
    vim.keymap.set({ "n", "x" }, "<C-x>", function() 
      require("opencode").select() 
    end, { desc = "Execute opencode action" })
    
    vim.keymap.set({ "n", "t" }, "<C-.>", function() 
      require("opencode").toggle() 
    end, { desc = "Toggle opencode" })

    -- Scrolling keymaps (works from any window)
    vim.keymap.set("n", "<leader>ok", function() 
      require("opencode").command("session.half.page.up") 
    end, { desc = "OpenCode scroll up" })

    vim.keymap.set("n", "<leader>oj", function() 
      require("opencode").command("session.half.page.down") 
    end, { desc = "OpenCode scroll down" })

    vim.keymap.set("n", "<leader>oK", function() 
      require("opencode").command("session.page.up") 
    end, { desc = "OpenCode page up" })

    vim.keymap.set("n", "<leader>oJ", function() 
      require("opencode").command("session.page.down") 
    end, { desc = "OpenCode page down" })

    vim.keymap.set("n", "<leader>og", function() 
      require("opencode").command("session.first") 
    end, { desc = "OpenCode jump to top" })

    vim.keymap.set("n", "<leader>oG", function() 
      require("opencode").command("session.last") 
    end, { desc = "OpenCode jump to bottom" })

    -- Window management
    vim.keymap.set("n", "<leader>of", function()
      local wins = vim.api.nvim_list_wins()
      for _, win in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(buf)
        if bufname:match("term://") and bufname:match("opencode") then
          vim.api.nvim_set_current_win(win)
          return
        end
      end
      vim.notify("OpenCode window not found", vim.log.levels.WARN)
    end, { desc = "Focus OpenCode window" })

    -- Operator mappings
    vim.keymap.set({ "n", "x" }, "go", function() 
      return require("opencode").operator("@this ") 
    end, { expr = true, desc = "Add range to opencode" })
    
    vim.keymap.set("n", "goo", function() 
      return require("opencode").operator("@this ") .. "_" 
    end, { expr = true, desc = "Add line to opencode" })
  end,
}
```

---

**Research completed**: 2025-12-15
**Total sources reviewed**: 5+ documentation pages, 3 GitHub repositories
**Confidence level**: High - based on official documentation and API analysis
