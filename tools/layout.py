#!/usr/bin/env python3
"""Flag page breaks that strand a heading. Reads `pdftotext -layout` text (pages split by form feeds) on stdin.

  make layout    runs it on build/review.pdf (after `make review CH=NN`)

Flags a page whose last line is a box title (Definition 1.2, ...), a "Proof." line or a section
heading, and a page whose first line is a lone QED (□). Prints one line per flag; exit 1 if any.
"""
import re
import sys

TITLE = re.compile(r'^\s*((Definition|Theorem|Result|Lemma|Corollary|Example|Remark) \d+\.\d+\b|Proof\.\s*$)')
SECTION = re.compile(r'^\d+(\.\d+)+\s+\S')        # "1.2    Parametric families", unindented
HEAD = re.compile(r'^(CHAPTER \d+\.|PART )')      # running head
PAGENO = re.compile(r'^\s*([0-9]+|[ivxlc]+)\s*$')  # page number in the footer

flags = []
for n, page in enumerate(sys.stdin.read().split('\f'), 1):
    lines = [l for l in page.splitlines() if l.strip()]
    if lines and HEAD.match(lines[0]):
        lines = lines[1:]
    if lines and PAGENO.match(lines[-1]):
        lines = lines[:-1]
    if not lines:
        continue
    if TITLE.match(lines[-1]) or SECTION.match(lines[-1]):
        flags.append(f'p{n}: page ends with a heading: {lines[-1].strip()}')
    if lines[0].strip() == '□':
        flags.append(f'p{n}: page starts with a lone QED')

print('\n'.join(flags) or 'layout: 0 flags')
sys.exit(1 if flags else 0)
