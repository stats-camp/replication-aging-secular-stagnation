# Replication: Aging, Output Per Capita, and Secular Stagnation

Gauti B. Eggertsson, Manuel Lancastre, and Lawrence H. Summers — *American Economic Review: Insights (2019)*.

This [stats.camp](https://stats.camp) repository preserves official AEA deposit
**231432, version V1**, for replication and engine compatibility testing.
**Status: executed on 2026-10-16 and again on 2026-10-17 in the native stats.camp engine from scratch copies; the package now runs end to end in the engine.** The deposited data and all 24 do-files
keep their original bytes and archive-relative paths. No do-file path, command,
comment, whitespace, encoding, or line ending has been changed.

## The study

Examines how the relationship between population aging and output growth changes when nominal interest rates are constrained by a lower bound.

## Contents and entry points

All scripts share the deposited `AGING_GROWTH.dta`. The code uses robust OLS, `ivreg2` with partialled-out controls, `eststo`/`esttab`, and scatterplots with fitted lines.

The source archive contains **28 original files** totaling
**1,367,829 bytes**; its ZIP is 627,095 bytes. All deposited data, reference
outputs, scripts and ancillary files are retained. The package README was
adapted as plain text for stats.camp; its original PDF is preserved in the
maintainer's external preparation archive. Archive metadata listed in the
source manifest is excluded.

Entry points for inspection (the full script inventory is in the manifest):

- [Data_and_do_files/Table_1_Panel_A.do](Data_and_do_files/Table_1_Panel_A.do)
- [Data_and_do_files/Table_2_Panel_A.do](Data_and_do_files/Table_2_Panel_A.do)
- [Data_and_do_files/Figure_1.do](Data_and_do_files/Figure_1.do)

Package documentation:

- [Data_and_do_files/ReadMe.txt](Data_and_do_files/ReadMe.txt) (adapted for stats.camp)
- [Data_and_do_files/Monetary_Policy_IR_MIN_08_14.pdf](Data_and_do_files/Monetary_Policy_IR_MIN_08_14.pdf)

## Setup and current scope

All 24 table, appendix, and figure scripts are independent entry points in `Data_and_do_files/`. They contain an absolute Windows `cd` and `global maindir` assignment. Those paths are preserved, as are the original appendix filenames, even where the README uses shorter names.

The 2026-10-16 runs used scratch copies, so the figures, logs and intermediate
datasets in this repository are still the authors' deposited reference material.

## Inspect in stats.camp

These links open the deposited files for inspection. They do not establish
that the preserved paths, dependencies, or commands are executable in the browser.

- [Data_and_do_files/Table_1_Panel_A.do](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-aging-secular-stagnation.git&file=Data_and_do_files%2FTable_1_Panel_A.do)
- [Data_and_do_files/Table_2_Panel_A.do](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-aging-secular-stagnation.git&file=Data_and_do_files%2FTable_2_Panel_A.do)
- [Data_and_do_files/Figure_1.do](https://stats.camp/app?open=https%3A%2F%2Fgithub.com%2Fstats-camp%2Freplication-aging-secular-stagnation.git&file=Data_and_do_files%2FFigure_1.do)

## Source integrity and attribution

- [Official deposit](https://www.openicpsr.org/openicpsr/project/231432/version/V1/view)
- [Deposit DOI](https://doi.org/10.3886/E231432V1)

Archive: `231432-V1.zip`. SHA-256:
`793cf851875af3033ab5ad41da4af24ac68f9da11b4c4de2c1aa512579cd482a`.

All original file hashes were checked after extraction. `.gitattributes` disables
Git line-ending normalization to preserve deposited bytes. Empty folders are
represented by `.gitkeep` files listed in the source manifest. The root README
and Git attributes are stats-camp additions; `Data_and_do_files/ReadMe.txt`
is adapted from the original PDF.

The deposited `LICENSE.txt` is retained without modification. It supplies the original code/data terms; this mirror does not relicense the research.

The study, code, and data remain credited to Gauti B. Eggertsson, Manuel Lancastre, and Lawrence H. Summers; stats-camp maintains
this mirror and its preparation documentation.
