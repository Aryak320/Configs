# Logs Directory

System logging for NeoVim configuration management.

---

## Log Files

- **errors.log**: Error messages from all agents
- **research.log**: Research operation logs
- **planning.log**: Planning operation logs
- **implementation.log**: Implementation operation logs
- **performance.log**: Performance metrics and benchmarks

---

## Log Format

```
[TIMESTAMP] [LEVEL] [AGENT] Message
```

Example:
```
[2025-12-15T10:30:00Z] [ERROR] [researcher] Failed to fetch documentation for plugin X
[2025-12-15T10:35:00Z] [INFO] [implementer] Phase 1 completed successfully
```

---

## Log Levels

- **ERROR**: Critical errors requiring attention
- **WARN**: Warnings that don't block operation
- **INFO**: Informational messages
- **DEBUG**: Detailed debugging information

---

## Log Rotation

Logs older than 30 days should be archived or deleted to prevent excessive disk usage.

Manual log management:
```bash
# View recent errors
tail -100 logs/errors.log

# Clear old logs
find logs/ -name "*.log" -mtime +30 -delete
```
