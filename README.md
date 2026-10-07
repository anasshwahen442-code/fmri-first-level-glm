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
Run the notebook and paste your own summary here (see section 8 of the notebook). Figures are written to `figures/`, tables to `results/`.

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
