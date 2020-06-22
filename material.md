---
layout: cme195
---

# [](#schedule) Schedule

| Session | Day | Topic | Material/ Link to video | Lab | Slides| Further Material for the discussion |
|-|-|-|-|-|-|-|
| 1 | M | Getting Started | [R installation](./installation) + Course introduction | [Introductory Slides](./assets/lectures/Lecture1_Intro.html)|  |  | 
| 2 | W | The basics of R | [Introduction to the R syntax: vectors, matrices, functions, concatenation, etc.]() | [Lab 2: Swirl](./assets/lectures/Lab1-setup/Lec1_Exercises.nb.html) | [Slides: The R-syntax](./assets/lectures/Lecture1_IntroCoding.html)| |
| 3 | Th | The basics of Rmarkdown | Introduction to data handling: Importing and transforming data, loading packages| [Lab 3: Basics of coding in R](./assets/lectures/Lab1_setup/Lecture1_Intro2Markdown.html)|  |   [Exercise Template for Lab 3](./assets/lectures/Lab1-setup/template-exerciseweek1.Rmd)
| 4 | M | Tidyverse and Data Pre-processing| [Using the tidyverse syntax and cleaning up the data]() | [Lab: Tidyverse](./assets/lectures/Labs-Week2/session4_Exercises.nb.html)| [Slides: Tidyverse](./assets/lectures/Lecture_tidyverse.html) |  |
| 5 | W | Basic Probability | Introduction to basic probability models: probabilities, distributions and the CLT (I) |  |  |  |
| 6 | Th |  | Introduction to basic probability models: probabilities, distributions and the CLT (II)|  |  |  |
| 7 | M | Simulations | [Video]() | [Lab 7: Simulations](./biox-rbootcamp.github.io/assets/lectures/Lab2_simulations/Lab2_simulations.html)  |  |  |
| 8 | W |  | Visualization I | [Basic R plots]()  |  |  |
| 9 | Th |  | Visualization II | [Plotting with ggplot](link) | [Lab 9: Ggplot2](./biox-rbootcamp.github.io/assets/lectures/Lab3_graphics/Lab3_graphics.html)  |  |
| 10 | M | Mixtures | Mixtures |  |  |  |
| 11 | W |  | Permutation tests |  |  |  |
| 12 | Th |  | Bootstrap |  |  |  |
| 13 | M | Clustering | Kmeans and density based clustering |  |  |  |
| 14 | W |  | Choosing the number of clusters |  |  |  |
| 15 | Th |  | Hierarchical Clustering |  |  |  |
| 16 | M | Testing + Intro to RNA Seq | Testing + multiple hypothesis testing |  |  |  |
| 17 | W |  | Linear regression |  |  |  |
| 18 | Th |  | GLMs |  |  |  |
| 19 | M | Multivariate analysis | PCA |  |  |  |
| 20 | W |  | SVD |  |  |  |
| 21 | Th |  | Correlations and tests of associations |  |  |  |
| 22 | M | Networks | Friedman-Rafsky test |  |  |  |
| 23 | W |  |  |  |  |  |
| 24 | Th |  |  |  |  |  |


## [](#tut) Introductory Tutorials

* Week-1 related (basics of R coding):
    + [vectors and matrices](https://cme195.shinyapps.io/vectors_and_matrices/),
    + [lists and data-frames](https://cme195.shinyapps.io/lists_and_data_frames/)
    + [programming](https://cme195.shinyapps.io/programming/)
    +  an extra tutorial on importing data to R needs to be run locally. You can
get it by installing my tutorials with `devtools::install_github("nlhuong/rexercises")`,
Then, run a tutorial with the following command:  
`learnr::run_tutorial("data_to_R", package = "rexercises")`
* Week-3 related (basics of plotting):
    + [base plotting](https://cme195.shinyapps.io/base_plotting/)

Tutorials might include bugs, or some unclear hints. Please, let me know
if you encounter any mistakes in the tutorials so I can fix them.

[back](./)
