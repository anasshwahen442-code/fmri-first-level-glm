# First-level, group-level and ROI analysis of a language-localizer fMRI dataset (Nilearn)

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/anasshwahen442-code/fmri-first-level-glm/blob/main/fmri_first_level_glm.ipynb)

A worked, fully scripted fMRI analysis in Python (Nilearn): quality control, subject-level GLM,
group inference, and a hypothesis-driven ROI analysis with robustness checks.

## Data
Nilearn's language-localizer demo dataset (10 subjects, BIDS layout, preprocessed derivatives supplied by the dataset authors).
It is downloaded automatically by `fetch_language_localizer_demo_dataset()`; the notebook prints the dataset description and source.

## Pipeline
1. **QC**: framewise displacement per subject (reported; nobody excluded).
2. **First level**: SPM HRF, cosine drift (high-pass 1/128 Hz), AR(1) noise model, 6 motion regressors, 8 mm smoothing (6 mm as sensitivity check).
3. **Group level**: one-sample model on `language - string`, FDR q < .05 whole-brain map and cluster table (optional max-t permutation test).
4. **ROI analysis** (Harvard-Oxford atlas): left IFG and left STG (hypothesised effect), left/right hippocampus (control).
   One-sample t-test, exact sign-flip permutation test, Wilcoxon test, Bonferroni over 4 ROIs, 95% CIs, d_z, exploratory TOST for the controls.
5. **Robustness**: two smoothing kernels, and a refit with spike regressors for high-motion volumes (FD > 0.5 mm).

## Results
ROI analysis, `language - string`, n = 10, 8 mm smoothing. Values are mean contrast estimates in arbitrary units.
p-values are Bonferroni-corrected over the 4 ROIs.

| ROI | mean | 95% CI | t(9) | p (t-test) | p (sign-flip) | p (Wilcoxon) | subjects > 0 |
|---|---|---|---|---|---|---|---|
| L STG | 0.326 | [0.183, 0.468] | 5.18 | .002 | .008 | .008 | 10/10 |
| L IFG | 0.128 | [0.037, 0.220] | 3.18 | .045 | .070 | .078 | 8/10 |
| L hippocampus (control) | 0.003 | [-0.031, 0.038] | 0.21 | 1.00 | 1.00 | 1.00 | 7/10 |
| R hippocampus (control) | 0.003 | [-0.024, 0.029] | 0.22 | 1.00 | 1.00 | 1.00 | 4/10 |

* **L STG** is robust: significant under all three tests, in all 10 subjects, with both kernels and with spike regressors.
* **L IFG** is fragile: it passes the pre-specified t-test (p = .045; .041 at 6 mm; .049 with spike regressors) but not the sign-flip or Wilcoxon tests after correction. Treat it as suggestive.
* **Hippocampal controls** show no detectable effect. An exploratory equivalence test with a post hoc bound (+/-0.109 a.u., one third of the L STG mean) places both inside the bound; the bound is arbitrary.
* Head motion does not drive the result: refitting with spike regressors for FD > 0.5 mm volumes changes the means by at most 0.003.
* Effect sizes (d_z = 1.0 and 1.6) are inflated by the small sample; the confidence intervals are wide.

Figures are in `figures/`, tables in `results/`.

## Limitations
* Ten subjects of a demo dataset: effect sizes are imprecise and probably inflated; confidence intervals are wide.
* ROIs were chosen from the literature **after** viewing whole-brain maps; the hypotheses are **not formally preregistered**.
* Contrast estimates are in arbitrary units, not percent signal change.
* Preprocessing (realignment, MNI normalisation) was done by the dataset authors, not here.
* One contrast, one dataset, no replication. This is a learning/portfolio project, not a methods contribution.

## Reproduce
```bash
pip install -r requirements.txt
jupyter notebook fmri_first_level_glm.ipynb   # Kernel > Restart & Run All
```
Or click the Colab badge. After a run, `results/requirements_frozen.txt` holds the exact library versions used.

## Author
Anas Shawah'en: https://github.com/anasshwahen442-code
