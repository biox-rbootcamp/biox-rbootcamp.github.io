---
layout: cme195
---

# [](#schedule) Schedule

| Session | Day | Topic | Material/ Link to video | Lab | Slides| Further Material for the discussion |
|-|-|-|-|-|-|-|
| 1 | M | Getting Started | [R installation](./installation) + Course introduction | [Introductory Slides](./assets/lectures/Lecture1_Intro.html)|  |  | 
| 2 | W | The basics of R | [Introduction to the R syntax: vectors, matrices, functions, concatenation, etc.](https://www.youtube.com/watch?v=iffR3fWv4xw&list=PLOU2XLYxmsIK9qQfztXeybpHvru-TrqAP) | [Lab 2: Swirl](./assets/lectures/Lab1-setup/Lec1_Exercises.nb.html) | [Slides: The R-syntax](./assets/lectures/Lecture1_IntroCoding.html)| |
| 3 | Th | The basics of Rmarkdown | Introduction to data handling: Importing and transforming data, loading packages| [Lab 3: Basics of coding in R](./assets/lectures/Lab1_setup/Lecture1_Intro2Markdown.html)|  |   [Exercise Template for Lab 3](./assets/lectures/Lab1-setup/template-exerciseweek1.Rmd)
| 4 | M | Tidyverse and Data Pre-processing| [Using the tidyverse syntax and cleaning up the data]() | [Lab4: Tidyverse](./assets/lectures/Labs-Week2/session4_Exercises.nb.html)| [Slides: Tidyverse](./assets/lectures/Lecture_tidyverse.html) |  |
| 5 | W | Basic Probability Models | Introduction to basic probability models: probabilities, distributions and the CLT Part I:  [a) Motivation](https://www.youtube.com/watch?v=6nvhFgmrvLE) [b) Random Variable](https://www.youtube.com/watch?v=AxJf1nXrW8U) [c) Probability Distributions](https://www.youtube.com/watch?v=govBS0uJ9GA) [d) Bernoulli Distribution](https://www.youtube.com/watch?v=bT1p5tJwn_0) [e) Binomial Distribution](https://www.youtube.com/watch?v=qIzC1-9PwQo&t=47s) [f) Poisson Distribution](https://www.youtube.com/watch?v=jmqZG6roVqU&t=4s)| [Lab 5: Probability Models I](./biox-rbootcamp.github.io/assets/lectures/session5.html) |  | [Exercise Template for Lab 5](./biox-rbootcamp.github.io/assets/lectures/session5.Rmd) |
| 6 | Th |  | Introduction to basic probability models: probabilities, distributions and the CLT Part II: [a) Normal Distribution](https://www.youtube.com/watch?v=fwaxgik7aj4) [b) Populations, Samples, Estimates](https://www.youtube.com/watch?v=99WNX608k0Y) [c) Central Limit Theorem](https://www.youtube.com/watch?v=aYA8ZG-ltqQ) [d) CLT in Practice](https://www.youtube.com/watch?v=QOeoxOgYpzU)| [Lab 6: Probability Models II](./biox-rbootcamp.github.io/assets/lectures/session6.html) |  |  [Exercise Template for Lab 6](./biox-rbootcamp.github.io/assets/lectures/session6.Rmd)|
| 7 | M | Simulations | [Video]() | [Lab 7: Simulations](./biox-rbootcamp.github.io/assets/lectures/Lab2_simulations/Lab2_simulations.html)  |  |  |
| 8 | W |  | Basic visualization tools  [a)Histograms](https://www.youtube.com/watch?v=UaXYRf6qtEg) [b) QQplots](https://www.youtube.com/watch?v=5F62EwMF26c) [c) Boxplots](https://www.youtube.com/watch?v=Hh-Pd23OmVo) [d)Scatter plots](https://www.youtube.com/watch?v=dmJzInKpuRE) [e)Plots to avoid](https://www.youtube.com/watch?v=p-dYnSbBTa8) | |  |  |
| 9 | Th |  | [Plotting with ggplot](https://drive.google.com/file/d/1BBNvt2EWtZnixHbGxnXg-vbivP7Iu0EI/view?usp=sharing) | [Lab 9: Ggplot2](./biox-rbootcamp.github.io/assets/lectures/Lab3_graphics/Lab3_graphics.html)  |  |
| 10 | M | Mixtures | [Mixtures Lecture](https://drive.google.com/file/d/1aXFkzL1tWYLnAf5PKkwMGvai6NUaHrnb/view?usp=sharing)  |  |  |  |
| 11 | W |  | Permutation tests |  |  |  |
| 12 | Th |  | Bootstrap |  |  |  |
| 13 | M | Clustering | [Kmeans and density based clustering](https://drive.google.com/file/d/1ekIRX3Fi_TWMnwJhTeW4RrXslfot_sVE/view?usp=sharing) |  |  |  |
| 14 | W |  | Choosing the number of clusters |  |  |  |
| 15 | Th |  | Hierarchical Clustering |  |  |  |
| 16 | M | Testing + Intro to RNA Seq | Testing + multiple hypothesis testing |  |  |  |
| 17 | W |  | Linear regression |  |  |  |
| 18 | Th |  | GLMs |  |  |  |
| 19 | M | [Multivariate analysis](https://drive.google.com/file/d/1BBNvt2EWtZnixHbGxnXg-vbivP7Iu0EI/view?usp=sharing) | PCA |  |  |  |
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
