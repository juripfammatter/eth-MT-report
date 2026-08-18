# eth-MT-report

LaTeX source for the Master Thesis report on Learning-based navigation (ETH Zurich, Robotic Systems Lab).

- `source/` — the report itself
- `template/` — the unmodified ETH RSL student-project template

## Build

Built with `latexmk` using XeLaTeX; output goes to `build/`:

```bash
cd source && latexmk -xelatex -outdir=../build main.tex
```

In VS Code, copy `.vscode/settings.json.example` to `.vscode/settings.json` and use the LaTeX Workshop extension.

## License

MIT — see [LICENSE](LICENSE).
