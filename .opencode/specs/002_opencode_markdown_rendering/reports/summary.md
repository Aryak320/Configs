# Quick Summary: OpenCode Markdown Rendering Issue

**Problem**: OpenCode TUI displays raw markdown instead of rendering it

**Root Cause**: Architectural limitation of Terminal User Interface

**Status**: Known issue, open PR exists but not merged

**Solution**: Use `opencode web` for full markdown rendering

---

## Key Points

1. **This is NOT a bug** - it's an intentional design limitation
2. **No configuration fix** - requires changes to OpenTUI framework
3. **Open PR #2299** - experimental support, not merged due to HTML tag issues
4. **Maintainer response** - "can revisit with opentui"

## Immediate Workaround

```bash
# Use web interface for markdown rendering
opencode web
```

## Links

- Issue #3845: https://github.com/sst/opencode/issues/3845
- PR #2299: https://github.com/sst/opencode/pull/2299
- Full research: ./OVERVIEW.md
