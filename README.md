# eth-MT-report

LaTeX source for the Master Thesis report on Learning-based navigation (ETH Zurich, Robotic Systems Lab).

- `source/` — the report itself
- `template/` — the unmodified ETH RSL student-project template

## Build

Built with `latexmk` using XeLaTeX; output goes to `build/`:

```bash
cd source && latexmk -xelatex -outdir=../build main.tex
```

### Individual algorithm PDFs

The three appendix algorithms live in `source/chapters/algorithms/` and are
`\input` by both the thesis and a standalone driver, so there is a single source
for each. To export them as individual, tightly cropped PDFs into
`build/algorithms/`:

```bash
./scripts/export-algorithms.sh
```

In VS Code, copy `.vscode/settings.json.example` to `.vscode/settings.json` and use the LaTeX Workshop extension.

## License

MIT — see [LICENSE](LICENSE).
