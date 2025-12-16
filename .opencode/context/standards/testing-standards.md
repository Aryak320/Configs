# Testing Standards

Standards for testing NeoVim configurations.

## Test Types

1. **Health Checks**: `:checkhealth` validation
2. **Functional Tests**: Plugin/LSP functionality
3. **Performance Tests**: Startup time, memory
4. **Integration Tests**: Multi-component workflows

## Test After

- Every phase implementation
- Major refactoring
- Plugin additions/updates
- LSP server changes

## Test Coverage

- All plugins load correctly
- LSP servers attach
- Keybindings work
- No errors in logs
- Performance within benchmarks

## Validation

- Run `:checkhealth`
- Test critical workflows
- Check error logs
- Measure startup time
- Verify no regressions
