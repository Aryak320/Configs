# NixOS Basics

**Domain**: NixOS package management integration

---

## NixOS Context

<nixos>
  <dotfiles>
    - Main dotfiles: ~/.dotfiles/
    - NixOS configuration
    - Declarative package management
  </dotfiles>
  
  <packages>
    - System packages via NixOS config
    - NeoVim installed via Nix
    - Plugin dependencies managed
  </packages>
</nixos>

---

## Integration Points

<integration>
  <system_packages>
    - Binary dependencies (ripgrep, fd, etc.)
    - LSP servers (can be via Nix or Mason)
    - External tools
  </system_packages>
  
  <dotfiles_link>
    - Configuration managed in ~/.dotfiles/
    - NixOS rebuilds apply system changes
    - NeoVim config separate but integrated
  </dotfiles_link>
</integration>

---

## Package Installation

<installation>
  <nix_approach>
    - Add to NixOS configuration
    - Run `nixos-rebuild switch`
    - System-wide availability
  </nix_approach>
  
  <mason_approach>
    - Use Mason for LSP servers
    - User-local installation
    - Independent of NixOS
  </mason_approach>
</installation>

---

## Reference

- Dotfiles: ~/.dotfiles/
- NixOS Manual: https://nixos.org/manual/nixos/stable/
