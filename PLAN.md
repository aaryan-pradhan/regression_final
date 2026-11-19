# Regression: the plan

This file is the whole plan for the book. Every chapter session reads it first, top to bottom. If something here and a chapter disagree, this file wins; fix the chapter or change this file on purpose.

## 1. What the book is

- One LaTeX book that revises three IIT KGP courses already studied in full: Big Data Analysis, Regression & Time Series Modelling, and Financial Econometrics.
- **It is for revision, not first learning.** The reader has read every source page before. He scrolls the book top to bottom, fast, and every page should read as "yes, I know this, it is clear, it is correct".
- It replaces the old `regression` book (chapters 0–6 written, 7–28 never written). The old book's chapters, plan and lessons are kept in `src/old/` as source material only.
- Output: `make pdf` builds `build/main.pdf` and copies it to `regression_final.pdf`.

## 2. Decisions (grill, 19 Nov 2026)

| # | Decision | Rule |
|---|---|---|
| D1 | **Purpose** | Revision of material already read. Fast top-to-bottom scroll; clear proofs. |
| D2 | **Feels like the source** | Each chapter follows the notes' own order, the notes' own examples and the notes' own derivation path. Something that looks new has to be read slowly, which kills revision speed. Add no structure the notes do not have. |
| D3 | **Voice** | Terse by default. Verbose only where a step genuinely needs words. No meta-text about the notes, no source names in the text. |
| D4 | **Chapter shape** | One-line `setup` → for each idea: definition, boxed result, two-column proof, the notes' worked example. **No** prerequisites box, "what this chapter does" box, intuition box, recall sheet, formula sheet or problems part. |
| D5 | **Derivations** | FinMath's two-column table plus Dijkstra's one-step-per-line discipline. See §3. |
| D6 | **No links** | No `\label`, `\ref`, `\cref`, `\eqref`, `\hyperlink`, `\url`. An earlier result is named in words and restated in full where it is used. *Enforced: `tools/check.py` rule 6.* |
| D7 | **Scope** | The 28 chapters in §6. In: PCA, LPM/logit/probit/Tobit, Cochrane–Orcutt. Out: Bayesian networks, random graphs, the PCA network project (BDA p188–191), the ML pages (RTSM p334–353, p448–449), bootstrap, CRLB, Rao–Blackwell, sufficiency (cut by the user: "not needed"). |
| D8 | **Convention** | One convention only: Statistical Learning Methods, the Big Data notes' way (§4, S1–S8, and the notation lock in §5). Every RTSM and FE result is rewritten into it. |
| D9 | **Indicators and matrices** | Supports, likelihoods and counts use indicator variables; anything that fits a matrix is written as a matrix (regression, estimators, covariances). |
| D10 | **Assumed knowledge** | Probability (FinMath): random variables, pdf/pmf, E, Var, Cov, conditional expectation, Markov, Chebyshev, WLLN, CLT, modes of convergence. Chapter 0 lists it in one box; it is never re-taught. |
| D11 | **Errors in the notes** | Corrected silently in the text (list in §8). No footnotes. |
| D12 | **Numbers** | python3 recomputes every number in the book before it is shown. |
| D13 | **The web complements the notes** | Standard texts fill gaps (exam-only topics), verify corrections and theorem conditions. They never override the notes' notation; they are translated into it. No citations in the book. Texts: Weinberger CS4780 and ESL (learning), Montgomery–Peck–Vining and Sengupta & Jammalamadaka (linear models), Johnson & Wichern (multivariate, PCA), Brockwell & Davis and Shumway & Stoffer (time series), Wooldridge and Greene (heteroskedasticity, DW, GLS, logit, probit, Tobit), Casella & Berger (estimation). |
| D14 | **One block per session** | `/clear`, then `/euclid-book`, following §7 and §11. A block is 2–5 chapters (§11); the user reviews each block before the next starts. (19 Nov 2026, to cut token cost; was one chapter per session.) |

## 3. How a derivation is written (D5)

Every derivation is a `deriv` table: the maths on the left (58% of the width), the reason on the right (39%).

```latex
\begin{deriv}
\dl{\|\vect{y}-\X\vect{\beta}\|^2=(\vect{y}-\X\vect{\beta})\T(\vect{y}-\X\vect{\beta})}{$\|\vect{v}\|^2=\vect{v}\T\vect{v}$}
\dl{\phantom{\|\vect{y}-\X\vect{\beta}\|^2}=\vect{y}\T\vect{y}-\vect{\beta}\T\X\T\vect{y}-\vect{y}\T\X\vect{\beta}+\vect{\beta}\T\X\T\X\vect{\beta}}{multiply out; $(AB)\T=B\T A\T$ gives $(\X\vect{\beta})\T=\vect{\beta}\T\X\T$}
\dl{\phantom{\|\vect{y}-\X\vect{\beta}\|^2}=\vect{y}\T\vect{y}-2\vect{\beta}\T\X\T\vect{y}+\vect{\beta}\T\X\T\X\vect{\beta}}{$\vect{y}\T\X\vect{\beta}$ is $1\times1$, so it equals its transpose $\vect{\beta}\T\X\T\vect{y}$}
\end{deriv}
```

- **One operation per row.** Each row's left side is the next result, continuing the row above with `=` (or `\le`, `\iff`, …). Step, result, step, result. No skipped steps.
- **The reason quotes the rule in full.** If a row uses a rule, definition or theorem, the right column states it: its hypotheses and its conclusion, e.g. "Gauss–Markov: if $\E_{y\mid\X}(\vect{\varepsilon})=\vect{0}$ and $\Var(\vect{\varepsilon}\mid\X)=\sigma^2I_n$, every linear unbiased estimator has variance $\succeq\sigma^2(\X\T\X)^{-1}$". The statement, never its proof. Never "by Theorem 3.2".
- **Use the algebra.** Matrix rules ($(AB)\T=B\T A\T$, $\tr(AB)=\tr(BA)$, $\Var(A\vect{z})=A\Var(\vect{z})A\T$, block multiplication, $\nabla_{\vect{\beta}}\,\vect{\beta}\T A\vect{\beta}=2A\vect{\beta}$ for symmetric $A$) are used wherever they shorten the work.
- **Elegant and short.** A derivation of more than about 8 rows is split into named steps (`steps` list: Step-1, Step-2, …), each ending in a boxed result.
- **The notes' path.** Where the notes add and subtract, name a cross term and prove a claim about it (S5), the table does the same, row for row.
- Plain text between tables only when a step needs a sentence (D3).

## 4. THE convention: Statistical Learning Methods (Big Data notes, pp. 95–113)

**S1. Setup before anything.** Each topic opens with:
- the population as a joint law `F_{x̲,y}`, x̲ a random vector, y a random variable;
- an iid sample `S = {(x̲₁,y₁),…,(x̲ₙ,yₙ)} ~ Fⁿ_{x̲,y}`;
- a learning algorithm giving the rule `y = h_S(x̲)`;
- the goal in words: "come up with a prediction rule h_S, using S, that predicts y in terms of x̲".

**S2. Named population objects.** Regression function `ȳ(x̲) = E_{y|x̲}(y) = ∫ y f_{y|x̲}(y|x̲) dy`; average predictor `h̄(x̲) = E_S[h_S(x̲)]`.

**S3. Every E, Var and Cov carries, as a subscript, exactly what it averages over:** `E_{x̲,y,S}`, `E_{x̲,S}`, `E_{x̲,y}`, `E_S`, `E_{x̲}`, conditional ones `E_{y|x̲}`, `E_{y|𝕏}`, `Var_{y|𝕏}`. Where the notes drop a subscript, the book puts it back. *Enforced: check.py rule 4.*

**S4. Moments the Big Data way (p96).**
- Variance `= E_{x̲,S}[(h_S(x̲) − h̄(x̲))²]`, Bias² `= E_{x̲}[(h̄(x̲) − ȳ(x̲))²]`, Noise `= E_{x̲,y}[(y − ȳ(x̲))²]`.
- ETEP `= E_{x̲,y,S}[(h_S(x̲) − y)²]` = Variance + Bias² + Noise.
- For an estimator θ̂(S): `Bias = E_S[θ̂] − θ`, `Var = E_S[(θ̂ − E_S θ̂)²]`, `MSE = E_S[(θ̂ − θ)²]`.

**S5. Proof path (p97–98).** Add and subtract (`h_S − h̄ + h̄ − y`), expand the square; name the cross term (MT) and write "Claim: MT = 0"; prove it by nesting expectations (`E_{x̲,y}[E_S(·)]`, `E_{x̲}[E_{y|x̲}(·)]`); underbrace each factor "independent of S" or "free of y", pull it out, send the inner expectation to 0; underbrace and label every term of the final identity.

**S6. Regression is stated given a particular data set 𝕏 (p104–113).**
- Assumption box (the linear model): `y = β₀ + β₁x₁ + … + β_kx_k + ε`, ε | x̲ ~ N(0,σ²), "part of the model"; a non-zero error mean is absorbed into β₀.
- The fitted rule is the learned predictor `h_S(x̲) = β̂₀ + β̂₁x₁ + … + β̂_kx_k`.
- Matrix form with dimensions: `y̲_{n×1} = 𝕏_{n×(k+1)} β̲_{(k+1)×1} + ε̲_{n×1}`; 𝕏 is random.
- `β̂ = argmin_β ‖y̲ − 𝕏β̲‖²`; work under y | 𝕏: `E_{y|𝕏}(y̲) = 𝕏β̲`, `Var(y̲|𝕏) = σ²Iₙ`, `Var_{y|𝕏}(β̂) = σ²(𝕏ᵀ𝕏)⁻¹`.
- Uncondition with the tower rule, in full: `E(β̂) = E_𝕏[E_{y|𝕏}(β̂)] = E_𝕏[β + (𝕏ᵀ𝕏)⁻¹𝕏ᵀE(ε|𝕏)] = β`; `Var(β̂) = E_𝕏[Var_{y|𝕏}(β̂)] + Var_𝕏(E_{y|𝕏}β̂) = σ²E_𝕏[(𝕏ᵀ𝕏)⁻¹]`.
- Probability-one statements come from the randomness of 𝕏: 𝕏ᵀ𝕏 is pd with probability 1. "More variance" means Var(T₁) − Var(T₂) is psd with probability 1.
- RTSM's fixed-X results become "given 𝕏" statements.

**S7. Worked examples follow p101–102.** The population is given as the law of x plus the law of y | X = x (e.g. X ~ U[0,100], y | X=x ~ U[x, x+0.1]); then ȳ(x), h̄(x), Bias² and Variance are computed term by term.

**S8. Boxes and derivations.** Key results are boxed (β̂ = (𝕏ᵀ𝕏)⁻¹𝕏ᵀy̲, Var(β̂) = σ²(𝕏ᵀ𝕏)⁻¹); identities used later are boxed where first proved (Var(DZ) = D Var(Z) Dᵀ); derivations are two-column tables (§3), split into Step-n only when long.

## 5. Notation lock (Big Data notes win every collision)

| Item | Lock | Replaces |
|---|---|---|
| design matrix | 𝕏 (`\X`), random, n×(k+1); conditioning `\| 𝕏` | plain X in RTSM and FE |
| vector | underline x̲ (`\vect{x}`) | RTSM under-tilde, bold in slides |
| matrix | plain capital X, Σ, P | – |
| variance-covariance matrix | `Var(x̲)` | RTSM `D(·)`, FE `V(·)` |
| conditioning | `\|` only | the notes' occasional `/` |
| transpose | `\T` (ᵀ) | `'` |
| indicator | `\ind{…}` = 1{…} | – |
| # regressors | k; 𝕏 is n×(k+1); residual df n−k−1 | FE's p parameters |
| MVN/PCA dimension | p | – |
| training sample | S, S ~ Fⁿ_{x̲,y} | – |
| sample covariance (PCA) | Σ̂ (divisor n−1), Σ̂_MLE (divisor n); s² for a scalar | the notes' S, which collides with the sample |
| raw sum Σ(xᵢ−x̄)² | S_xx | RTSM's S² |
| projection | P_X = X(XᵀX)⁻¹Xᵀ; C(A) column space; A⁻ g-inverse | – |
| data index | x_{ij}: i = observation, j = variable | x_{ji} in the PCA notes and FE |
| time series | X_t; white noise W_t ~ WN(0,σ²_W); γ(h), ρ(h), α(h) PACF; B backshift, ∇ = I−B; Φ_p, Θ_q, Ψ | RTSM's Z_t for white noise |
| χ² | χ²_{df}(ncp), ncp = μᵀAμ, no ½ | – |

Macros live in `preamble.tex` (`\E`, `\Var`, `\Cov`, `\tr`, `\rank`, `\argmin`, `\ind`, `\T`, `\iid`) and `notation.tex` (`\vect`, `\X`, `\MLE`). Add a symbol there, never inline.

## 6. The chapters

"Write from" is where the content comes from. Page numbers are scan pages (`make source C=<name> P=a-b`). Chapters 0–6 are rewritten from the old book's approved `.tex` in `src/old/chapters/` (re-open the scans only to check a step). `src/fin_econ/NN-*.tex` are the exam-question chapters of the Financial Econometrics book: their questions become boxed examples in the chapter named.

| # | Chapter | Contents | Write from | Status |
|---|---|---|---|---|
| 0 | Front matter | assumed-probability box (D10), notation table (§5), how to read a two-column derivation | src/old/chapters/00 | accepted |
| **I** | **Inference foundations** | | | |
| 1 | Population, sample, likelihood, MLE | statistic, likelihood, MLE for Bernoulli, Exp, N, Binomial; support depends on θ: U(θ,2θ), uniform, triangular, two-value MLE examples | old 01; BDA 64–66; RTSM 275–276, 387–388; FE gen 05; fin_econ 04–07; papers/MLE practice | accepted |
| 2 | Properties of estimators | unbiasedness (x̄; the 1/(n−1) proof; Σaᵢ² ≥ 1/n), bias, MSE = Var + Bias², consistency, method of moments (Gamma) | old 02; BDA 67–73; RTSM 272–274, 384–386; stats training 60–72; fin_econ 01 | accepted |
| 3 | Sampling distributions & CIs | χ², t, F defined; CIs for μ (σ known/unknown) and σ²; election sample size (Chebyshev vs CLT) | old 03; BDA 74–81; RTSM 208–209, 277–278, 389–390; fin_econ 03 | accepted |
| 4 | Hypothesis testing | H₀/H₁, Type I/II, α, power, z/t one- and two-sample, pooled t, χ² goodness of fit | old 04; BDA 82–89; RTSM 408–409 | todo |
| **II** | **The learning view of regression** | | | |
| 5 | Statistical learning | S → h_S; supervised/unsupervised; regression = E_{y|x}[y]; linear in β vs not; simulation; curse of dimensionality | old 05; BDA 89–94, 114–115; RTSM 136–157 | todo |
| 6 | Bias–variance decomposition | theorem, proof (S5 path), four examples | old 06; BDA 95–103 | todo |
| **III** | **Linear algebra & random vectors** | | | |
| 7 | Vector spaces → projections | subspace, span, basis, S⊥, P_S idempotent with eigenvalues 0/1, C(A) facts, C(AAᵀ)=C(A), rank, g-inverse, A(AᵀA)⁻Aᵀ | RTSM 64–76, 210–222, 354–366 | todo |
| 8 | Symmetric matrices & quadratic forms | eigen, AM/GM, spectral theorem, real eigenvalues, pd/psd, counterexamples, Cauchy–Schwarz and the extended form, maximisation lemma | BDA 122–176; RTSM 220–221 | todo |
| 9 | Random vectors | E, Var algebra (AΣAᵀ, Cov(AX,BX)), Var psd, E(xᵀAx) = tr(AΣ) + μᵀAμ, x−μ ∈ C(Σ) a.s., Mahalanobis | RTSM 77–84, 223–231, 367–373 | todo |
| 10 | Multivariate normal | definition via aᵀX, density, AX, BVN, ellipses, partition/marginals/independence, conditional mean = linear regression, χ²_p ellipsoid, MLE μ̂ and Σ̂, Wishart, multivariate CLT | BDA 116–140; RTSM 85–87, 230–233, 402–405 | todo |
| 11 | Quadratic forms of normal vectors | central and noncentral χ², xᵀAx ~ χ² iff A idempotent, Cochran, independence (CA = 0), x̄ ⊥ s², t and F in matrix form | RTSM 88–93, 234–239, 374–383 | todo |
| **IV** | **Linear regression** | | | |
| 12 | The linear model & least squares | assumption box, matrix form, matrix calculus, normal equations, Hessian, SLR closed forms, palm-length example | BDA 104–107; RTSM 279–282, 308–309, 391–394; fin_econ 08 | todo |
| 13 | Geometry of least squares | fitting = projecting; ŷ = P_X y, e = (I−P_X)y, ŷ ⊥ e | RTSM 282–288, 396–400 | todo |
| 14 | Sampling properties of β̂ | E(β̂), Var(β̂), distributions of β̂, ŷ, e; eᵀe/σ² ~ χ²_{n−k−1}; MS_Res unbiased; MLE = LS but σ̂²_MLE biased; Laplace-error aside; consistency; Cov(β̂₀,β̂₁); the n = 25 example | BDA 108, 113; RTSM 96–99, 118–122, 320–325, 415–419; FE gen 06 | todo |
| 15 | Gauss–Markov & estimability | proof via C = (𝕏ᵀ𝕏)⁻¹𝕏ᵀ + D; LUE, LZF, pᵀβ estimable iff p ∈ C(Xᵀ), BLUE iff uncorrelated with every LZF, lᵀP_X y, uniqueness | BDA 109–112; RTSM 109–113, 305–306, 429–433 | todo |
| 16 | Inference on coefficients | t for βⱼ and for αᵀβ, general linear hypothesis F, the multiple-testing level, CIs for β and σ², mean-response CI vs prediction interval | RTSM 105–108, 127–133, 313–317, 408–413, 425–428, 444–445 | todo |
| 17 | ANOVA & R² | SST = SSE + SSM as nested projections, Cochran, ncp depends only on β_R, F_{k,n−k−1,λ}, computing formulas, R², adjusted R², regression through the origin | RTSM 99–104, 307, 311, 420–424, 446 | todo |
| 18 | Random regressors | the correlation model, BVN regression, H₀: β₁ = 0 ⇔ ρ = 0, t for r, Fisher z | RTSM 401–407 | todo |
| **V** | **PCA** | | | |
| 19 | PCA | population theorem, variance share, corr(Yᵢ, X_k), 3×3 worked example, sample PCA, the 6-point exam dataset | BDA 140–145, 177–188; regpca; fin_econ 19 | todo |
| **VI** | **Time series** | | | |
| 20 | Stochastic processes | white noise, random walk (with drift), signal + noise, Brownian motion and bridge, Gaussian process, uncorrelated vs independent | RTSM 450–457 | todo |
| 21 | Stationarity & autocovariance | strict vs weak, ACF, Cauchy counterexample, random walk not stationary, ACF of MA(1) and AR(1), the exam MA(1) | RTSM 457–464; fin_econ 20 | todo |
| 22 | Operators & linear processes | B, ∇, ∇_s, linear filter theorem, MA(q), AR(p), AR(1) = MA(∞), ARMA, ARMA(1,1), causality, invertibility; AR(1) OLS consistency | RTSM 465–476, 488–489; FE slides 04 | todo |
| 23 | Partial correlation & PACF | | RTSM 477–482 | todo |
| 24 | Estimating the mean and ACF | Var(X̄), long-run variance, γ̂ with divisor n is psd, Bartlett | RTSM 483–487 | todo |
| 25 | Best linear prediction | Durbin–Levinson, AR(1) interpolation; model-selection and mixture aside | RTSM 489–499 | todo |
| **VII** | **When assumptions fail** | | | |
| 26 | Heteroskedasticity | OLS still unbiased; sandwich (𝕏ᵀ𝕏)⁻¹𝕏ᵀΩ𝕏(𝕏ᵀ𝕏)⁻¹; BP, White, GQ; WLS | FE gen 07–08; fin_econ.pdf 36–38; fin_econ 09 | todo |
| 27 | Autocorrelated errors & GLS | AR(1) errors, DW ≈ 2(1−ρ̂) with d_L/d_U zones, Cochrane–Orcutt, GLS Ω = QQᵀ, FGLS, OLS/WLS/GLS table | FE gen 09–10; FE slides 04–16; fin_econ.pdf 39–42; fin_econ 10, 11 | todo |
| **VIII** | **Limited dependent variables** | | | |
| 28 | LPM, logit, probit, Tobit | LPM and its problems; logit and probit as latent-variable models, MLE fit, coefficient meaning (marginal effects); Tobit: censoring, likelihood, MLE | fin_econ 12, 13; exam papers; Wooldridge/Greene for gaps | todo |

Status: `todo` → `drafted` (written, gates pass) → `accepted` (the user said yes).

## 7. One chapter, one session (how the book stays cohesive)

Cohesion lives in files, not in a conversation: `/clear` between chapters is safe because everything a chapter needs is in this repo.

1. `/clear`, then `/euclid-book`. It reads, in order: `~/.claude/skills/euclid-book/LESSONS.md`, this `PLAN.md`, `LESSONS.md`.
2. **Read what came before:** the previous chapter's `.tex` in full, and `grep -h '\\dfn' chapters/*.tex` (the terms already defined). A chapter may use only those terms plus D10's assumed list.
3. **Read the source:** the row's "Write from" pages as images (`make source C=… P=…`); for chapters 0–6 also the old `.tex`.
4. **Write** `chapters/NN-slug.tex` (short title, D4 shape, §3 derivations) and add `\include{chapters/NN-slug}` to `main.tex` under its `\part`.
   - Open with one plain sentence that picks up where the previous chapter ended, in words.
   - Same symbols as §5, always. A result from an earlier chapter is restated in full in the reason column where it is used (D6).
5. **Gate:** `make build check` gives 0 errors, 0 overfull boxes, `check: 0 violations`. Recompute every number with python3.
6. **Look:** `make review CH=NN && make layout`; read the pages `make layout` flags plus the chapter's first page, fix them and rebuild.
6a. **Content review, once, at the end (never skipped: the content matters most).** Read every rendered page of the chapter and check:
   - *Simple:* plain short sentences; every symbol named at first use; one operation per deriv row, no skipped step; every reason quotes its rule in full; nothing harder than the line needs.
   - *Framed per this plan:* the opening sentence picks up the previous chapter; setup box first (S1); D4 shape per idea; the notes' order and derivation path (D2, S5); §5 notation; every `\E`, `\Var`, `\Cov` subscripted (S3); indicators and matrices (D9); regression given 𝕏 (S6); no meta-text, no links, nothing beyond the source.
   - *Complete:* every item in the row's Contents column; every exam question in Write from is a boxed example.
   - *Correct:* each row follows from the one above; theorem conditions stated; numbers match the python3 check.
   Fix, rebuild, rerun the gates; reread only pages a big fix changed. The hand-over line says the pass was done and what it changed.
7. **Hand over:** one line: chapter, page count, 2–3 things worth knowing. He reads it with `make open`.
8. **Revise** on his comments (at most 3 passes before asking what is still wrong). Every comment goes into `LESSONS.md` the same turn. Set the status to `accepted` on his yes.
9. **Commit** after each small step (section written, feedback fix); push when the chapter is accepted.

## 8. Sources and known errors

All sources are in `src/` (gitignored, local only).

- `src/old/`: the old book (chapters 00–06, its PLAN, LESSONS, preamble).
- `src/fin_econ/`: the Financial Econometrics book's chapters 01 unbiased, 03 intervals, 04 likelihood, 05 two-value, 06 uniform, 07 triangular MLE, 08 OLS, 09 heteroskedasticity, 10 Cochrane–Orcutt, 11 GLS, 12 probit/logit, 13 Tobit, 19 PCA, 20 MA(1).
- `src/scans/`: `bda.pdf` (Big Data), `rtsm.pdf`, `fe_general.pdf` and `fe_general_full.pdf` (FE general notes; the full one is the newer copy), `fe_slides.pdf`, `fin_econ.pdf`, `regpca.pdf`, `stats_training.pdf`.
- `src/papers/`: end-sem and mid-sem question papers, MLE practice and solutions, the course outline.
- `src/solutions/`: HTML solution notes from the exam prep (regression_complete.html, endsem/midsem solutions, MLE).

**Scan map.**
- `bda.pdf`: p1–62 probability (skip); p64–89 inference; p89–103 learning and bias–variance; p104–113 regression spine; p114–140 taxonomy and MVN; p122–176 linear algebra; p177–188 PCA; OUT p188–191.
- `rtsm.pdf`: p1–61 probability (skip); slides p136–157 intro, p158–173 linear algebra, p193–206 multivariate; p94–135 MLR, ANOVA, tests, estimability; p391–446 SLR → MLR (the most complete copy); p450–499 time series. Duplicates: p240–269 = p210–239; p210–229 = p354–373 = p64–83 (byte-identical); p230 = p84 = p374; p231 = p85 = p375; p234–239 = p378–383 = p88–93 (some without the pink marks); p475 = p450; p434–445 repeat p415–428. Blank p326–333. OUT p334–353, p448–449.
- FE: `fe_general_full.pdf` p03–10; `fe_slides.pdf` p01–16 (p5 = p4); `stats_training.pdf`; `fin_econ.pdf`.

**Known errors in the notes (correct silently, D11).**
- RTSM linear algebra: p216 P_S examples swapped; p217 "P_S = 3".
- RTSM regression: p318 sign of the fitted line; p319/446 R²_adj denominator; p399 rank = rows; p408 x̄ vs x̄² in Var(β̂₀); p410 CI labelled β₁ but derived for β₀; p107/427 "joint level α²"; p428 ncp written with β̂; p129 χ² condition; p388 "MLE always consistent".
- RTSM time series: p461 Z_t = S_t/√t "stationary"; p471 Θ_q last term; p474 γ(1) label; p478 σ_u → σ_v; p488 roots condition and φ → ψ; p498 Γ_{n−1}.
- Big Data: p88 χ² goodness-of-fit formula; p102 U[100,100]; p183 √5.82.

## 9. Repo and commands

- `make build check`: build and run the gates (use while writing). `make pdf`: also copy the PDF to `regression_final.pdf`.
- `make review CH=NN`: render one chapter's pages to `build/review/`. `make source C=rtsm P=391-400`: render scan pages to `build/source/`. `make open`: open the PDF.
- `tools/check.py` rules: 1 term used before its `\dfn`; 2 forward reference; 3 a box opening with a list; 4 an `\E` without a subscript; 5 a source name in the text (`BANNED` in `book.mk`); 6 any link.
- `main.tex` includes the chapters; `preamble.tex` has the boxes and the `deriv` table; `notation.tex` has the book's symbols.

## 10. Done when

Every row in §6 is `accepted`; `make pdf` builds the whole book with 0 errors, 0 overfull boxes and `check: 0 violations`; every scan page in §8 is covered, marked duplicate, or marked OUT.

## 11. Writing the rest (plan of 19 Nov 2026, chapters 0–3 accepted)

**Goal:** chapters 4–28 at minimum token cost. Text before images; a script before page images; one block per session.

**Text sources** (grep them; open a scan page only to settle one step, `make source C=… P=n-n`):
| Source | Chapters |
|---|---|
| `src/old/chapters/04–06.tex` | 4, 5, 6 |
| `src/text/big_data_analysis_notes.md` (secs 10–33) | 4, 5, 6, 8, 10, 12, 15, 19 |
| `src/text/regression_complete.md` (A–J: algebra, random vectors, MLR, estimability, inference, correlation model, PCA) | 7, 9–19 |
| `src/fin_econ/08–13, 19, 20.tex` | 12, 26, 27, 28, 19, 21 |
| `src/text/rtsm_text.txt` (rtsm slides p136–209, the only real text layer) | spot checks |
| `src/text/rtsm_ts.md`, `src/text/rtsm_qf.md`, `src/text/fe_scans.md` (Sonnet transcriptions) | 20–25; 7, 9, 11; 26–28 |
| exam papers, `src/text/*solutions*.md` | boxed examples |

**Session 0 (setup, no chapters)** — status: done 19 Nov 2026. `rtsm_text.txt` holds only the typed slides p136–209: the handwritten pages' text layer is OCR noise. `rtsm_qf.md` transcribes every algebra page in full (none was fully covered by `regression_complete` B). Agents' `[?]` marks: rtsm_ts 41, rtsm_qf 11, fe_scans 13; check a `[?]` against the scan before using that line.
1. HTML → text, zero tokens: stdlib `html.parser` turns each `src/solutions/*.html` into `src/text/<name>.md` (headings kept, MathJax kept as LaTeX); `pdftotext` writes rtsm text-layer pages to `src/text/rtsm_text.txt` with `## p<N>` markers. No script kept.
2. Sonnet transcription: 3 background agents (`model: sonnet`), one per block: RTSM time series p450–499 → `rtsm_ts.md`; RTSM quadratic forms p88–93, 234–239, 374–383 plus algebra pages not in `regression_complete` B → `rtsm_qf.md`; `fe_general_full` p3–10, `fe_slides` p1–16, `fin_econ.pdf` p36–42 → `fe_scans.md`. Each renders its own pages with `pdftoppm` into its scratch dir and writes one `## p<N>` per page: faithful, LaTeX maths, no rewording, `[?]` where illegible, duplicates/OUT per §8. Spot-check 2 pages per block against the image.
3. `tools/layout.py` + `make layout`, written in the skill template first, then copied here: `pdftotext -layout build/review.pdf` page by page; flag a page whose last line is a box title (`^(Definition|Theorem|Result|Lemma|Corollary|Example) \d+\.\d+`) or a section heading, and a page that starts with a lone QED. Must be silent on chapters 1–3 and catch one hand-made bad case.
4. Commit each step, push.

**Blocks** (one session each): 4–6 · 7–8 · 9–11 · 12–14 · 15–18 · 19 · 20–22 · 23–25 · 26–28.

**Per chapter:** §7 steps, plus: write the chapter in one `Write`, right the first time (2+ `=` in `deriv`/`aligned`; long rows start `\quad=`; a proof ending in a deriv puts `\qedhere` in its last reason; no bare `\E`); gates as `make build check 2>&1 | grep -E '^(build|check)|Overfull|^!'`; fixes by small scripted replacements; all numbers in one python3 call (stdlib, no scipy).

**Cost guards:** `grep -n` then `sed -n 'a,bp'`, never `cat` a large file; pipe every `make` through `tail`/`grep`; no re-reading after edits; no subagents in chapter sessions; suggest `/handoff` past ~120k tokens.

