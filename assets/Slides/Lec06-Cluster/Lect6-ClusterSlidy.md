# Clustering
Susan Holmes (c)  
July 3, 2017  




```
## Loading required package: knitr
```

![Birds of a Feather](http://bios221.stanford.edu/images/flock-of-starlings.jpg)

Finding  a latent or hidden variable present which we are not necessarily provided.

Clusters do exist in Biomedical Data
======================================

![Cancer Clusters](http://bios221.stanford.edu/images/CancerCluster.jpg){width = "80%"}


# Goals for this lecture

-   Study which types of data can be beneficially clustered.

-   See measures of (dis)similarity and that help us define clusters.

-   Uncover hidden or latent clustering by partitioning the data into
     *tighter*  sets.

-   Show how relevant clustering can be in immunology where immune cells
    can be naturally grouped into subpopulation.

-   Explain methods such as *kmeans* or *kmedoids* on multivariate  cell populations.

-   We will explain the recursive approach to clustering that combines
    observations and groups into a hierarchy of sets and called *hierarchical clustering*.

-   The validation of clusters is a challenge that can be overcome by
    using resampling-based approaches using the bootstrap that we will
    demonstrate in some single-cell data.

# Examples

![data-label="fig:cancerHC" ](http://bios221.stanford.edu/images/BreastHC.png)

![More homogeneous](http://bios221.stanford.edu/images/BreastSurvival.png)


A recent example of effective use of clustering is the realization that
even a disease such as Breast Cancer does not have a single molecular signature but
there are many Molecular  type of Cancers.

The groups can then be used to
provide more specific, optimized treatments.




## Also immune cells seen through flowcytometry

![FlowCytometry CD4/CD3](http://bios221.stanford.edu/images/FlowCytoTcells.gif)




## Clustering for Pattern Recognition 

![Cholera Map](http://bios221.stanford.edu/images/SnowMap_Points.png)

![LondonBombings](http://bios221.stanford.edu/images/LondonBlitz.png)



![Breast Cancer](http://bios221.stanford.edu/images/Breastcancerclusters.JPG){width="30%"}



Data Augmentation
=====================

This is a case where we can benefit from putting the data in an augmented format:
$(X,g)$ where $g$ is the unknown cluster the data come from.
The variable $g$ is categorical, taking on as many different
values as there are clusters.

Methods that add useful but unknown components to the data like this
are called `data augmentation` methods



There are already thousands of existing clustering algorithms combining
different choices for the basic distance used to compare observations.


We decompose these choices according to the following steps starting from an observation by feature matrix X, we have to choose 
a distance matrix from which to construct the clusters, hoping that they are well separated.

![ClusteringWorkflow](http://bios221.stanford.edu/images/ClusteringA.png){width="20%"}







Clustering : Grouping by similarity
==========================================
**Of a feather**
How are distances measured, or how is
similarity between observations defined ? 


Distances
========================

![Distances](http://bios221.stanford.edu/images/DistanceTriangle.png){width="30%"}

- Euclidean Distances SQRT(Sums of squares of coordinates).
- Mahalanobis distance (unequal weight per direction).
- Weighted euclidean distances, $\chi^2$,...
- Manhattan/Hamming/City Block =$\ell_1$.

![Taxicab](https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Manhattan_distance.svg/200px-Manhattan_distance.svg.png)


Ecology: multiple choices of distances
-----------------------------------------

If you know what is the relevant notion of `closeness' or similarity
for your data, you have (almost) solved the problem.

- Measurements of co-occurrence, ecological
sociological data for instance **Jaccard**. 

Observations are just sequences of 0's and 1's,
presence of 1's in the same spots does not present the
same importance as that of the 0's: Jaccard distance=1-JC.

$S$ and $T$, let's call it $f_{00}$.
The Jaccard index is
\begin{equation}
  J(S,T) = \frac{f_{11}}{f_{01}+f_{10}+f_{11}},
\end{equation}
and the \eindex{Jaccard dissimilarity}
\begin{equation}
d_J(S,T) = 1-J(S,T) = \frac{f_{01}+f_{10}}{f_{01}+f_{10}+f_{11}}.
\end{equation}



```r
mut=read.csv("/Users/susan/Books/CUBook/data/HIVmutations.csv")
mut[1:3,10:16]
```

```
##   p32I p33F p34Q p35G p43T p46I p46L
## 1    0    1    0    0    0    0    0
## 2    0    1    0    0    0    1    0
## 3    0    1    0    0    0    0    0
```



```r
library("vegan")
mutJ=vegdist(mut,"jaccard")
mutC=1-abs(cor(t(mut)))
round(mutJ,2)
```

```
##      1    2    3    4
## 2 0.80               
## 3 0.75 0.89          
## 4 0.90 0.78 0.85     
## 5 1.00 0.80 0.89 0.90
```

```r
round(as.dist(mutC),2)
```

```
##      1    2    3    4
## 2 0.70               
## 3 0.61 0.85          
## 4 0.87 0.64 0.84     
## 5 0.94 0.70 0.85 0.87
```

- Distances between `purified ' observations
(we transform the data first).


Distance functions available
===============================

[phyloseq distances](http://joey711.github.io/phyloseq/distance.html)


```r
require(vegan)
data(dune)
dist.dune=vegdist(dune)
symnum(as.matrix(dist.dune))
```

```
##    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
## 1                                                    
## 2  .                                                 
## 3  . .                                               
## 4  . .                                               
## 5  , . . .                                           
## 6  , . . ,                                           
## 7  . . . .                                           
## 8  , . . . , . .                                     
## 9  . . . . . . . .                                   
## 10 .   . . . .   . .                                 
## 11 . . . . , . . . . .                               
## 12 * , . . , , , . . ,  ,                            
## 13 + . . . , , , . . ,  ,  .                         
## 14 1 , , , + + + . , ,  +  ,  ,                      
## 15 1 * , , + + + . , +  ,  ,  ,  .                   
## 16 * + , , + + + . , +  +  .  ,  .  .                
## 17 + + + + , , , + + ,  ,  *  +  +  +  1             
## 18 , . , , . . . , , .  .  ,  ,  +  ,  +  ,          
## 19 1 + + , , , , , , ,  .  ,  +  +  ,  *  .  .       
## 20 1 * , , + + + . , +  +  ,  ,  .     .  *  ,  ,    
## attr(,"legend")
## [1] 0 ' ' 0.3 '.' 0.6 ',' 0.8 '+' 0.9 '*' 0.95 'B' 1
```

![](Lect6-ClusterSlidy_files/figure-slidy/heatmapDist-1.png)<!-- -->




%\includegraphics[width=3.2in,height=4in]{xkcdbirds_and_dinosaurs.png}


Non parametric Mixture Detection: k means and k-medoids
=========================================================
These methods are known as non-hierarchical Clustering or iterative relocation methods.
There are several initial choices to be made
with these methods and when the a priori knowledge
is not available this can be a drawback. The first is
the number of clusters suspected.
Each time the algorithm is run, initial `seeds'
for each cluster
have to be provided, for different starting configurations
the answers can be different.

The function  *kmeans* is the one that can be used in *R*.

Example of how `kmeans` works
=============================

```r
require(animation)
kmeans.ani(x = matrix(c(runif(100),runif(100)), ncol = 2, dimnames = list(NULL, c("X1", "X2"))), centers = 3, pch = 1:3,col = 1:3, hints = c("Move centers", "Find clusters"))
```

[Animated Gif](http://shabal.in/visuals/kmeans/2.html)


```r
#set.seed(95647745)
set.seed(952224887)

Xmat=matrix(runif(200),ncol=2)
nk=3
cents=matrix(runif(2*nk),ncol=2)
###Default distance=Euclidean
dist1=function(vec){dist(rbind(vec,cents[1,]))}
dist2=function(vec){dist(rbind(vec,cents[2,]))}
dist3=function(vec){dist(rbind(vec,cents[3,]))}

dists123=cbind(apply(Xmat,1,dist1),apply(Xmat,1,dist2),apply(Xmat,1,dist3))
clust0=apply(dists123,1,which.min)



out1=kmeans(Xmat,cents,iter.max=1)
out2=kmeans(Xmat,cents,iter.max=2)
out3=kmeans(Xmat,cents,iter.max=3)
plot(Xmat,type='n')
text(Xmat[,1],Xmat[,2],out1$cluster)
text(Xmat,col=c('red','blue','green')[out1$cluster],out1$cluster)
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-2-1.png)<!-- -->

```r
require(ggplot2)
data0=data.frame(x=Xmat[,1],y=Xmat[,2],clust=as.factor(clust0))
data1=data.frame(x=Xmat[,1],y=Xmat[,2],clust=as.factor(out1$cluster))
###Extra points, centers of clusters
cdg=data.frame(x=cents[,1],y=cents[,2],clust="c")
pp=ggplot(data=data0,aes(x= x, y = y, colour = clust, shape = clust))+
scale_shape_discrete(solid=T, guide=F) +
geom_point(data=data0, mapping=aes(x=x, y=y, shape=clust,colour=clust), size=5)+
 geom_point(data = cdg, colour = "black",size=5,shape=1)
pp
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-3-1.png)<!-- -->

```r
cents=out1$centers
cdg=data.frame(x=cents[,1],y=cents[,2],clust="c")
pp=ggplot(data=data1,aes(x= x, y = y, colour = clust, shape = clust))+
scale_shape_discrete(solid=T, guide=F) +
geom_point(data=data1, mapping=aes(x=x, y=y, shape=clust,colour=clust), size=5)+
 geom_point(data = cdg, colour = "black",size=5,shape=1)
pp
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-3-2.png)<!-- -->

Tight Clusters (Nuees Dynamiques)
==================================
A more evolved method called Dynamical Clusters
is also interesting because it repeats the process many
times and builds what is known as `strong forms'
which are groups of observations that end up in
the same classes for most possible initial configurations.

Have to choose how many classes they will be prior to the analysis.
Can depend on the initial seeds, so we may need to repeat the analyses over and over again.


k-medoids algorithm (PAM)
===========================

Very similar to kmeans but the centers are observation points.


1. For a given cluster assignment C find the observation in the cluster 
minimizing total distance to other points in that cluster: 
$$i^*_k = \mbox{argmin}_{\{i:C(i)=k\} }\sum_{C(i* )=k }D(x_i , x_i ). $$




Then $m_k = x_{i^*_k} , k = 1, 2,\ldots , K$ are the current estimates of the 
cluster centers. 

2. Given a current set of cluster centers 
$\{m_1 , \ldots, m_K \}$, minimize the total error by assigning each observation to the closest (current) cluster
center: 
$$C (i) = \mbox{argmin}_{1 \leq k \leq K }
D(x_i , m_k ).$$

Iterate steps 1 and 2 until the assignments do not change. 




Comparison of Truth, Kmeans on simulations
====================================================


![](Lect6-ClusterSlidy_files/figure-slidy/TrueGroups-1.png)<!-- -->

Compute kmeans classes with k=4
==================================

```r
#####
km4 <- kmeans(simul4$values,4)
plot(simul4$values, col = km4$cluster, xlab = "", ylab = "", main = "kmeans")
```

![](Lect6-ClusterSlidy_files/figure-slidy/KMgroups1-1.png)<!-- -->


Hierarchical Clustering
==========================
When the number of clusters is not known a priori,
it is useful to perform hierarchical clustering because
it provides a graphical summary that enables us to evaluate where the
cutoff for choosing clusters should occur.

This class of methods starts with all the observations making their own cluster and agglomerates gradually the
points together by similarity so the number of clusters decreases as points are clumped together 
into clusters, of course the user will have to make choices:

1. What is the relevant distance between observations to start with.
2. Which criteria should be used for grouping  clusters that have been composed. 
3. How should distances between these clusters be defined.


![Like a mobile](http://bios221.stanford.edu/images/CalderMobile.jpg)

Here are three representations of the **same** 
hierarchical clustering tree.

![The Same Tree](http://bios221.stanford.edu/images/SameTree-01.png){width="90%"}



# Methods of computing dissimilarities between the aggregated clusters




## Single linkage
Good for recognizing the number of clusters .... $\ldots$ ... But combs.
![image](http://bios221.stanford.edu/images/ClusterStepChoiceSingle1b.png){width="60.00000%"}

```r
my.hclustfun=function(d){hclust(d, method = "single")}
my.distfun=function(x) {vegdist(x)}
heatmap.2(as.matrix(dune),hclustfun=my.hclustfun,distfun=my.distfun,col=color) 
```

![](Lect6-ClusterSlidy_files/figure-slidy/singlelinkhc-1.png)<!-- -->
 This will separate the groups as much as possible,
$$ D_{12}=\min_{i \in C_1, i \in C_2 } d_{ij}. $$

String objects together to form
clusters, and the resulting clusters tend to represent long
``chains.'' or ``combs''. 

## Maximal linkage (or Complete linkage): 

![image](http://bios221.stanford.edu/images/ClusterStepChoiceComplete1b.png){width="60.00000%"}

Compact classes  .... one observation can alter groups.


```r
my.hclustfun=function(d){hclust(d, method = "complete")}
my.distfun=function(x) {vegdist(x)}
heatmap.2(as.matrix(dune),hclustfun=my.hclustfun,distfun=my.distfun,col=color) 
```

![](Lect6-ClusterSlidy_files/figure-slidy/completelink-1.png)<!-- -->

Furthest neighbor: the distances
between clusters are determined by the greatest distance between any
two objects in the different clusters. 
This method usually performs quite well in cases when
the objects actually form naturally distinct `clumps`. If the
clusters tend to be somehow elongated or of a `chain` type nature,
then this method is inappropriate. 


# Average
Classes have similar size and variance.


```r
my.hclustfun=function(d){hclust(d, method = "aver")}
my.distfun=function(x) {vegdist(x)}
color = rev(heat.colors(256))
heatmap.2(as.matrix(dune),hclustfun=my.hclustfun,distfun=my.distfun,col=color)                      
```

![](Lect6-ClusterSlidy_files/figure-slidy/heatmap2withimage-1.png)<!-- -->

 $$ D_{12}=\frac{1}{|C_1| |C_2|}\sum_{i \in C_1, i \in C_2 } d_{ij}$$
Unweighted pair-group average. 
(Goldilocks method)

```r
require(vegan)
hclust.aver <- hclust(dist.dune, method="aver")
plot(hclust.aver)
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-5-1.png)<!-- -->


- Weighted pair-group average. 

#### Centroid
More robust to outliers.

#### Ward

![image](http://bios221.stanford.edu/images/BetweenWithinb.png){width="70.00000%"}

- Minimising an inertia (sums of squares of distances within groups).
- Classes are small if high variability observations.
- An analysis of variance approach to evaluate the distances
between clusters. 
 Minimize the Sum
of Squares (SS) of any two (hypothetical) clusters that can be formed
at each step. 
This method is regarded as very efficient,
however, it tends to create clusters of small size. 




```r
vegemite(dune, hclust.aver)
```

```
##                               
##           111211 11    11    1
##           46507912334891856720
##  Comapalu 2.2.................
##  Callcusp 43.3................
##  Eleopalu 4854.......4........
##  Ranuflam 2224....2..2........
##  Airaprae ....23..............
##  Empenigr .....2..............
##  Agrostol 4745...454843.......
##  Juncarti .334.......44.......
##  Salirepe ...5.3........3.....
##  Hyporadi ....25.......2......
##  Chenalbu ........1...........
##  Alopgeni .4.....857253.....2.
##  Sagiproc .....3.42.5222......
##  Bracruta .444.3.4.222246262.2
##  Cirsarve ..........2.........
##  Juncbufo .......43...4....2..
##  Scorautu 2.2226.2222325533353
##  Elymrepe ......4..44.6..4..4.
##  Trifrepe 6.1..2.3221233225256
##  Anthodor ....44.........432.4
##  Poatriv  .2....2496545..64574
##  Poaprat  ....1.4.254444323444
##  Lolipere ......7..65427226656
##  Rumeacet .......2....2..563..
##  Bellpere .........22...22..32
##  Vicilath .............21....1
##  Planlanc ....2........33555.3
##  Achimill ....2.1........22234
##  Trifprat ...............252..
##  Bromhord ..........3....2.244
##   sites species 
##      20      30
```


```r
my.hclustfun=function(d){hclust(d, method = "aver")}
my.distfun=function(x) {vegdist(x)}
color = rev(heat.colors(256))
heatmap.2(as.matrix(dune),hclustfun=my.hclustfun,distfun=my.distfun,col=color)                      
```

![](Lect6-ClusterSlidy_files/figure-slidy/heatmapwithimage-1.png)<!-- -->


# Advantages and Disadvantages of the various distances between clumps
Tree shapes differ:
![Tree shapes](http://bios221.stanford.edu/images/HC3.jpg){width=25%}








Computing and interpreting hierarchical clustering trees
========================================================


```r
require(vegan)
hclust.aver <- hclust(dist.dune, method="aver")
plot(hclust.aver)
```

![](Lect6-ClusterSlidy_files/figure-slidy/hclustdune-1.png)<!-- -->


Hierarchical clustering is a bottom up approach where similar
observations and subclasses are assembled iteratively.

![image](http://bios221.stanford.edu/images/LinnaeusClass-01.png){width="80.00000%"}

The Figure above shows how Linnæus made nested clusters of
organisms according to more specific characteristics.

This hierarchical
organization has been useful in many fields and goes back to Aristotle
who postulated a  *ladder of nature* .









Plot the results of a hierarchical clustering assignment
=============================================================


```r
##############################################
hc = hclust(dist(simul4$values), method = "ward")
```

```
## The "ward" method has been renamed to "ward.D"; note new "ward.D2"
```

```r
memb <- cutree(hc, k = 4)
plot(simul4$values, col = memb, xlab = "", ylab = "", main = "hclust Euclidean ward") 
```

![](Lect6-ClusterSlidy_files/figure-slidy/KMgroups2-1.png)<!-- -->


Choosing the number of Clusters 
=======================================


```r
###############Compute the kmeans within group wss for k=1 to 9
wss = sum(apply(scale(simul4$value,scale=FALSE),2,function(x){x^2}))
for (k in 2:20) {
  km4 <- kmeans(simul4$values,k)
    wss = c(wss, sum(km4$withinss))
}
plot(1:20, wss, xlab='k', ylab='WSS(k)', type='l', lwd=2, col='red')
```

![](Lect6-ClusterSlidy_files/figure-slidy/wss-1.png)<!-- -->




```r
plot(1:20, log(wss), xlab='k', ylab='logWSS(k)', type='l', lwd=2, col='red')
```

![](Lect6-ClusterSlidy_files/figure-slidy/logwss-1.png)<!-- -->


```r
plot(hclust(dist(simul4$values), method = "ward"))
```

```
## The "ward" method has been renamed to "ward.D"; note new "ward.D2"
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-6-1.png)<!-- -->

[Detailed graphical account](http://stackoverflow.com/questions/15376075/cluster-analysis-in-r-determine-the-optimal-number-of-clusters)


Silhouette Plots
=======================

For each observation i, the silhouette width s(i) is defined as follows: 
Put a(i) = average dissimilarity between i and all other points of the cluster to which i belongs (if i is the only observation in its cluster, s(i) := 0 without further calculations).

For all other clusters C, put d(i,C) = average dissimilarity of i to all observations of C. 

The smallest of these d(i,C) is called $$ b(i) := min_C d(i,C) $$ and can be seen as the dissimilarity between i and its “neighbor” cluster, i.e., the nearest one to which it does not belong. Finally,
$$
s(i) := ( b(i) - a(i) ) / max( a(i), b(i) ).
$$


```r
library(fpc)
library(cluster)
d=simul4$values
asw <- numeric(20)
for (k in 2:20)
  asw[[k]] <- pam(d, k)$silinfo$avg.width
k.best <- which.max(asw)
#cat("Silhouette-optimal number of clusters:", k.best, "\n")
k.best
```

```
## [1] 4
```

```r
p4=pam(x=d,k=k.best)
si=silhouette(p4)
plot(si,col="red",main="Simulated Data")
```

![](Lect6-ClusterSlidy_files/figure-slidy/silhouette-1.png)<!-- -->


```r
library(cluster)
asw <- numeric(20)
for (k in 2:18)
  asw[[k]] <- pam(dune, k)$silinfo$avg.width
k.best <- which.max(asw)
cat("Silhouette-optimal number of clusters:", k.best, "\n")
```

```
## Silhouette-optimal number of clusters: 4
```

```r
p4=pam(x=dune,k=k.best)
si=silhouette(p4)
plot(si,col="red",main="Dune Data")
```

![](Lect6-ClusterSlidy_files/figure-slidy/dunesilhouette-1.png)<!-- -->


```r
ccas <- cascadeKM(decostand(dune, "hell"), 2, 15)
```

Calinski-Harabasz variance ratio
=======================================

Within and between sums of squares:

![Between and Within](http://bios221.stanford.edu/images/BetweenWithinSmall.png)

W in black and B in Red.

Calinski and Harabasz, 1974:
$$(n-k)*sum(\mbox{diag}(B))/((k-1)*sum(\mbox{diag}(W)))\qquad B \mbox{ between } W \mbox{ within}$$





```r
plot(nclusters, type = "h", xlab = "k clusters", ylab = "CH index", 
    main = "Optimal number of clusters: Simulated Data")
```

![](Lect6-ClusterSlidy_files/figure-slidy/ClusterChoicePlot-1.png)<!-- -->



```r
data.dist=dist.dune
data=dune
data.cluster = pam.clustering(data.dist, k = 3)
require(clusterSim)
nclusters = index.G1(data, data.cluster, d = data.dist, centrotypes = "medoids")
nclusters = NULL
for (k in 1:19) {
    if (k == 1) {
        nclusters[k] = NA
    } else {
        data.cluster_temp = pam.clustering(data.dist, k)
        nclusters[k] = index.G1(data, data.cluster_temp, d = data.dist, centrotypes = "medoids")
    }
}
plot(nclusters, type = "h", xlab = "k clusters", ylab = "CH index", 
    main = "Optimal number of clusters: Dune Data")
```

![](Lect6-ClusterSlidy_files/figure-slidy/DuneDataCH-1.png)<!-- -->

Gene Expression Clustering
==========================

```r
#load("http://bios221.stanford.edu/data/Msig3transp.RData")
load("/Users/susan/Dropbox/CaseStudies/Msig3transp.RData")
#####You'll need to load the data from the data folder to your computer 
#####and then load it
dim(Msig3transp)
```

```
## [1]  30 156
```

```r
head(Msig3transp[,1:10])
```

```
##                   X3968     X14831      X13492      X5108     X16348
## HEA26_EFFE_1 -2.6108361 -1.1857923 -0.05612926 -0.1470299  0.5230758
## HEA26_MEM_1  -2.2592865 -0.4718562  0.27730991  0.5438521 -0.3659554
## HEA26_NAI_1  -0.2719081  0.8170308  0.81269167  0.7198425 -0.9049818
## MEL36_EFFE_1 -2.2431022 -1.0806009 -0.23557156 -0.1760595  0.6406782
## MEL36_MEM_1  -2.6798807 -0.1463671  0.24909402  0.9519808 -0.2040837
## MEL36_NAI_1  -0.4685057  1.0693272  0.75844932  0.7898928 -0.7998404
##                     X585     X11495      X17522   X12908     X17992
## HEA26_EFFE_1 -0.01816524 -0.8553673  1.27731835 1.716015  0.4826907
## HEA26_MEM_1   0.10784211 -1.0245616  0.64556610 3.618092  1.2100542
## HEA26_NAI_1   0.74819063 -1.7309336  0.01931762 3.924107  1.7128855
## MEL36_EFFE_1  0.01000666 -0.9778569  1.35571272 1.418629 -0.4003710
## MEL36_MEM_1   0.16530245 -1.3276209  0.56192130 3.858240  0.7366370
## MEL36_NAI_1   0.92653015 -1.9024371 -0.05866747 3.941283  1.4401721
```

```r
dr=round(dist(Msig3transp),2)
heatmap(as.matrix(Msig3transp),labCol = "")
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-8-1.png)<!-- -->

```r
corM=cor(as.matrix(Msig3transp))
heatmap(corM,distfun=function(c)as.dist(1-c),labCol = "",labRow="")
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-8-2.png)<!-- -->

```r
corT=cor(as.matrix(t(Msig3transp)))
heatmap(corT,distfun=function(c)as.dist(1-c),labCol ="")
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-8-3.png)<!-- -->



```r
load("/Users/susan/Dropbox/CaseStudies/Msigbinary.save")
head(disjonct)
```

```
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13]
## [1,]   -1   -1    0   -1   -1   -1   -1   -1    0    -1    -1    -1    -1
## [2,]   -1   -1    1   -1    0    1   -1   -1    0    -1    -1     0    -1
## [3,]    0    0    1    0    0    1    0    0    1     0     0     0     0
## [4,]    0    1    1    0    1    1    0    1    1     0     1     0     0
## [5,]    1   -1   -1    1    0   -1    0   -1   -1     1     0     0     1
## [6,]    0    0    1    0    0    1    0    0    1     0     0     1     0
##      [,14] [,15] [,16] [,17] [,18] [,19] [,20] [,21] [,22] [,23] [,24]
## [1,]    -1     0    -1    -1     0    -1    -1     0    -1    -1     0
## [2,]     0     1    -1    -1     1    -1    -1     1    -1    -1     0
## [3,]     0     1     0     0     1     0     0     1     0     0     1
## [4,]     1     1     0     1     1     0     1     1     0     1     1
## [5,]     0    -1     1    -1    -1     0    -1    -1     1     0    -1
## [6,]     0     1     1     0     1     0     0     1     0     0     1
##      [,25] [,26] [,27] [,28] [,29] [,30]
## [1,]    -1    -1     0    -1    -1     0
## [2,]    -1     0     1    -1     0     1
## [3,]     0     0     1     0     0     1
## [4,]    -1     0     0     0     0     0
## [5,]     0    -1    -1     1     0    -1
## [6,]     0     0     1     0     0     1
```

```r
heatmap(as.matrix(disjonct),distfun=function(c)dist(c,"manhattan"),labCol = "")
```

![](Lect6-ClusterSlidy_files/figure-slidy/unnamed-chunk-9-1.png)<!-- -->

No need to invent a new Clustering Algorithm
==================================================

[too many already](http://cran.r-project.org/web/views/Cluster.html)


Diagnostic methods for numbers of clusters.
================================================================

- Resampling and rerunning the algorithm: ensembles...
- Gap Statistic
- Silhouette Plot 
- Calinski-Harabasz
- Looking for elbows in the WSS plots
- Look at the long edges in the hierarchical clustering.



```r
library("dplyr")
simul4=lapply(c(0,8),function(x){
lapply(c(0,8),function(y){
data.frame(x=rnorm(100,x,2),y=rnorm(100,y,2),class=paste(x,y,sep=""))
}) %>% do.call(rbind,.)
}) %>% do.call(rbind,.)
```


![](Lect6-ClusterSlidy_files/figure-slidy/GapStat-1.png)<!-- -->

## Example: Revisit Hiiragi
Let’s now use the method on a real example: we will reload the
 Hiiragi  data we explored in Lecture 3
[@Ohnishi2014]. 

We want to investigate the level of clustering of in
particular to investigate the hypothesis that some of cells in embyronic
day 3.5 ( E3.5 ) falls ‘naturally’ into two clusters
corresponding to while the data for embryonic day 3.25
( E3.25 ) do not.


```r
library("cluster")
library("Hiiragi2013")
data("x")
```






```r
###Pick the top 50 genes most variable in wt
ngenes=50
WT=x[,x$genotype=="WT"]
selFeats = order(rowVars(exprs(WT)), decreasing = TRUE)[seq_len(ngenes)]
submat=exprs(x[selFeats,])
rownames(submat)=fData(x)[selFeats, "symbol"]
z=t(submat)
resGAP=clusGap(z,FUN=pam1,K.max=10,verbose=FALSE)
```




In fact the default choice of  resGAP 
( globalSEmax : first value for which the gap(k) is not
larger than the global maximum within a standard error $s$) gives k=8,
whereas the choice recommended in @gap2001 (the smallest k such that
$gap(k) \geq gap(k+1) - s_{k+1}$) gives k=4.


```r
plot(resGAP)
```

![](Lect6-ClusterSlidy_files/figure-slidy/resGAPHiiragi-1.png)<!-- -->

```r
pam8=pam(z, k=8, cluster.only=TRUE)
pam4=pam(z, k=4, cluster.only=TRUE)
###Using the biological labels to understand the groups
table(pam8,pData(x)[names(pam8), "sampleGroup"])
```

```
##     
## pam8 E3.25 E3.5EPI E3.5KO E3.5PE E325KO E4.5EPI E4.5KO E4.5PE
##    1     4       0      0      0     15       0      0      0
##    2    20       2      0      0      0       0      0      0
##    3     6       0      8      0      2       0      0      0
##    4     5       8      0      1      0       0      0      0
##    5     1       1      0      0      0       0     10      0
##    6     0       0      0     10      0       0      0      0
##    7     0       0      0      0      0       0      0      4
##    8     0       0      0      0      0       4      0      0
```

```r
table(pam4,pData(x)[names(pam4), "sampleGroup"])
```

```
##     
## pam4 E3.25 E3.5EPI E3.5KO E3.5PE E325KO E4.5EPI E4.5KO E4.5PE
##    1     5       0      6      0     17       0      0      0
##    2    29       7      0      0      0       0      0      0
##    3     1       1      0     11      0       0      0      4
##    4     1       3      2      0      0       4     10      0
```


One of the most important parts of clustering is the projection
supplementary biological information onto the clusters as we have done
in the tables above.

## Cluster Validation using the Bootstrap


![BootstrapCluster](http://bios221.stanford.edu/images/BootstrapNPClust.png){width="99.00000%"}

We saw the bootstrap principle in Lecture ; in a perfect
world, we would use many samples of data from the same distribution and
generate a clustering for each data set and then see how the clusterings
change using an index such as those we used above to compare
clusterings.

However, in fact we are going to create new data sets simply by taking
subsamples of the data and looking at the different clusterings we get
each time and comparing them. @gap2001 recommend using bootstrap
resampling to infer the number of clusters using the gap statistic.


![BootstrapCluster](http://bios221.stanford.edu/images/BootstrapNPEmp.png){width="59.00000%"}

# Application

Hiiragi data [@Ohnishi2014]. 

Investigation of the hypothesis that the inner cell mass
(ICM) of the mouse blastocyst in embyronic day 3.5 ( E3.5 )
falls ‘naturally’ into two clusters corresponding to pluripotent
epiblast (EPI) versus primitive endoderm (PE) while the data for
embryonic day 3.25 ( E3.25 ) do not.

We will not use the true group labels in the clustering step and only
use them in the final interpretation of the results. We will use a
bootstrap applied to the two different data sets ( E3.5 ) and
( E3.25 ) separately. Each step of the bootstrap will
generate a clustering of a random subset of the data and we will need to
compare these through a consensus of an ensemble of clusters. There is a
useful framework for this in the  `clue` 
package.


```r
clusterResampling = function(x, ngenes, k = 2, B = 250, prob = 0.67) {
  mat = exprs(x)
  ce = cl_ensemble(list = lapply(seq_len(B), function(b) {
    selSamps = sample(ncol(mat),size =round(prob*ncol(mat)),replace = F)
    submat = mat[, selSamps, drop = FALSE]
    selFeats = order(rowVars(submat), decreasing =TRUE)[seq_len(ngenes)]
    submat = submat[selFeats,, drop = FALSE]
    pamres = pam(t(submat), k = k)
    pred = cl_predict(pamres, t(mat[selFeats, ]), "memberships")
    as.cl_partition(pred)
  }))
  cons = cl_consensus(ce)
  ag = sapply(ce, cl_agreement, y = cons)
  return(list(agreements = ag, consensus = cons))
}
```



To summarize, the function  clusterResampling  performs the
following steps:

1.  Draw a random subset of the data (the data are either all
    E3.25 or all E3.5 samples) by selecting 67% of the samples
    without replacement.

2.  Select the top  ngenes  (see below) features by overall
    variance (in the subset) .

3.  Apply $k$-means clustering, and predict the cluster
    memberships of the samples that were not in the subset with the
     cl_predict  method, through their proximity to the
    cluster centres.

4.  Repeat steps 1-3 for  B  $=250$ times.

5.  Apply consensus clustering ( cl_consensus ).

6.   For each of the  B  $=250$ clusterings,
    measure the agreement with the consensus
    ( cl_agreement ); here, good agreement is indicated by a
    value of 1, and less agreement by smaller values. If the agreement
    is generally high, then the clustering into $k$ classes can be
    considered stable and reproducible; inversely, if it is low, then no
    stable partition of the samples into $k$ clusters is evident.

As a measure of between-cluster distance for the consensus clustering,
the *Euclidean* dissimilarity of the memberships is used, i. e., the
square root of the minimal sum of the squared differences of
$\mathbf{u}$ and all column permutations of $\mathbf{v}$, where
$\mathbf{u}$ and $\mathbf{v}$ are the cluster membership matrices. As
agreement measure for step 6, the quantity $1 - d /
m$ is used, where $d$ is the Euclidean dissimilarity, and $m$ is an
upper bound for the maximal Euclidean dissimilarity.





```r
E325=clusterResampling(x[, unlist(groups[c("E3.25")])], ngenes = 20)
E35=clusterResampling(x[, unlist(groups[c("E3.5 (EPI)", "E3.5 (PE)")])],ngenes = 20)
ce = list(  "E3.25" = E325,"E3.5"  = E35)
```

Cluster stability analysis with E3.25 and E3.5 (WT:wild type) samples.
(Left: boxplot of the cluster agreements with the consensus, for
 B =250 Clusterings; 1 indicates perfect agreement, and the
value decreases with worse agreement. Right: membership probabilities of
the consensus clustering; colors are as in the left panel. For E3.25,
the probabilities are diffuse, indicating that the individual
(resampled) clusterings disagree a lot, whereas for E3.5, the
distribution is bimodal, with only one ambiguous sample.)



```r
colours  = c(sampleColourMap["E3.25"], brewer.pal(9,"Set1")[9])
boxplot(lapply(ce, `[[`, "agreements"), ylab = "agreement probabilities", col = colours)
```

![Results from Clue](Lect6-ClusterSlidy_files/figure-slidy/figClue1-1.png)

The results are shown in Figures above and below. They confirm the
hypothesis that the E.35 data fall into two clusters.







```r
mems = lapply(ce, function(x) sort(cl_membership(x$consensus)[, 1]))
mgrp = lapply(seq(along = mems), function(i) rep(i, times = length(mems[[i]])))
myjitter = function(x) x+seq(-.4, +.4, length.out = length(x))
plot(unlist(lapply(mgrp, myjitter)), unlist(mems),
     col = colours[unlist(mgrp)], ylab = "membership probabilities",
     xlab = "consensus clustering", xaxt = "n", pch = 16)
text(x = 1:2, y = par("usr")[3], labels = c("E3.25","E3.5"), adj = c(0.5, 1.4), xpd = NA)
```

![](Lect6-ClusterSlidy_files/figure-slidy/figClue1b-1.png)<!-- -->

Cluster stability analysis with E3.25 and E3.5 (WT:wild type) samples. (Left: boxplot of
the cluster agreements with the consensus, for  B =250
Clusterings; 1 indicates perfect agreement, and the value decreases with
worse agreement. Right: membership probabilities of the consensus
clustering; colors are as in the left panel. For E3.25, the
probabilities are diffuse, indicating that the individual (resampled)
clusterings disagree a lot, whereas for E3.5, the distribution is
bimodal, with only one ambiguous sample.)






# Unequal size clusters

## Noisy observations with different baseline frequencies

Suppose that we have a bivariate distribution of observations made with
the same error variances, however the sampling is done from two groups
which have very different baseline frequencies.

Suppose, as an example, that the errors are continuous independent
bivariate normally distributed. We have $10^{3}$ of  seq1 
and $10^{5}$ of  seq2 , as generated for instance by the
code:


```r
library("mixtools")
```

```
## mixtools package, version 1.1.0, Released 2017-03-10
## This package is based upon work supported by the National Science Foundation under Grant No. SES-0518772.
```

```
## 
## Attaching package: 'mixtools'
```

```
## The following object is masked from 'package:gtools':
## 
##     ddirichlet
```

```r
library("ggplot2")
seq1 = rmvnorm(n = 1e3, mu = -c(1, 1), sigma = 0.5*diag(c(1, 1)))
seq2 = rmvnorm(n = 1e5, mu =  c(1, 1), sigma = 0.5*diag(c(1, 1)))
twogr = data.frame(
  rbind(seq1, seq2),
  seq = factor(c(rep(1, nrow(seq1)),
                 rep(2, nrow(seq2))))
)
colnames(twogr)[1:2] = c("x", "y")
ggplot(twogr, aes(x = x, y = y, colour = seq,fill = seq)) +
  geom_hex(alpha = 0.5, bins = 50) + coord_fixed()
```

![Unequal size clusters](Lect6-ClusterSlidy_files/figure-slidy/seqradius-1.png)



The observed values would look as in Figure \@ref(fig:seq:radius).


**Question**
Take the data  seq1  and  seq2 
and assign them to groups according to a hard distance threshold with
balls of radius.


![image](http://bios221.stanford.edu/images/book_icon.png){width="33.00000%"}


See @kahneman2011 for a book-length treatment of our natural heuristics
and the ways in which they can mislead us when we make probability
calculations (we recommend especially chapters 14 and 15).

Simulate  n  reads of length  len , when error
probability is  perr , and all we care about whether a base
was called correctly ( TRUE ) or not ( FALSE ).


```r
n    = 5e3
len  = 200
perr = 0.001
seqs = matrix(runif(n * len) >= perr, nrow = n, ncol = len)
```
Now, compute all pairwise distances between reads

```r
dists = as.matrix(dist(seqs, method = "manhattan"))
```
%
For various values of number of reads `k` (from 10 to `n`),
the maximum distance within this set of reads.
%

```r
library("tibble")
dfseqs = tibble(
  k = 10 ^ seq(1, log10(n), length.out = 20),
  diameter = vapply(k, function(i) {
    s = sample(n, i)
    max(dists[s, s])
    }, numeric(1)))
ggplot(dfseqs, aes(x = k, y = diameter)) +
          geom_point() + geom_smooth()
```

```
## `geom_smooth()` using method = 'loess'
```

![](Lect6-ClusterSlidy_files/figure-slidy/diameter-1.png)<!-- -->


We will now use reference probabilities to improve and denoise
16SrRNA-read clustering.

## Denoising 16S rRNA sequences

### What are the data?

There are so-called  variable regions of the 16SrRNA gene in bacteria that are taxa
specific: fingerprint that enables
 *taxon* [^4] identification. 
 

FASTQ-files $\longrightarrow$ Iterative alternating $\longrightarrow$ probabilistic noise
                *de novo* 
$\longrightarrow$(RSV). 


### Infer sequence variants

We start by loading the  dada2  that provides all the
function to denoise these data using de novo clustering:

```r
library(dada2)
```

```
## Loading required package: Rcpp
```
The DADA method (Divisive Amplicon Denoising Algorithm)[@Rosen:2012]
relies on a parameterized model of substitution errors that
distinguishes sequencing errors from real biological variation. The
model computes the probabilities of seeing an ${\sf A}$ instead of a
${\sf C}$ regardless of its position along the sequence. Because error
rates vary substantially between sequencing runs and PCR protocols, the
model parameters are estimated from the data themselves using an EM-type
approach. A read is classified as noisy or exact given the current
parameters, then the noise model parameters are updated accordingly[^7].

The dereplicated sequences are read in and then divisive denoising and
estimation is run with the  dada  function as in the
following code:


```r
# Download "http://bios221.stanford.edu/data/derepFs.rds"
# Download "http://bios221.stanford.edu/data/derepRs.rds"
derepFs=readRDS("/Users/susan/Books/CUBook/data/derepFs.rds")
derepRs=readRDS("/Users/susan/Books/CUBook/data/derepRs.rds")
###Intermediary, only run the first time
ddF = dada(derepFs, err = NULL, selfConsist = TRUE)
ddR = dada(derepRs, err = NULL, selfConsist = TRUE)
```


Fit between the observed error rates
(black points) and the fitted error rates (black lines).



```r
plotErrors(ddF)
```

![](Lect6-ClusterSlidy_files/figure-slidy/rerrorprofile1-1.png)<!-- -->

Forward transition error rates as provided by
 plotErrors(ddF) , this shows the frequencies of each type of
nucleotide transition as a function of quality.


Once the errors have been estimated, the algorithm is rerun on the data
to find the sequence variants:


```r
dadaFs = dada(derepFs, err=ddF[[1]]$err_out, pool = TRUE)
dadaRs = dada(derepRs, err=ddR[[1]]$err_out, pool = TRUE)
```




```r
mergers = mergePairs(dadaFs, derepFs, dadaRs, derepRs)
```


Contingency table
the common Ribosomal Strain Variants (RSV):


```r
seqtab.all = makeSequenceTable(mergers[!grepl("Mock", names(mergers))])
```


Chimera are sequences that are artificially created during PCR
amplification by the melding of different, usually only two, of the
original sequences together. To complete our denoising workflow, we
remove them with a call to the function  removeBimeraDenovo ,
leaving us with a clean contingency table we will use later on.


```r
seqtab = removeBimeraDenovo(seqtab.all)
```

```
## As of the 1.4 release, the default method changed to consensus (from pooled).
```


Summary of Clustering Methods
===============================

- Unsupervised methods.
- Choices of distances (garbage in, garbage out)
- Two approaches: partitionning and aggregation.
- Choices of assembly of classes criteria
- Choice of number of clusters.
- A clustering algorithm will always try to cluster the data, even if the data aren't grouped.
- Need validation and evaluation: create ensembles of clusters with the Bootstrap or restarts.
- Leaving out `outliers` is possible but be honest: record and explain.



# Summary in details

Distances

:   We saw at the start of the Lecture how finding the
    **right**  distance is an essential first step in a
    clustering analysis, this is a case when the  *garbage in,
    garbage out*  motto is in full force. Always choose a distance
    which is scientifically meaningful and compare output from as many
    distances as possible; sometimes the same data require different
    distances when different scientific objectives are pursued.

Partionning and Aggregating

:   We saw two different types of clustering approaches: iterative
    partitionning approaches such as kmeans and kmedoids (PAM) that
    alternated between estimating the clusters and assigning points to
    them and hierarchical clustering approaches that agglomerate points
    and then small clusters into larger ones in a nested sequence of
    sets that can be represented by hierarchical clustering trees.

Density based methods

:   We saw examples of using clustering for single cell measurements and
    how to supplement standard with density-based clustering that works
    quite well for lower dimensioanl data where sparsity is not
    an issue.

Cluster validation

:   Clustering algorithms  *always*  deliver clusters so we
    need to assess their quality and the number of clusters to
    choose carefully.

    These validation steps are done using visualization tools and
    repeating the clustering on many resamples of the data. We saw how
    statistics such as the  wss/bss  or
    $\log(\mbox{\tt wss})$ can calibrated using simulation on data where
    we understand the group structure and can provides useful benchmarks
    for choosing the number of cluster.

    Of course, the use of biologically relevant information to inform
    and confirm the meaning of clusters is always the best
    validation approach.

Unequal cluster sizes and unequal sampling

:   Finally we saw that distances are not everything, taking into
    account baseline frequencies and local densities when clustering can
    be important; we showed this in a case study of how to use
    clustering to denoise 16s rRNA sequence reads.





A little politics ... as a transition
=================================================

```r
house=read.table("/Users/susan/Dropbox/CaseStudies/votes.txt")
head(house[,1:10])
```

```
##     V1   V2   V3   V4   V5  V6  V7   V8   V9  V10
## 1 -0.5 -0.5  0.5 -0.5  0.0 0.5 0.5  0.5  0.5  0.5
## 2 -0.5 -0.5  0.5 -0.5  0.0 0.5 0.5  0.5  0.5  0.5
## 3  0.5  0.5 -0.5  0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5
## 4  0.5  0.5 -0.5  0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5
## 5  0.5  0.5 -0.5  0.5 -0.5 0.5 0.5 -0.5 -0.5 -0.5
## 6 -0.5 -0.5  0.5 -0.5  0.0 0.5 0.5  0.5  0.5  0.5
```

```r
party=scan("/Users/susan/Dropbox/CaseStudies/party.txt")
#table(party)
```

```
## Loading required package: kernlab
```

```
## 
## Attaching package: 'kernlab'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     alpha
```

```
## The following object is masked from 'package:permute':
## 
##     how
```

Plot of Votes 2005
=========================

```r
require(scatterplot3d)
```

```
## Loading required package: scatterplot3d
```

```r
house.cmds=cmdscale(disthouse,k=20,eig=TRUE)
round(house.cmds$eig[1:20],1)
```

```
##  [1] 63.4  1.8  1.6  1.0  0.6  0.6  0.4  0.4  0.4  0.3  0.3  0.3  0.3  0.3
## [15]  0.3  0.3  0.3  0.2  0.2  0.2
```

```r
scatterplot3d(house.cmds$points[,1:3])
```

![](Lect6-ClusterSlidy_files/figure-slidy/scatterplotvote-1.png)<!-- -->

Plot of Votes 2005
=========================

```r
scatterplot3d(house.cmds$points[,1:3],color=mycols[party+1])
```

![](Lect6-ClusterSlidy_files/figure-slidy/scatter3dcol-1.png)<!-- -->

Plot of Votes 2005
=========================

```r
house.kpca=kpca(house.K)
scatterplot3d(rotated(house.kpca)[,1:3])
```

![](Lect6-ClusterSlidy_files/figure-slidy/kernelvoteplot-1.png)<!-- -->

Plot of Votes 2005
=========================

```r
house.kpca=kpca(house.K)
scatterplot3d(rotated(house.kpca)[,1:3],color=mycols[party+1])
```

![](Lect6-ClusterSlidy_files/figure-slidy/kernelvoteplotcol-1.png)<!-- -->

Plot of Votes 2005 (interactive)
======================================

```
library(rgl)
plot3d(rotated(house.kpca),col=mycols[party+1])
```



[Multivariate methods](./PCA_SVD_Slides.html)
