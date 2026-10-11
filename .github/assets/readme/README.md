# README assets

Hand-authored SVGs for the repository homepage.

- `hero.svg` — title banner. Theme: gritty cyberpunk with vaporwave accents; the `dotfiles`
  wordmark is the chroma-split rat-fink title, and a large CRT terminal panel dominates the
  right side.
- `pipeline.svg` — bootstrap flow diagram.

## Intentional, do not "fix"

- **Hardcoded hex colors** (`#0b0910`, `#ff2d95`, `#25e6ff`, `#b8ff2e`, `#f3edff`, `#8b81a6`)
  are the design, not a missing theme token. Don't route them through variables.
- **The wordmark is deliberately chroma-split** (magenta/cyan offsets behind the ink text) —
  don't "correct" the colour fringing.
- **Coordinates and type sizes** are hand-tuned for a 1200-unit viewBox rendered at GitHub's
  ~900px content width. Don't auto-reformat.
- **Animation rest states are also set as presentation attributes** (the scan bar carries
  `opacity="0"`, the aura `opacity="0.45"`). This keeps the static first frame correct when the
  inline `<style>` is stripped or ignored. Do not remove those attributes.
- **CSS animation inside the SVG is decorative.** GitHub does not play animation embedded in
  SVG, so every module is built to read complete as a static first frame. The animation shows
  in a local preview only; a GitHub-safe GIF is a separate, opt-in deliverable.
