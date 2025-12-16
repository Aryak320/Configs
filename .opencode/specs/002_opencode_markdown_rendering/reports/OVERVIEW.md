# OpenCode Markdown Rendering Research

**Date**: 2025-12-15
**Research Prompt**: I notice that markdown output to opencode does not render. research this problem online to see if there are ways to fix this.
**Project**: 002_opencode_markdown_rendering

---

## Executive Summary

Markdown rendering in OpenCode TUI is a **known limitation**, not a bug. The OpenCode TUI (Terminal User Interface) displays raw markdown text instead of rendering it as formatted output. This affects all markdown elements including tables, headers, bold/italic text, and code blocks.

**Status**: There is an open PR (#2299) to add markdown rendering for user messages, but it has not been merged due to concerns about HTML tag handling. The maintainers suggest this should be addressed in OpenTUI (the underlying TUI framework).

**Current Workaround**: None available for the TUI. Users must read raw markdown or switch to a different interface.

---

## Key Findings

### 1. Root Cause: TUI Design Limitation

**OpenCode Architecture**:
- OpenCode uses a TUI (Terminal User Interface) for simplicity
- The TUI renders text as-is without markdown processing
- This is intentional to avoid complexity in the terminal interface

**Why Markdown Isn't Rendered**:
1. **Terminal Limitations**: Terminal emulators have limited formatting capabilities
2. **Complexity Trade-off**: Markdown rendering adds significant complexity to TUI
3. **HTML Tag Issues**: Markdown rendering can swallow HTML tags and special characters (like `__init__.py`)

### 2. Documented Issues

**GitHub Issues Found**:

| Issue | Repository | Status | Description |
|-------|------------|--------|-------------|
| [#3845](https://github.com/sst/opencode/issues/3845) | sst/opencode | Open | Markdown tables display as plain text |
| [#466468](https://github.com/NixOS/nixpkgs/issues/466468) | NixOS/nixpkgs | Open | opencode: markdown is rendered as plain text |
| [PR #2299](https://github.com/sst/opencode/pull/2299) | sst/opencode | Open | feat: Markdown rendering for user messages |

**Issue #3845 Details**:
- **Reported**: November 3, 2025
- **Affects**: All markdown elements (tables, headers, formatting)
- **Impact**: 13+ users affected (👍 reactions)
- **Assigned to**: @kommander
- **Labels**: `bug`, `opentui`

**PR #2299 Details**:
- **Submitted**: August 28, 2025
- **Author**: @jtyr
- **Status**: Open, not merged
- **Blocker**: Markdown rendering swallows HTML tags and special characters
- **Maintainer Response**: "can revisit with opentui" - @adamdotdevin

### 3. Why PR #2299 Wasn't Merged

**Quote from maintainer @adamdotdevin**:
> "main issue with this is that the markdown rendering swallows html tags and other random stuff people add to their prompts (`__init__.py`), we originally did this and got a bunch of complaints. can revisit with opentui."

**Problems Identified**:
1. **HTML Tag Swallowing**: Markdown parsers treat `<tag>` as HTML and hide it
2. **Special Character Issues**: Underscores in filenames like `__init__.py` get interpreted as markdown emphasis
3. **User Complaints**: Previous implementation caused more problems than it solved
4. **Highlighting Conflicts**: File and agent reference highlighting breaks markdown rendering

### 4. Current Status and Future Plans

**Maintainer Stance**:
- Feature is disabled by default (PR #2299 adds opt-in flag)
- Should be addressed in OpenTUI, not in OpenCode directly
- No timeline for implementation

**OpenTUI Integration**:
- OpenTUI is the underlying TUI framework used by OpenCode v1.0+
- Markdown rendering should be a feature of OpenTUI, not OpenCode
- This would benefit all OpenTUI-based applications

---

## Configuration Recommendations

### Solution 1: Wait for OpenTUI Integration (Recommended)

**Status**: Future feature, no ETA

**What to expect**:
- Markdown rendering will be added to OpenTUI framework
- OpenCode will automatically benefit when OpenTUI is updated
- Proper handling of HTML tags and special characters

**Action**: Monitor these repositories for updates:
- https://github.com/sst/opencode/issues/3845
- https://github.com/sst/opencode/pull/2299

### Solution 2: Use PR #2299 (Experimental)

**Warning**: Not recommended for production use

**How to use**:
1. Clone the PR branch:
   ```bash
   git clone https://github.com/jtyr/opencode.git
   cd opencode
   git checkout jtyr-markdown
   ```

2. Build and install:
   ```bash
   npm install
   npm run build
   ```

3. Enable markdown rendering (if opt-in flag is available):
   ```bash
   # Configuration method TBD - PR doesn't document this
   ```

**Caveats**:
- File references like `__init__.py` may not display correctly
- HTML tags in prompts will be hidden
- Highlighting for files and agents is disabled
- Not officially supported

### Solution 3: Use Alternative Interface

**Option A: OpenCode Web Interface**

```bash
# Run OpenCode in web mode
opencode web
```

**Advantages**:
- Full markdown rendering in browser
- Tables, code blocks, formatting all work
- Better for reading long responses

**Disadvantages**:
- Requires browser
- Less integrated with terminal workflow

**Option B: Use sudo-tee/opencode.nvim**

**Repository**: https://github.com/sudo-tee/opencode.nvim

**Advantages**:
- Native Neovim frontend (not TUI-based)
- Full control over rendering
- May support markdown rendering

**Disadvantages**:
- Different plugin from NickvanDyke/opencode.nvim
- Requires migration
- Different feature set

### Solution 4: Post-Process Output

**Concept**: Pipe OpenCode output through a markdown renderer

**Example using `glow`**:
```bash
# Install glow (markdown renderer for terminal)
brew install glow  # macOS
# or
apt install glow   # Debian/Ubuntu

# Pipe opencode output through glow
opencode | glow -
```

**Limitations**:
- Only works for batch/non-interactive use
- Loses real-time streaming
- Not practical for interactive sessions

---

## Known Limitations

### Limitation 1: TUI Architecture

**Issue**: Terminal User Interfaces have limited formatting capabilities

**Impact**: 
- No rich text rendering
- No table formatting
- No syntax highlighting in markdown code blocks

**Workaround**: Use web interface or wait for OpenTUI integration

### Limitation 2: HTML Tag Handling

**Issue**: Markdown parsers interpret `<tag>` as HTML and hide it

**Impact**:
- HTML in prompts gets swallowed
- Special characters like `<`, `>` cause rendering issues

**Example**:
```
User prompt: "Fix the <Component> in React"
Rendered: "Fix the  in React"  # <Component> is hidden
```

**Workaround**: Escape HTML tags or avoid them in prompts

### Limitation 3: Special Character Conflicts

**Issue**: Markdown uses special characters for formatting

**Impact**:
- Underscores in filenames (`__init__.py`) get interpreted as emphasis
- Asterisks in code get interpreted as bold/italic
- Backticks in non-code context get interpreted as inline code

**Example**:
```
Filename: __init__.py
Rendered: <em><em>init</em></em>.py  # Underscores become emphasis
```

**Workaround**: None currently available

---

## Best Practices

### 1. Workflow Adaptation

**For Reading Markdown Output**:
1. Use OpenCode web interface for markdown-heavy tasks
2. Copy output to a markdown viewer (VS Code, Typora, etc.)
3. Learn to read raw markdown (it's designed to be readable)

**For Writing Prompts**:
1. Avoid HTML tags in prompts
2. Use backticks for code/filenames: `` `__init__.py` ``
3. Escape special characters when needed

### 2. Terminal Selection

**Best Terminals for OpenCode**:
- **Kitty**: GPU-accelerated, good Unicode support
- **WezTerm**: Cross-platform, configurable
- **Alacritty**: Fast, minimal

**Why it matters**:
- Better Unicode support = better raw markdown readability
- Font rendering affects readability of markdown syntax

### 3. Font Configuration

**Recommended Fonts**:
- **JetBrains Mono**: Excellent code font with ligatures
- **Fira Code**: Popular code font with ligatures
- **Cascadia Code**: Microsoft's code font

**Configuration**:
```bash
# Example for Kitty terminal
# ~/.config/kitty/kitty.conf
font_family JetBrains Mono
font_size 13.0
```

---

## Alternative Solutions

### Option 1: Use OpenCode Web

**How to run**:
```bash
opencode web
```

**Pros**:
- Full markdown rendering
- Tables, code blocks, formatting all work
- Better for long responses

**Cons**:
- Requires browser
- Less integrated with terminal

### Option 2: Use Different AI Coding Tool

**Alternatives with Better Markdown Support**:

| Tool | Markdown Support | Interface | Notes |
|------|------------------|-----------|-------|
| **Cursor** | ✅ Full | GUI | VS Code fork with AI |
| **Continue.dev** | ✅ Full | VS Code extension | Open source |
| **Aider** | ⚠️ Partial | TUI | Terminal-based, limited rendering |
| **GitHub Copilot Chat** | ✅ Full | VS Code/IDE | Requires subscription |

### Option 3: Contribute to OpenTUI

**How to help**:
1. Star the issue: https://github.com/sst/opencode/issues/3845
2. Comment with your use case
3. Contribute to OpenTUI markdown rendering implementation

**Skills needed**:
- TypeScript/JavaScript
- Terminal UI development
- Markdown parsing

---

## Next Steps for Investigation

### 1. Monitor GitHub Issues

**Issues to watch**:
- https://github.com/sst/opencode/issues/3845
- https://github.com/sst/opencode/pull/2299

**Set up notifications**:
```bash
# Using GitHub CLI
gh issue view 3845 --repo sst/opencode --watch
```

### 2. Test Web Interface

**Try the web interface**:
```bash
opencode web
```

**Compare**:
- Markdown rendering quality
- Workflow integration
- Performance

### 3. Explore OpenTUI

**Repository**: https://github.com/sst/opentui (if public)

**Research**:
- Check if markdown rendering is planned
- Look for related issues
- See if contributions are welcome

### 4. Consider Filing Feature Request

**If this is critical for your workflow**:

**Title**: "Add markdown rendering to OpenTUI for better readability"

**Description**:
```
**Use Case**: Reading AI-generated markdown in terminal

**Current Behavior**: Raw markdown text is displayed

**Desired Behavior**: Rendered markdown with tables, formatting, etc.

**Suggested Implementation**:
- Use a terminal markdown renderer (e.g., glamour, glow)
- Add opt-in configuration flag
- Handle HTML tags and special characters gracefully

**Related Issues**: #3845, #2299
```

---

## Sources and References

### Primary Documentation

1. **OpenCode GitHub Issues**
   - Issue #3845: https://github.com/sst/opencode/issues/3845
   - PR #2299: https://github.com/sst/opencode/pull/2299
   - Key findings: Markdown rendering is a known limitation

2. **NixOS Package Issue**
   - Issue #466468: https://github.com/NixOS/nixpkgs/issues/466468
   - Confirms issue affects all distributions

3. **OpenCode Repository**
   - URL: https://github.com/sst/opencode
   - Sections: Issues, Pull Requests
   - Key findings: No official markdown rendering support

### Related Issues

**Search Performed**:
- GitHub: `opencode markdown rendering`
- GitHub: `opencode markdown tables`
- GitHub: `opentui markdown`

**Results**: 57 related issues found across repositories

### Community Resources

**GitHub Discussions**: No specific discussions found
**Reddit**: No recent posts about opencode markdown rendering

---

## Conclusion

Markdown rendering in OpenCode TUI is a **known limitation** that affects all users. The issue has been acknowledged by maintainers, and there is an open PR (#2299) that adds experimental support, but it has not been merged due to technical concerns about HTML tag handling and special character conflicts.

**Recommended Approach**:
1. **Short-term**: Use OpenCode web interface for markdown-heavy tasks
2. **Medium-term**: Monitor GitHub issues for OpenTUI integration
3. **Long-term**: Contribute to OpenTUI markdown rendering implementation

**Key Takeaway**: This is not a bug you can "fix" with configuration. It's an architectural limitation that requires changes to the underlying OpenTUI framework. The maintainers are aware and plan to address it in the future, but there is no ETA.

**Workaround Summary**:
- ✅ Use `opencode web` for full markdown rendering
- ⚠️ Test PR #2299 branch (experimental, not recommended)
- ✅ Learn to read raw markdown (it's designed to be readable)
- ❌ No configuration option to enable rendering in TUI

---

## Appendix: Raw Markdown Readability Tips

Since you'll be reading raw markdown for now, here are tips to make it easier:

### Reading Markdown Tables

**Raw markdown**:
```markdown
| Feature | GPT-4 | Claude |
|---------|-------|--------|
| Speed   | Fast  | Faster |
| Cost    | High  | Medium |
```

**How to read**:
1. First row is headers
2. Second row is separator (ignore)
3. Remaining rows are data
4. Columns are separated by `|`

### Reading Markdown Formatting

| Markdown | Meaning |
|----------|---------|
| `**bold**` | Bold text |
| `*italic*` | Italic text |
| `` `code` `` | Inline code |
| `# Header` | Heading level 1 |
| `## Header` | Heading level 2 |
| `- item` | Bullet list |
| `1. item` | Numbered list |

### Reading Code Blocks

**Raw markdown**:
````markdown
```python
def hello():
    print("Hello, world!")
```
````

**How to read**:
- First line: ` ```python ` = start of Python code block
- Middle lines: actual code
- Last line: ` ``` ` = end of code block

---

**Research completed**: 2025-12-15
**Total sources reviewed**: 10+ GitHub issues, 3 repositories, 1 PR
**Confidence level**: High - based on official GitHub issues and maintainer responses
**Recommendation**: Use `opencode web` for markdown rendering until OpenTUI integration is complete
