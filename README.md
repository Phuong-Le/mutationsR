
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mutationsR

<!-- badges: start -->
<!-- badges: end -->

mutationsR is a tool to manipulate mutation data

## Installation

You can install the development version of mutationsR like so:

``` r
#### installing the dependencies
# install pacman
if (!require("pacman")) install.packages("pacman")
# install dependencies from CRAN
pacman::p_install(c(devtools, ggplot2, dplyr, ggpubr))
# install Biostrings
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Biostrings")
# install graphicsPLr from GitHub
if (!require("graphicsPLr")) devtools::install_github('Phuong-Le/graphicsPLr')

# the package
devtools::install_github('Phuong-Le/mutationsR')
```

## Example

Manipulating mutations as strings, you can get the central mutations
from their k-mer context, get the wildtype sequence and get reverse
complementary sequences.

``` r
library(mutationsR)
## 
## getting the central mutation
get_mut('A[C>T]G')
#> [1] "C>T"
get_mut('C>T')
#> [1] "C>T"
## getting the wildtype mutation
get_wt_seq('A[C>T]G')
#> [1] "ACG"
## getting reverse complementary mutations
rv_context('A[C>G]T')
#> [1] "A[G>C]T"
# this can be expanded so that all mutations from C and T are remained, and all mutations from A and G are converted to their reverse complementary counterparts
strand_symmetric('A[C>G]T')
#> [1] "A[C>G]T"
strand_symmetric('A[A>G]T')
#> [1] "A[T>C]T"
```

If you have a MAF file (mutation data provided by the ICGC portal), you
can compute the k-mer mutations, given the reference genome sequence
like so

``` r
library(mutationsR)
if (requireNamespace("seqinr", quietly = TRUE)) {
mut_dt = data.frame(donor_id = c('PD1','PD2'), chromosome = c('3', 'X'), chrom_start = c(5,7), chrom_end = c(5,7), reference_genome_allele = c('A','C'), mutated_from_base = c('A','C'), mutated_to_base = c('T', 'A'))
seq = seqinr::s2c('AGCTAGCTGA')
get_context = get_context_param(seq, k = 3)
apply(mut_dt, MARGIN = 1, get_context)
}
#> [1] "T[A>T]G" "G[C>A]T"
```

If you need to get all mutation contexts, given a k-mer size, do the
following (this is currently strand symmetric only)

``` r
library(mutationsR)
gen_contexts(1)
#> [1] "C>A" "C>G" "C>T" "T>A" "T>C" "T>G"
gen_contexts(3)
#>  [1] "A[C>A]A" "A[C>A]C" "A[C>A]G" "A[C>A]T" "C[C>A]A" "C[C>A]C" "C[C>A]G"
#>  [8] "C[C>A]T" "G[C>A]A" "G[C>A]C" "G[C>A]G" "G[C>A]T" "T[C>A]A" "T[C>A]C"
#> [15] "T[C>A]G" "T[C>A]T" "A[C>G]A" "A[C>G]C" "A[C>G]G" "A[C>G]T" "C[C>G]A"
#> [22] "C[C>G]C" "C[C>G]G" "C[C>G]T" "G[C>G]A" "G[C>G]C" "G[C>G]G" "G[C>G]T"
#> [29] "T[C>G]A" "T[C>G]C" "T[C>G]G" "T[C>G]T" "A[C>T]A" "A[C>T]C" "A[C>T]G"
#> [36] "A[C>T]T" "C[C>T]A" "C[C>T]C" "C[C>T]G" "C[C>T]T" "G[C>T]A" "G[C>T]C"
#> [43] "G[C>T]G" "G[C>T]T" "T[C>T]A" "T[C>T]C" "T[C>T]G" "T[C>T]T" "A[T>A]A"
#> [50] "A[T>A]C" "A[T>A]G" "A[T>A]T" "C[T>A]A" "C[T>A]C" "C[T>A]G" "C[T>A]T"
#> [57] "G[T>A]A" "G[T>A]C" "G[T>A]G" "G[T>A]T" "T[T>A]A" "T[T>A]C" "T[T>A]G"
#> [64] "T[T>A]T" "A[T>C]A" "A[T>C]C" "A[T>C]G" "A[T>C]T" "C[T>C]A" "C[T>C]C"
#> [71] "C[T>C]G" "C[T>C]T" "G[T>C]A" "G[T>C]C" "G[T>C]G" "G[T>C]T" "T[T>C]A"
#> [78] "T[T>C]C" "T[T>C]G" "T[T>C]T" "A[T>G]A" "A[T>G]C" "A[T>G]G" "A[T>G]T"
#> [85] "C[T>G]A" "C[T>G]C" "C[T>G]G" "C[T>G]T" "G[T>G]A" "G[T>G]C" "G[T>G]G"
#> [92] "G[T>G]T" "T[T>G]A" "T[T>G]C" "T[T>G]G" "T[T>G]T"
```

You can also plot mutation spectra, for example

``` r
library(mutationsR)
kmer = gen_contexts(3)
value = 1:96
spectra_dt = data.frame(kmer = kmer, value = value)
spectra_plot(spectra_dt)
```

<img src="man/figures/README-mutation spectra-1.png" width="100%" />
