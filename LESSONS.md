# Lessons

Read this before writing any chapter. Add a line every time the user corrects something or a build or render goes wrong. Where a lesson can be checked by a machine, put the check in `tools/check.py` or the `Makefile` gate and say so here. A rule only written down can be forgotten; a rule `make` enforces cannot.

## What the user wants (style)
- **One convention: SLM, the BDA notes' way** (PLAN.md, rules S1–S8). Subscripted E/Var/Cov; regression given 𝕏.
- **Goal: scroll and recognise, for revision.** The reader has read every source page; each page should feel like the notes (PLAN.md D1–D3). Terse by default.
- **Examples go in boxes** (purple). Done in the preamble: every `example` is boxed automatically.
- **No references in the text.** No source lines, no citation footnotes, no "BDA / RTSM / FE / the notes" in the prose. *Enforced: check.py rule 5.* Page refs live only in PLAN.md's source map.
- **No meta-text about the notes:** slips in the handwritten notes are corrected silently in the text, with no "Correction to the notes" footnotes.
- **No beyond-notes extras by default.** The user cut Rao–Blackwell, CRLB, sufficiency and the bootstrap from Ch 2 as "not needed". Before adding exam-only or web material, ask whether it earns its place.
- **Course material is assumed known** (probability from FinMath). Revise, don't re-teach.

## LaTeX pitfalls I hit
- **A list right after a box title or "Proof." renders on the title line.** Always put a lead sentence first. *Enforced: check.py rule 3* (boxes). "Proof." now sits on its own line (preamble).
- **cleveref named every type "Theorem"** (shared counter plus tcolorbox wrappers). Fixed by declaring types with `thmtools` `\declaretheorem`. Check: `grep @cref build/chapters/*.aux` should show `[result]`, `[example]`, etc.
- **Boxes narrow the line.** Long displays, and chains of `\iff` or `=`, overflow. *Enforced: `make` fails on Overfull.* **Write it right the first time:** Chapter 2 still produced five overflows. Any display with an add-and-subtract expansion, an underbrace, or two or more `=` steps goes in `aligned`, one step per line.
- **tcolorbox resets `\parskip`,** so paragraphs inside boxes run together. Fixed in the `slm` style (`before upper`).
- **Never `\let`-copy amsthm's `\proof`.** It is a wrapper, and copying it recursed until TeX's capacity was exceeded. Redefine the environment instead.
- **`tcolorbox[most]` loads packages BasicTeX lacks.** Load only `skins,breakable`.
- **Missing TeX package:** add it to `TEXPKGS` in the Makefile. Never run `tlmgr` by hand.

## Process
- **Don't name a term in a lead-in sentence before its definition box** ("The method of moments is ..." right above its definition). Say "here is another recipe" instead. *Enforced: check.py rule 1.*
- **`\dfn` a phrase, not a common word.** `\dfn{test}`/`\dfn{power}` clash with ordinary prose ("powers of numbers", "test statistic" before "test"). Define the phrase (`power of the test`), or define the base word first in the same box. *Caught by check.py rule 1.*
- **Use only `make` targets** (`make`, `make review CH=NN`, `make source C= P=`).
- **After any preamble change, re-read a page with every box type.** It changes all chapters.
- **Forward pointers are words, not `\cref`** ("Chapter 2 shows ..."). *Enforced: check.py rules 2 and 6 (no links at all).*
- **A note example that leans on a later chapter gets rebuilt with tools already proved** (Ch 6: least squares swapped for a fixed-slope intercept estimate). Euclidean order beats copying the notes verbatim.
- **Recompute every number in an example with `python3`** before showing it.
- **Read every rendered page before showing the user,** and fix what you see first.
