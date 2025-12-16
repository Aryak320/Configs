# NeoVim Performance Optimization

**Domain**: Performance profiling, optimization strategies, and benchmarking

---

## Profiling Tools

<profiling_tools>
  <startup_profiling>
    ```bash
    # Measure startup time with detailed breakdown
    nvim --startuptime startup.log +qall
    
    # View the log to identify slow plugins
    cat startup.log | sort -k2 -n | tail -20
    ```
    
    **Key Metrics**:
    - Total startup time (target: <50ms)
    - Plugin load times
    - Sourcing times for config files
    - Initialization overhead
  </startup_profiling>
  
  <lazy_profiling>
    ```vim
    " Open lazy.nvim profiler UI
    :Lazy profile
    
    " Shows:
    " - Load time per plugin
    " - Lazy-loading triggers
    " - Dependency chains
    " - Total time breakdown
    ```
    
    **Analysis**:
    - Identify plugins loaded at startup
    - Find heavy dependencies
    - Verify lazy-loading effectiveness
    - Detect redundant loads
  </lazy_profiling>
  
  <runtime_profiling>
    ```lua
    -- Profile specific operations
    vim.cmd('profile start profile.log')
    vim.cmd('profile func *')
    vim.cmd('profile file *')
    
    -- Perform operations to profile
    
    vim.cmd('profile pause')
    vim.cmd('noautocmd qall!')
    ```
    
    **Use Cases**:
    - Slow keybindings
    - Laggy UI operations
    - Heavy autocommands
    - Performance regressions
  </runtime_profiling>
</profiling_tools>

---

## Optimization Strategies

<optimization_strategies>
  <lazy_loading>
    **Event-Based Loading**:
    ```lua
    -- Defer heavy plugins
    {
      "nvim-telescope/telescope.nvim",
      event = "VeryLazy",  -- Load after startup
    }
    
    -- Filetype-specific plugins
    {
      "lervag/vimtex",
      ft = "tex",  -- Only load for LaTeX files
    }
    
    -- Command-based loading
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    }
    ```
    
    **Best Practices**:
    - VeryLazy for UI plugins (statusline, file explorer)
    - Filetype for language-specific tools
    - Command for rarely-used features
    - Keys for keybinding-triggered plugins
  </lazy_loading>
  
  <defer_ui>
    ```lua
    -- Defer UI setup to after startup
    vim.defer_fn(function()
      require("lualine").setup()
      require("nvim-tree").setup()
    end, 0)
    
    -- Schedule heavy operations
    vim.schedule(function()
      require("telescope").load_extension("fzf")
    end)
    ```
    
    **Benefits**:
    - Faster perceived startup
    - Non-blocking initialization
    - Smoother user experience
  </defer_ui>
  
  <partial_clones>
    ```lua
    -- Use shallow clones for faster plugin installation
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      -- lazy.nvim uses shallow clones by default
    }
    ```
    
    **Configuration**:
    - Shallow clones reduce disk usage
    - Faster git operations
    - Minimal history needed for plugins
  </partial_clones>
  
  <module_caching>
    ```lua
    -- Leverage Lua module caching
    local M = {}
    
    -- Cache expensive computations
    local cached_config = nil
    function M.get_config()
      if not cached_config then
        cached_config = compute_expensive_config()
      end
      return cached_config
    end
    
    return M
    ```
    
    **Patterns**:
    - Cache configuration objects
    - Memoize expensive functions
    - Lazy-initialize modules
    - Avoid repeated file I/O
  </module_caching>
</optimization_strategies>

---

## Benchmarking Process

<benchmarking>
  <baseline_measurement>
    ```bash
    # Measure baseline startup time (10 runs)
    for i in {1..10}; do
      nvim --startuptime /tmp/startup_$i.log +qall
    done
    
    # Calculate average
    awk '{sum+=$2} END {print sum/NR}' /tmp/startup_*.log
    ```
    
    **Metrics to Track**:
    - Minimum startup time
    - Average startup time
    - Maximum startup time
    - Standard deviation
  </baseline_measurement>
  
  <comparative_testing>
    ```bash
    # Test with minimal config
    nvim -u minimal.lua --startuptime minimal.log +qall
    
    # Test with full config
    nvim --startuptime full.log +qall
    
    # Compare results
    diff <(sort minimal.log) <(sort full.log)
    ```
    
    **Analysis**:
    - Identify config overhead
    - Isolate plugin impact
    - Validate optimizations
  </comparative_testing>
  
  <regression_testing>
    ```bash
    # Create benchmark script
    #!/bin/bash
    RUNS=10
    TOTAL=0
    
    for i in $(seq 1 $RUNS); do
      TIME=$(nvim --startuptime /dev/stdout +qall 2>&1 | \
             tail -1 | awk '{print $2}')
      TOTAL=$(echo "$TOTAL + $TIME" | bc)
    done
    
    AVG=$(echo "scale=2; $TOTAL / $RUNS" | bc)
    echo "Average startup: ${AVG}ms"
    ```
    
    **Integration**:
    - Run before/after changes
    - Track performance over time
    - Detect regressions early
  </regression_testing>
</benchmarking>

---

## Common Bottlenecks

<bottlenecks>
  <plugin_loading>
    **Symptoms**:
    - Slow startup (>100ms)
    - Delayed UI rendering
    - Laggy initial input
    
    **Solutions**:
    - Convert to lazy-loading
    - Remove unused plugins
    - Optimize plugin configurations
    - Use lighter alternatives
  </plugin_loading>
  
  <treesitter_parsing>
    **Symptoms**:
    - Slow file opening
    - Laggy syntax highlighting
    - High CPU on large files
    
    **Solutions**:
    ```lua
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    })
    ```
  </treesitter_parsing>
  
  <lsp_overhead>
    **Symptoms**:
    - Slow diagnostics
    - Delayed completions
    - High memory usage
    
    **Solutions**:
    ```lua
    -- Debounce diagnostics
    vim.diagnostic.config({
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        prefix = "●",
      },
    })
    
    -- Limit completion items
    require("cmp").setup({
      performance = {
        max_view_entries = 20,
      },
    })
    ```
  </lsp_overhead>
  
  <autocommands>
    **Symptoms**:
    - Slow buffer switching
    - Laggy file saves
    - Delayed events
    
    **Solutions**:
    ```lua
    -- Group and optimize autocommands
    local augroup = vim.api.nvim_create_augroup("OptimizedGroup", { clear = true })
    
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      pattern = "*.lua",
      callback = function()
        -- Efficient formatting
        vim.lsp.buf.format({ async = false, timeout_ms = 1000 })
      end,
    })
    ```
  </autocommands>
</bottlenecks>

---

## Performance Targets

<targets>
  <startup_time>
    - Excellent: <30ms
    - Good: 30-50ms
    - Acceptable: 50-100ms
    - Needs optimization: >100ms
  </startup_time>
  
  <memory_usage>
    - Base NeoVim: ~10-20MB
    - With plugins: 50-100MB
    - Heavy config: 100-200MB
    - Excessive: >200MB
  </memory_usage>
  
  <responsiveness>
    - Keystroke latency: <16ms (60 FPS)
    - Completion popup: <100ms
    - File opening: <200ms
    - LSP diagnostics: <500ms
  </responsiveness>
  
  <monitoring>
    ```lua
    -- Track memory usage
    :lua print(vim.fn.system("ps -o rss= -p " .. vim.fn.getpid()))
    
    -- Monitor event loop lag
    :lua vim.loop.update_time()
    ```
  </monitoring>
</targets>

---

## Optimization Checklist

<checklist>
  - [ ] Profile startup time with --startuptime
  - [ ] Review :Lazy profile for heavy plugins
  - [ ] Convert eager-loaded plugins to lazy-loading
  - [ ] Defer UI plugin initialization
  - [ ] Optimize treesitter for large files
  - [ ] Debounce LSP diagnostics
  - [ ] Group and optimize autocommands
  - [ ] Remove unused plugins and features
  - [ ] Benchmark before/after changes
  - [ ] Monitor memory usage
  - [ ] Test with minimal config for comparison
  - [ ] Document performance improvements
</checklist>
