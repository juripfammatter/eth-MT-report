# eth-MT-report

LaTeX source for the Master Thesis report on Learning-based navigation (ETH Zurich, Robotic Systems Lab).

- `source/` — the report itself
- `template/` — the unmodified ETH RSL student-project template
- `iclr/` — ICLR 2026 conference-format version of the report (official template; unmodified formatting instructions in `iclr/reference/`)

## Build

Built with `latexmk` using XeLaTeX; output goes to `build/`:

```bash
cd source && latexmk -xelatex -outdir=../build main.tex
```

### Individual algorithm figures

The four appendix algorithms live in `source/chapters/algorithms/` and are
`\input` by both the thesis and a standalone driver, so there is a single source
for each. To export them as individual, tightly cropped PDFs and SVGs into
`build/algorithms/`:

```bash
./scripts/export-algorithms.sh
```

### ICLR 2026 paper

The `iclr/` folder holds a separate paper in the official ICLR 2026 format
(pdfLaTeX, per the conference template). Its `.latexmkrc` routes output to
`build-iclr/`:

```bash
cd iclr && latexmk main.tex
```

Keep `\iclrfinalcopy` in `iclr/main.tex` commented out for submission
(double-blind); the style file anonymizes the author block automatically.
Main text limit: 9 pages at submission (10 for camera-ready); references and
appendices don't count.

In VS Code, copy `.vscode/settings.json.example` to `.vscode/settings.json` and use the LaTeX Workshop extension.

## License

MIT — see [LICENSE](LICENSE).
