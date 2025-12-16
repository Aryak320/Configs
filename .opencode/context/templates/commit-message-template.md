# Commit Message Template

Template for conventional commits.

```
<type>: <short description>

- Detail 1
- Detail 2
- Detail 3

Optional longer explanation if needed.
```

## Types

- `research`: Research completion
- `plan`: Planning completion
- `feat`: New feature
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Testing

## Examples

```
research: complete lazy_loading_optimization investigation

- Analyzed 47 Lua files
- Identified 8 plugins without lazy-loading
- Found 3 performance bottlenecks
- Estimated 150ms potential improvement
```

```
feat: add lazy-loading to telescope and nvim-tree

- telescope.nvim: event = "VeryLazy"
- nvim-tree.lua: event = "VeryLazy"
- Startup time improved from 200ms to 120ms
```
