Assignments
===========

Assignments will be continously updated during the course up until the week when the assignment is due.

Some exercises refer to additional files. These are located in the folder `additional_files`.


## Shared LaTeX preamble

All eight assignment sources load `common_preamble.tex` immediately after
`\documentclass`. This file contains the common packages, Latin-1 encoding, link
colours, bibliography style, page layout, paragraph spacing and math commands.
Edit it to change these settings throughout the assignments. Keep packages or
overrides needed by only one assignment in that assignment's Rnw preamble, after
the shared input.

```latex
\documentclass[11pt,a4paper,english]{article}
\input{common_preamble.tex}
% Assignment-specific packages or overrides go here.
```

The common preamble also loads `example_boxes.tex`; do not load it a second time
in the individual assignments.

## Shared example and hint boxes

Edit `example_boxes.tex` to change the example and hint styling throughout the
assignments.

For a short example containing text or mathematics, use:

```latex
\examplebox{Example title}{Example text or mathematics.}
```

For an example containing an Rnw code chunk or verbatim material, use the environment
form so that LaTeX can read the code normally:

```latex
\begin{exampleblock}{Example title}
Text, mathematics, figures, or an Rnw code chunk.
\end{exampleblock}
```

Use `\begin{hintblock}{Hint title} ... \end{hintblock}` for a hint with the same
styling. Both types display "No submission required". Boxes stay on one page;
split a long example into smaller boxes if necessary. Do not nest boxes.

## Google Colab

For TensorFlow and Keras assignments, open the [course R setup notebook in Colab](https://colab.research.google.com/github/MansMeg/IntroML/blob/master/additional_material/colab_nb/setup_r_colab.ipynb). It includes setup, a training check, and a link to the assignment report template. If you work locally in R or RStudio, open [setup_r_local.R](../additional_material/r_setup/setup_r_local.R), read its comments, and run the code one section at a time following the [R setup guide](../additional_material/r_setup/README.md).

For the Swedish BERT exercise in assignment 5, open the [Python notebook in Colab](https://colab.research.google.com/github/MansMeg/IntroML/blob/master/assignments/swedish_bert_classification.ipynb).

The Rtex files are TeX files that can be compiled with Knitr (in R-Studio). To change it back TeX, just remove the R chunks and and it should compile using ordinary TeX.

The makefile can be use to compile all files at once using:
```make pdf```.

