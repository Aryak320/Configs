# Validation Rules

Validation rules for NeoVim configuration changes.

## Pre-Commit Validation

1. **Syntax**: Lua syntax is valid
2. **Standards**: Follows coding standards
3. **Documentation**: Public functions documented
4. **Tests**: Tests pass

## Post-Implementation Validation

1. **Health Check**: `:checkhealth` passes
2. **Functionality**: Features work as expected
3. **Performance**: No significant regressions
4. **Errors**: No new errors in logs

## Review Checklist

- [ ] Syntax valid
- [ ] Standards compliant
- [ ] Documented
- [ ] Tested
- [ ] Health check passed
- [ ] Performance acceptable
- [ ] No errors

## Acceptance Criteria

- All tests pass
- Health check OK
- Startup time < target
- No critical errors
- Documentation complete
