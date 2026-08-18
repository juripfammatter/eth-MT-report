#!/usr/bin/env bash
#
# Export each appendix algorithm as an individual, tightly cropped PDF.
# Output: build/algorithms/<name>.pdf
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
)

mkdir -p "$work_dir"
cd "$source_dir"

for entry in "${algorithms[@]}"; do
    name="${entry%%:*}"
    num="${entry##*:}"

    echo "==> $name (Algorithm $num)"

    # Two passes so \caption/\label references settle.
    for _ in 1 2; do
        xelatex \
            -interaction=nonstopmode \
            -file-line-error \
            -halt-on-error \
            -output-directory="$work_dir" \
            -jobname="$name" \
            "\def\algfile{$name}\def\algnum{$num}\input{chapters/algorithms/standalone}" \
            > /dev/null
    done

    # Trim the page down to the algorithm box, leaving a small margin.
    pdfcrop --margins 5 "$work_dir/$name.pdf" "$out_dir/$name.pdf" > /dev/null
done

echo
echo "Wrote:"
ls -1 "$out_dir"/*.pdf
