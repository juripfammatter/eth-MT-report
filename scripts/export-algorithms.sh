#!/usr/bin/env bash
#
# Export each appendix algorithm as an individual, tightly cropped PDF and SVG.
# Output: build/algorithms/<name>.pdf, build/algorithms/<name>.svg
#
# Usage: ./scripts/export-algorithms.sh
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/source"
out_dir="$repo_root/build/algorithms"
work_dir="$out_dir/.tex"

# name:number -- the number matches the algorithm's numbering in the thesis
algorithms=(
    "alg_training_loop:1"
    "alg_random_walk:2"
    "alg_threshold:3"
    "alg_mix:4"
)

mkdir -p "$work_dir"
cd "$source_dir"

for entry in "${algorithms[@]}"; do
    name="${entry%%:*}"
    num="${entry##*:}"

    echo "==> $name (Algorithm $num)"

    # Two passes so \caption/\label references settle. -no-pdf stops at the .xdv,
    # which is both what xdvipdfmx wants and what dvisvgm reads directly.
    for _ in 1 2; do
        xelatex \
            -no-pdf \
            -interaction=nonstopmode \
            -file-line-error \
            -halt-on-error \
            -output-directory="$work_dir" \
            -jobname="$name" \
            "\def\algfile{$name}\def\algnum{$num}\input{chapters/algorithms/standalone}" \
            > /dev/null
    done

    # PDF: render the A4 page, then trim it down to the algorithm box.
    xdvipdfmx -q -o "$work_dir/$name.pdf" "$work_dir/$name.xdv"
    pdfcrop --margins 5 "$work_dir/$name.pdf" "$out_dir/$name.pdf" > /dev/null

    # SVG: same 5pt margin around the tightest bounding box. --no-fonts traces
    # the glyphs as paths, so the file renders identically without font support.
    dvisvgm \
        --bbox=5pt \
        --no-fonts \
        --output="$out_dir/$name.svg" \
        "$work_dir/$name.xdv" \
        > /dev/null 2>&1
done

echo
echo "Wrote:"
ls -1 "$out_dir"/*.pdf "$out_dir"/*.svg
