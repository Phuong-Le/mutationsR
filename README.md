
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mutationsR

<!-- badges: start -->
<!-- badges: end -->

mutationsR is a tool to manipulate mutation data

## Installation

You can install the development version of mutationsR like so:

``` r
# FILL THIS IN! HOW CAN PEOPLE INSTALL YOUR DEV PACKAGE?
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
#>  [1] "A[C>A]A" "C[C>A]A" "G[C>A]A" "T[C>A]A" "A[C>A]C" "C[C>A]C" "G[C>A]C"
#>  [8] "T[C>A]C" "A[C>A]G" "C[C>A]G" "G[C>A]G" "T[C>A]G" "A[C>A]T" "C[C>A]T"
#> [15] "G[C>A]T" "T[C>A]T" "A[C>G]A" "C[C>G]A" "G[C>G]A" "T[C>G]A" "A[C>G]C"
#> [22] "C[C>G]C" "G[C>G]C" "T[C>G]C" "A[C>G]G" "C[C>G]G" "G[C>G]G" "T[C>G]G"
#> [29] "A[C>G]T" "C[C>G]T" "G[C>G]T" "T[C>G]T" "A[C>T]A" "C[C>T]A" "G[C>T]A"
#> [36] "T[C>T]A" "A[C>T]C" "C[C>T]C" "G[C>T]C" "T[C>T]C" "A[C>T]G" "C[C>T]G"
#> [43] "G[C>T]G" "T[C>T]G" "A[C>T]T" "C[C>T]T" "G[C>T]T" "T[C>T]T" "A[T>A]A"
#> [50] "C[T>A]A" "G[T>A]A" "T[T>A]A" "A[T>A]C" "C[T>A]C" "G[T>A]C" "T[T>A]C"
#> [57] "A[T>A]G" "C[T>A]G" "G[T>A]G" "T[T>A]G" "A[T>A]T" "C[T>A]T" "G[T>A]T"
#> [64] "T[T>A]T" "A[T>C]A" "C[T>C]A" "G[T>C]A" "T[T>C]A" "A[T>C]C" "C[T>C]C"
#> [71] "G[T>C]C" "T[T>C]C" "A[T>C]G" "C[T>C]G" "G[T>C]G" "T[T>C]G" "A[T>C]T"
#> [78] "C[T>C]T" "G[T>C]T" "T[T>C]T" "A[T>G]A" "C[T>G]A" "G[T>G]A" "T[T>G]A"
#> [85] "A[T>G]C" "C[T>G]C" "G[T>G]C" "T[T>G]C" "A[T>G]G" "C[T>G]G" "G[T>G]G"
#> [92] "T[T>G]G" "A[T>G]T" "C[T>G]T" "G[T>G]T" "T[T>G]T"
gen_contexts(5)
#>    [1] "AA[C>A]AA" "CA[C>A]AA" "GA[C>A]AA" "TA[C>A]AA" "AC[C>A]AA" "CC[C>A]AA"
#>    [7] "GC[C>A]AA" "TC[C>A]AA" "AG[C>A]AA" "CG[C>A]AA" "GG[C>A]AA" "TG[C>A]AA"
#>   [13] "AT[C>A]AA" "CT[C>A]AA" "GT[C>A]AA" "TT[C>A]AA" "AA[C>A]CA" "CA[C>A]CA"
#>   [19] "GA[C>A]CA" "TA[C>A]CA" "AC[C>A]CA" "CC[C>A]CA" "GC[C>A]CA" "TC[C>A]CA"
#>   [25] "AG[C>A]CA" "CG[C>A]CA" "GG[C>A]CA" "TG[C>A]CA" "AT[C>A]CA" "CT[C>A]CA"
#>   [31] "GT[C>A]CA" "TT[C>A]CA" "AA[C>A]GA" "CA[C>A]GA" "GA[C>A]GA" "TA[C>A]GA"
#>   [37] "AC[C>A]GA" "CC[C>A]GA" "GC[C>A]GA" "TC[C>A]GA" "AG[C>A]GA" "CG[C>A]GA"
#>   [43] "GG[C>A]GA" "TG[C>A]GA" "AT[C>A]GA" "CT[C>A]GA" "GT[C>A]GA" "TT[C>A]GA"
#>   [49] "AA[C>A]TA" "CA[C>A]TA" "GA[C>A]TA" "TA[C>A]TA" "AC[C>A]TA" "CC[C>A]TA"
#>   [55] "GC[C>A]TA" "TC[C>A]TA" "AG[C>A]TA" "CG[C>A]TA" "GG[C>A]TA" "TG[C>A]TA"
#>   [61] "AT[C>A]TA" "CT[C>A]TA" "GT[C>A]TA" "TT[C>A]TA" "AA[C>A]AC" "CA[C>A]AC"
#>   [67] "GA[C>A]AC" "TA[C>A]AC" "AC[C>A]AC" "CC[C>A]AC" "GC[C>A]AC" "TC[C>A]AC"
#>   [73] "AG[C>A]AC" "CG[C>A]AC" "GG[C>A]AC" "TG[C>A]AC" "AT[C>A]AC" "CT[C>A]AC"
#>   [79] "GT[C>A]AC" "TT[C>A]AC" "AA[C>A]CC" "CA[C>A]CC" "GA[C>A]CC" "TA[C>A]CC"
#>   [85] "AC[C>A]CC" "CC[C>A]CC" "GC[C>A]CC" "TC[C>A]CC" "AG[C>A]CC" "CG[C>A]CC"
#>   [91] "GG[C>A]CC" "TG[C>A]CC" "AT[C>A]CC" "CT[C>A]CC" "GT[C>A]CC" "TT[C>A]CC"
#>   [97] "AA[C>A]GC" "CA[C>A]GC" "GA[C>A]GC" "TA[C>A]GC" "AC[C>A]GC" "CC[C>A]GC"
#>  [103] "GC[C>A]GC" "TC[C>A]GC" "AG[C>A]GC" "CG[C>A]GC" "GG[C>A]GC" "TG[C>A]GC"
#>  [109] "AT[C>A]GC" "CT[C>A]GC" "GT[C>A]GC" "TT[C>A]GC" "AA[C>A]TC" "CA[C>A]TC"
#>  [115] "GA[C>A]TC" "TA[C>A]TC" "AC[C>A]TC" "CC[C>A]TC" "GC[C>A]TC" "TC[C>A]TC"
#>  [121] "AG[C>A]TC" "CG[C>A]TC" "GG[C>A]TC" "TG[C>A]TC" "AT[C>A]TC" "CT[C>A]TC"
#>  [127] "GT[C>A]TC" "TT[C>A]TC" "AA[C>A]AG" "CA[C>A]AG" "GA[C>A]AG" "TA[C>A]AG"
#>  [133] "AC[C>A]AG" "CC[C>A]AG" "GC[C>A]AG" "TC[C>A]AG" "AG[C>A]AG" "CG[C>A]AG"
#>  [139] "GG[C>A]AG" "TG[C>A]AG" "AT[C>A]AG" "CT[C>A]AG" "GT[C>A]AG" "TT[C>A]AG"
#>  [145] "AA[C>A]CG" "CA[C>A]CG" "GA[C>A]CG" "TA[C>A]CG" "AC[C>A]CG" "CC[C>A]CG"
#>  [151] "GC[C>A]CG" "TC[C>A]CG" "AG[C>A]CG" "CG[C>A]CG" "GG[C>A]CG" "TG[C>A]CG"
#>  [157] "AT[C>A]CG" "CT[C>A]CG" "GT[C>A]CG" "TT[C>A]CG" "AA[C>A]GG" "CA[C>A]GG"
#>  [163] "GA[C>A]GG" "TA[C>A]GG" "AC[C>A]GG" "CC[C>A]GG" "GC[C>A]GG" "TC[C>A]GG"
#>  [169] "AG[C>A]GG" "CG[C>A]GG" "GG[C>A]GG" "TG[C>A]GG" "AT[C>A]GG" "CT[C>A]GG"
#>  [175] "GT[C>A]GG" "TT[C>A]GG" "AA[C>A]TG" "CA[C>A]TG" "GA[C>A]TG" "TA[C>A]TG"
#>  [181] "AC[C>A]TG" "CC[C>A]TG" "GC[C>A]TG" "TC[C>A]TG" "AG[C>A]TG" "CG[C>A]TG"
#>  [187] "GG[C>A]TG" "TG[C>A]TG" "AT[C>A]TG" "CT[C>A]TG" "GT[C>A]TG" "TT[C>A]TG"
#>  [193] "AA[C>A]AT" "CA[C>A]AT" "GA[C>A]AT" "TA[C>A]AT" "AC[C>A]AT" "CC[C>A]AT"
#>  [199] "GC[C>A]AT" "TC[C>A]AT" "AG[C>A]AT" "CG[C>A]AT" "GG[C>A]AT" "TG[C>A]AT"
#>  [205] "AT[C>A]AT" "CT[C>A]AT" "GT[C>A]AT" "TT[C>A]AT" "AA[C>A]CT" "CA[C>A]CT"
#>  [211] "GA[C>A]CT" "TA[C>A]CT" "AC[C>A]CT" "CC[C>A]CT" "GC[C>A]CT" "TC[C>A]CT"
#>  [217] "AG[C>A]CT" "CG[C>A]CT" "GG[C>A]CT" "TG[C>A]CT" "AT[C>A]CT" "CT[C>A]CT"
#>  [223] "GT[C>A]CT" "TT[C>A]CT" "AA[C>A]GT" "CA[C>A]GT" "GA[C>A]GT" "TA[C>A]GT"
#>  [229] "AC[C>A]GT" "CC[C>A]GT" "GC[C>A]GT" "TC[C>A]GT" "AG[C>A]GT" "CG[C>A]GT"
#>  [235] "GG[C>A]GT" "TG[C>A]GT" "AT[C>A]GT" "CT[C>A]GT" "GT[C>A]GT" "TT[C>A]GT"
#>  [241] "AA[C>A]TT" "CA[C>A]TT" "GA[C>A]TT" "TA[C>A]TT" "AC[C>A]TT" "CC[C>A]TT"
#>  [247] "GC[C>A]TT" "TC[C>A]TT" "AG[C>A]TT" "CG[C>A]TT" "GG[C>A]TT" "TG[C>A]TT"
#>  [253] "AT[C>A]TT" "CT[C>A]TT" "GT[C>A]TT" "TT[C>A]TT" "AA[C>G]AA" "CA[C>G]AA"
#>  [259] "GA[C>G]AA" "TA[C>G]AA" "AC[C>G]AA" "CC[C>G]AA" "GC[C>G]AA" "TC[C>G]AA"
#>  [265] "AG[C>G]AA" "CG[C>G]AA" "GG[C>G]AA" "TG[C>G]AA" "AT[C>G]AA" "CT[C>G]AA"
#>  [271] "GT[C>G]AA" "TT[C>G]AA" "AA[C>G]CA" "CA[C>G]CA" "GA[C>G]CA" "TA[C>G]CA"
#>  [277] "AC[C>G]CA" "CC[C>G]CA" "GC[C>G]CA" "TC[C>G]CA" "AG[C>G]CA" "CG[C>G]CA"
#>  [283] "GG[C>G]CA" "TG[C>G]CA" "AT[C>G]CA" "CT[C>G]CA" "GT[C>G]CA" "TT[C>G]CA"
#>  [289] "AA[C>G]GA" "CA[C>G]GA" "GA[C>G]GA" "TA[C>G]GA" "AC[C>G]GA" "CC[C>G]GA"
#>  [295] "GC[C>G]GA" "TC[C>G]GA" "AG[C>G]GA" "CG[C>G]GA" "GG[C>G]GA" "TG[C>G]GA"
#>  [301] "AT[C>G]GA" "CT[C>G]GA" "GT[C>G]GA" "TT[C>G]GA" "AA[C>G]TA" "CA[C>G]TA"
#>  [307] "GA[C>G]TA" "TA[C>G]TA" "AC[C>G]TA" "CC[C>G]TA" "GC[C>G]TA" "TC[C>G]TA"
#>  [313] "AG[C>G]TA" "CG[C>G]TA" "GG[C>G]TA" "TG[C>G]TA" "AT[C>G]TA" "CT[C>G]TA"
#>  [319] "GT[C>G]TA" "TT[C>G]TA" "AA[C>G]AC" "CA[C>G]AC" "GA[C>G]AC" "TA[C>G]AC"
#>  [325] "AC[C>G]AC" "CC[C>G]AC" "GC[C>G]AC" "TC[C>G]AC" "AG[C>G]AC" "CG[C>G]AC"
#>  [331] "GG[C>G]AC" "TG[C>G]AC" "AT[C>G]AC" "CT[C>G]AC" "GT[C>G]AC" "TT[C>G]AC"
#>  [337] "AA[C>G]CC" "CA[C>G]CC" "GA[C>G]CC" "TA[C>G]CC" "AC[C>G]CC" "CC[C>G]CC"
#>  [343] "GC[C>G]CC" "TC[C>G]CC" "AG[C>G]CC" "CG[C>G]CC" "GG[C>G]CC" "TG[C>G]CC"
#>  [349] "AT[C>G]CC" "CT[C>G]CC" "GT[C>G]CC" "TT[C>G]CC" "AA[C>G]GC" "CA[C>G]GC"
#>  [355] "GA[C>G]GC" "TA[C>G]GC" "AC[C>G]GC" "CC[C>G]GC" "GC[C>G]GC" "TC[C>G]GC"
#>  [361] "AG[C>G]GC" "CG[C>G]GC" "GG[C>G]GC" "TG[C>G]GC" "AT[C>G]GC" "CT[C>G]GC"
#>  [367] "GT[C>G]GC" "TT[C>G]GC" "AA[C>G]TC" "CA[C>G]TC" "GA[C>G]TC" "TA[C>G]TC"
#>  [373] "AC[C>G]TC" "CC[C>G]TC" "GC[C>G]TC" "TC[C>G]TC" "AG[C>G]TC" "CG[C>G]TC"
#>  [379] "GG[C>G]TC" "TG[C>G]TC" "AT[C>G]TC" "CT[C>G]TC" "GT[C>G]TC" "TT[C>G]TC"
#>  [385] "AA[C>G]AG" "CA[C>G]AG" "GA[C>G]AG" "TA[C>G]AG" "AC[C>G]AG" "CC[C>G]AG"
#>  [391] "GC[C>G]AG" "TC[C>G]AG" "AG[C>G]AG" "CG[C>G]AG" "GG[C>G]AG" "TG[C>G]AG"
#>  [397] "AT[C>G]AG" "CT[C>G]AG" "GT[C>G]AG" "TT[C>G]AG" "AA[C>G]CG" "CA[C>G]CG"
#>  [403] "GA[C>G]CG" "TA[C>G]CG" "AC[C>G]CG" "CC[C>G]CG" "GC[C>G]CG" "TC[C>G]CG"
#>  [409] "AG[C>G]CG" "CG[C>G]CG" "GG[C>G]CG" "TG[C>G]CG" "AT[C>G]CG" "CT[C>G]CG"
#>  [415] "GT[C>G]CG" "TT[C>G]CG" "AA[C>G]GG" "CA[C>G]GG" "GA[C>G]GG" "TA[C>G]GG"
#>  [421] "AC[C>G]GG" "CC[C>G]GG" "GC[C>G]GG" "TC[C>G]GG" "AG[C>G]GG" "CG[C>G]GG"
#>  [427] "GG[C>G]GG" "TG[C>G]GG" "AT[C>G]GG" "CT[C>G]GG" "GT[C>G]GG" "TT[C>G]GG"
#>  [433] "AA[C>G]TG" "CA[C>G]TG" "GA[C>G]TG" "TA[C>G]TG" "AC[C>G]TG" "CC[C>G]TG"
#>  [439] "GC[C>G]TG" "TC[C>G]TG" "AG[C>G]TG" "CG[C>G]TG" "GG[C>G]TG" "TG[C>G]TG"
#>  [445] "AT[C>G]TG" "CT[C>G]TG" "GT[C>G]TG" "TT[C>G]TG" "AA[C>G]AT" "CA[C>G]AT"
#>  [451] "GA[C>G]AT" "TA[C>G]AT" "AC[C>G]AT" "CC[C>G]AT" "GC[C>G]AT" "TC[C>G]AT"
#>  [457] "AG[C>G]AT" "CG[C>G]AT" "GG[C>G]AT" "TG[C>G]AT" "AT[C>G]AT" "CT[C>G]AT"
#>  [463] "GT[C>G]AT" "TT[C>G]AT" "AA[C>G]CT" "CA[C>G]CT" "GA[C>G]CT" "TA[C>G]CT"
#>  [469] "AC[C>G]CT" "CC[C>G]CT" "GC[C>G]CT" "TC[C>G]CT" "AG[C>G]CT" "CG[C>G]CT"
#>  [475] "GG[C>G]CT" "TG[C>G]CT" "AT[C>G]CT" "CT[C>G]CT" "GT[C>G]CT" "TT[C>G]CT"
#>  [481] "AA[C>G]GT" "CA[C>G]GT" "GA[C>G]GT" "TA[C>G]GT" "AC[C>G]GT" "CC[C>G]GT"
#>  [487] "GC[C>G]GT" "TC[C>G]GT" "AG[C>G]GT" "CG[C>G]GT" "GG[C>G]GT" "TG[C>G]GT"
#>  [493] "AT[C>G]GT" "CT[C>G]GT" "GT[C>G]GT" "TT[C>G]GT" "AA[C>G]TT" "CA[C>G]TT"
#>  [499] "GA[C>G]TT" "TA[C>G]TT" "AC[C>G]TT" "CC[C>G]TT" "GC[C>G]TT" "TC[C>G]TT"
#>  [505] "AG[C>G]TT" "CG[C>G]TT" "GG[C>G]TT" "TG[C>G]TT" "AT[C>G]TT" "CT[C>G]TT"
#>  [511] "GT[C>G]TT" "TT[C>G]TT" "AA[C>T]AA" "CA[C>T]AA" "GA[C>T]AA" "TA[C>T]AA"
#>  [517] "AC[C>T]AA" "CC[C>T]AA" "GC[C>T]AA" "TC[C>T]AA" "AG[C>T]AA" "CG[C>T]AA"
#>  [523] "GG[C>T]AA" "TG[C>T]AA" "AT[C>T]AA" "CT[C>T]AA" "GT[C>T]AA" "TT[C>T]AA"
#>  [529] "AA[C>T]CA" "CA[C>T]CA" "GA[C>T]CA" "TA[C>T]CA" "AC[C>T]CA" "CC[C>T]CA"
#>  [535] "GC[C>T]CA" "TC[C>T]CA" "AG[C>T]CA" "CG[C>T]CA" "GG[C>T]CA" "TG[C>T]CA"
#>  [541] "AT[C>T]CA" "CT[C>T]CA" "GT[C>T]CA" "TT[C>T]CA" "AA[C>T]GA" "CA[C>T]GA"
#>  [547] "GA[C>T]GA" "TA[C>T]GA" "AC[C>T]GA" "CC[C>T]GA" "GC[C>T]GA" "TC[C>T]GA"
#>  [553] "AG[C>T]GA" "CG[C>T]GA" "GG[C>T]GA" "TG[C>T]GA" "AT[C>T]GA" "CT[C>T]GA"
#>  [559] "GT[C>T]GA" "TT[C>T]GA" "AA[C>T]TA" "CA[C>T]TA" "GA[C>T]TA" "TA[C>T]TA"
#>  [565] "AC[C>T]TA" "CC[C>T]TA" "GC[C>T]TA" "TC[C>T]TA" "AG[C>T]TA" "CG[C>T]TA"
#>  [571] "GG[C>T]TA" "TG[C>T]TA" "AT[C>T]TA" "CT[C>T]TA" "GT[C>T]TA" "TT[C>T]TA"
#>  [577] "AA[C>T]AC" "CA[C>T]AC" "GA[C>T]AC" "TA[C>T]AC" "AC[C>T]AC" "CC[C>T]AC"
#>  [583] "GC[C>T]AC" "TC[C>T]AC" "AG[C>T]AC" "CG[C>T]AC" "GG[C>T]AC" "TG[C>T]AC"
#>  [589] "AT[C>T]AC" "CT[C>T]AC" "GT[C>T]AC" "TT[C>T]AC" "AA[C>T]CC" "CA[C>T]CC"
#>  [595] "GA[C>T]CC" "TA[C>T]CC" "AC[C>T]CC" "CC[C>T]CC" "GC[C>T]CC" "TC[C>T]CC"
#>  [601] "AG[C>T]CC" "CG[C>T]CC" "GG[C>T]CC" "TG[C>T]CC" "AT[C>T]CC" "CT[C>T]CC"
#>  [607] "GT[C>T]CC" "TT[C>T]CC" "AA[C>T]GC" "CA[C>T]GC" "GA[C>T]GC" "TA[C>T]GC"
#>  [613] "AC[C>T]GC" "CC[C>T]GC" "GC[C>T]GC" "TC[C>T]GC" "AG[C>T]GC" "CG[C>T]GC"
#>  [619] "GG[C>T]GC" "TG[C>T]GC" "AT[C>T]GC" "CT[C>T]GC" "GT[C>T]GC" "TT[C>T]GC"
#>  [625] "AA[C>T]TC" "CA[C>T]TC" "GA[C>T]TC" "TA[C>T]TC" "AC[C>T]TC" "CC[C>T]TC"
#>  [631] "GC[C>T]TC" "TC[C>T]TC" "AG[C>T]TC" "CG[C>T]TC" "GG[C>T]TC" "TG[C>T]TC"
#>  [637] "AT[C>T]TC" "CT[C>T]TC" "GT[C>T]TC" "TT[C>T]TC" "AA[C>T]AG" "CA[C>T]AG"
#>  [643] "GA[C>T]AG" "TA[C>T]AG" "AC[C>T]AG" "CC[C>T]AG" "GC[C>T]AG" "TC[C>T]AG"
#>  [649] "AG[C>T]AG" "CG[C>T]AG" "GG[C>T]AG" "TG[C>T]AG" "AT[C>T]AG" "CT[C>T]AG"
#>  [655] "GT[C>T]AG" "TT[C>T]AG" "AA[C>T]CG" "CA[C>T]CG" "GA[C>T]CG" "TA[C>T]CG"
#>  [661] "AC[C>T]CG" "CC[C>T]CG" "GC[C>T]CG" "TC[C>T]CG" "AG[C>T]CG" "CG[C>T]CG"
#>  [667] "GG[C>T]CG" "TG[C>T]CG" "AT[C>T]CG" "CT[C>T]CG" "GT[C>T]CG" "TT[C>T]CG"
#>  [673] "AA[C>T]GG" "CA[C>T]GG" "GA[C>T]GG" "TA[C>T]GG" "AC[C>T]GG" "CC[C>T]GG"
#>  [679] "GC[C>T]GG" "TC[C>T]GG" "AG[C>T]GG" "CG[C>T]GG" "GG[C>T]GG" "TG[C>T]GG"
#>  [685] "AT[C>T]GG" "CT[C>T]GG" "GT[C>T]GG" "TT[C>T]GG" "AA[C>T]TG" "CA[C>T]TG"
#>  [691] "GA[C>T]TG" "TA[C>T]TG" "AC[C>T]TG" "CC[C>T]TG" "GC[C>T]TG" "TC[C>T]TG"
#>  [697] "AG[C>T]TG" "CG[C>T]TG" "GG[C>T]TG" "TG[C>T]TG" "AT[C>T]TG" "CT[C>T]TG"
#>  [703] "GT[C>T]TG" "TT[C>T]TG" "AA[C>T]AT" "CA[C>T]AT" "GA[C>T]AT" "TA[C>T]AT"
#>  [709] "AC[C>T]AT" "CC[C>T]AT" "GC[C>T]AT" "TC[C>T]AT" "AG[C>T]AT" "CG[C>T]AT"
#>  [715] "GG[C>T]AT" "TG[C>T]AT" "AT[C>T]AT" "CT[C>T]AT" "GT[C>T]AT" "TT[C>T]AT"
#>  [721] "AA[C>T]CT" "CA[C>T]CT" "GA[C>T]CT" "TA[C>T]CT" "AC[C>T]CT" "CC[C>T]CT"
#>  [727] "GC[C>T]CT" "TC[C>T]CT" "AG[C>T]CT" "CG[C>T]CT" "GG[C>T]CT" "TG[C>T]CT"
#>  [733] "AT[C>T]CT" "CT[C>T]CT" "GT[C>T]CT" "TT[C>T]CT" "AA[C>T]GT" "CA[C>T]GT"
#>  [739] "GA[C>T]GT" "TA[C>T]GT" "AC[C>T]GT" "CC[C>T]GT" "GC[C>T]GT" "TC[C>T]GT"
#>  [745] "AG[C>T]GT" "CG[C>T]GT" "GG[C>T]GT" "TG[C>T]GT" "AT[C>T]GT" "CT[C>T]GT"
#>  [751] "GT[C>T]GT" "TT[C>T]GT" "AA[C>T]TT" "CA[C>T]TT" "GA[C>T]TT" "TA[C>T]TT"
#>  [757] "AC[C>T]TT" "CC[C>T]TT" "GC[C>T]TT" "TC[C>T]TT" "AG[C>T]TT" "CG[C>T]TT"
#>  [763] "GG[C>T]TT" "TG[C>T]TT" "AT[C>T]TT" "CT[C>T]TT" "GT[C>T]TT" "TT[C>T]TT"
#>  [769] "AA[T>A]AA" "CA[T>A]AA" "GA[T>A]AA" "TA[T>A]AA" "AC[T>A]AA" "CC[T>A]AA"
#>  [775] "GC[T>A]AA" "TC[T>A]AA" "AG[T>A]AA" "CG[T>A]AA" "GG[T>A]AA" "TG[T>A]AA"
#>  [781] "AT[T>A]AA" "CT[T>A]AA" "GT[T>A]AA" "TT[T>A]AA" "AA[T>A]CA" "CA[T>A]CA"
#>  [787] "GA[T>A]CA" "TA[T>A]CA" "AC[T>A]CA" "CC[T>A]CA" "GC[T>A]CA" "TC[T>A]CA"
#>  [793] "AG[T>A]CA" "CG[T>A]CA" "GG[T>A]CA" "TG[T>A]CA" "AT[T>A]CA" "CT[T>A]CA"
#>  [799] "GT[T>A]CA" "TT[T>A]CA" "AA[T>A]GA" "CA[T>A]GA" "GA[T>A]GA" "TA[T>A]GA"
#>  [805] "AC[T>A]GA" "CC[T>A]GA" "GC[T>A]GA" "TC[T>A]GA" "AG[T>A]GA" "CG[T>A]GA"
#>  [811] "GG[T>A]GA" "TG[T>A]GA" "AT[T>A]GA" "CT[T>A]GA" "GT[T>A]GA" "TT[T>A]GA"
#>  [817] "AA[T>A]TA" "CA[T>A]TA" "GA[T>A]TA" "TA[T>A]TA" "AC[T>A]TA" "CC[T>A]TA"
#>  [823] "GC[T>A]TA" "TC[T>A]TA" "AG[T>A]TA" "CG[T>A]TA" "GG[T>A]TA" "TG[T>A]TA"
#>  [829] "AT[T>A]TA" "CT[T>A]TA" "GT[T>A]TA" "TT[T>A]TA" "AA[T>A]AC" "CA[T>A]AC"
#>  [835] "GA[T>A]AC" "TA[T>A]AC" "AC[T>A]AC" "CC[T>A]AC" "GC[T>A]AC" "TC[T>A]AC"
#>  [841] "AG[T>A]AC" "CG[T>A]AC" "GG[T>A]AC" "TG[T>A]AC" "AT[T>A]AC" "CT[T>A]AC"
#>  [847] "GT[T>A]AC" "TT[T>A]AC" "AA[T>A]CC" "CA[T>A]CC" "GA[T>A]CC" "TA[T>A]CC"
#>  [853] "AC[T>A]CC" "CC[T>A]CC" "GC[T>A]CC" "TC[T>A]CC" "AG[T>A]CC" "CG[T>A]CC"
#>  [859] "GG[T>A]CC" "TG[T>A]CC" "AT[T>A]CC" "CT[T>A]CC" "GT[T>A]CC" "TT[T>A]CC"
#>  [865] "AA[T>A]GC" "CA[T>A]GC" "GA[T>A]GC" "TA[T>A]GC" "AC[T>A]GC" "CC[T>A]GC"
#>  [871] "GC[T>A]GC" "TC[T>A]GC" "AG[T>A]GC" "CG[T>A]GC" "GG[T>A]GC" "TG[T>A]GC"
#>  [877] "AT[T>A]GC" "CT[T>A]GC" "GT[T>A]GC" "TT[T>A]GC" "AA[T>A]TC" "CA[T>A]TC"
#>  [883] "GA[T>A]TC" "TA[T>A]TC" "AC[T>A]TC" "CC[T>A]TC" "GC[T>A]TC" "TC[T>A]TC"
#>  [889] "AG[T>A]TC" "CG[T>A]TC" "GG[T>A]TC" "TG[T>A]TC" "AT[T>A]TC" "CT[T>A]TC"
#>  [895] "GT[T>A]TC" "TT[T>A]TC" "AA[T>A]AG" "CA[T>A]AG" "GA[T>A]AG" "TA[T>A]AG"
#>  [901] "AC[T>A]AG" "CC[T>A]AG" "GC[T>A]AG" "TC[T>A]AG" "AG[T>A]AG" "CG[T>A]AG"
#>  [907] "GG[T>A]AG" "TG[T>A]AG" "AT[T>A]AG" "CT[T>A]AG" "GT[T>A]AG" "TT[T>A]AG"
#>  [913] "AA[T>A]CG" "CA[T>A]CG" "GA[T>A]CG" "TA[T>A]CG" "AC[T>A]CG" "CC[T>A]CG"
#>  [919] "GC[T>A]CG" "TC[T>A]CG" "AG[T>A]CG" "CG[T>A]CG" "GG[T>A]CG" "TG[T>A]CG"
#>  [925] "AT[T>A]CG" "CT[T>A]CG" "GT[T>A]CG" "TT[T>A]CG" "AA[T>A]GG" "CA[T>A]GG"
#>  [931] "GA[T>A]GG" "TA[T>A]GG" "AC[T>A]GG" "CC[T>A]GG" "GC[T>A]GG" "TC[T>A]GG"
#>  [937] "AG[T>A]GG" "CG[T>A]GG" "GG[T>A]GG" "TG[T>A]GG" "AT[T>A]GG" "CT[T>A]GG"
#>  [943] "GT[T>A]GG" "TT[T>A]GG" "AA[T>A]TG" "CA[T>A]TG" "GA[T>A]TG" "TA[T>A]TG"
#>  [949] "AC[T>A]TG" "CC[T>A]TG" "GC[T>A]TG" "TC[T>A]TG" "AG[T>A]TG" "CG[T>A]TG"
#>  [955] "GG[T>A]TG" "TG[T>A]TG" "AT[T>A]TG" "CT[T>A]TG" "GT[T>A]TG" "TT[T>A]TG"
#>  [961] "AA[T>A]AT" "CA[T>A]AT" "GA[T>A]AT" "TA[T>A]AT" "AC[T>A]AT" "CC[T>A]AT"
#>  [967] "GC[T>A]AT" "TC[T>A]AT" "AG[T>A]AT" "CG[T>A]AT" "GG[T>A]AT" "TG[T>A]AT"
#>  [973] "AT[T>A]AT" "CT[T>A]AT" "GT[T>A]AT" "TT[T>A]AT" "AA[T>A]CT" "CA[T>A]CT"
#>  [979] "GA[T>A]CT" "TA[T>A]CT" "AC[T>A]CT" "CC[T>A]CT" "GC[T>A]CT" "TC[T>A]CT"
#>  [985] "AG[T>A]CT" "CG[T>A]CT" "GG[T>A]CT" "TG[T>A]CT" "AT[T>A]CT" "CT[T>A]CT"
#>  [991] "GT[T>A]CT" "TT[T>A]CT" "AA[T>A]GT" "CA[T>A]GT" "GA[T>A]GT" "TA[T>A]GT"
#>  [997] "AC[T>A]GT" "CC[T>A]GT" "GC[T>A]GT" "TC[T>A]GT" "AG[T>A]GT" "CG[T>A]GT"
#> [1003] "GG[T>A]GT" "TG[T>A]GT" "AT[T>A]GT" "CT[T>A]GT" "GT[T>A]GT" "TT[T>A]GT"
#> [1009] "AA[T>A]TT" "CA[T>A]TT" "GA[T>A]TT" "TA[T>A]TT" "AC[T>A]TT" "CC[T>A]TT"
#> [1015] "GC[T>A]TT" "TC[T>A]TT" "AG[T>A]TT" "CG[T>A]TT" "GG[T>A]TT" "TG[T>A]TT"
#> [1021] "AT[T>A]TT" "CT[T>A]TT" "GT[T>A]TT" "TT[T>A]TT" "AA[T>C]AA" "CA[T>C]AA"
#> [1027] "GA[T>C]AA" "TA[T>C]AA" "AC[T>C]AA" "CC[T>C]AA" "GC[T>C]AA" "TC[T>C]AA"
#> [1033] "AG[T>C]AA" "CG[T>C]AA" "GG[T>C]AA" "TG[T>C]AA" "AT[T>C]AA" "CT[T>C]AA"
#> [1039] "GT[T>C]AA" "TT[T>C]AA" "AA[T>C]CA" "CA[T>C]CA" "GA[T>C]CA" "TA[T>C]CA"
#> [1045] "AC[T>C]CA" "CC[T>C]CA" "GC[T>C]CA" "TC[T>C]CA" "AG[T>C]CA" "CG[T>C]CA"
#> [1051] "GG[T>C]CA" "TG[T>C]CA" "AT[T>C]CA" "CT[T>C]CA" "GT[T>C]CA" "TT[T>C]CA"
#> [1057] "AA[T>C]GA" "CA[T>C]GA" "GA[T>C]GA" "TA[T>C]GA" "AC[T>C]GA" "CC[T>C]GA"
#> [1063] "GC[T>C]GA" "TC[T>C]GA" "AG[T>C]GA" "CG[T>C]GA" "GG[T>C]GA" "TG[T>C]GA"
#> [1069] "AT[T>C]GA" "CT[T>C]GA" "GT[T>C]GA" "TT[T>C]GA" "AA[T>C]TA" "CA[T>C]TA"
#> [1075] "GA[T>C]TA" "TA[T>C]TA" "AC[T>C]TA" "CC[T>C]TA" "GC[T>C]TA" "TC[T>C]TA"
#> [1081] "AG[T>C]TA" "CG[T>C]TA" "GG[T>C]TA" "TG[T>C]TA" "AT[T>C]TA" "CT[T>C]TA"
#> [1087] "GT[T>C]TA" "TT[T>C]TA" "AA[T>C]AC" "CA[T>C]AC" "GA[T>C]AC" "TA[T>C]AC"
#> [1093] "AC[T>C]AC" "CC[T>C]AC" "GC[T>C]AC" "TC[T>C]AC" "AG[T>C]AC" "CG[T>C]AC"
#> [1099] "GG[T>C]AC" "TG[T>C]AC" "AT[T>C]AC" "CT[T>C]AC" "GT[T>C]AC" "TT[T>C]AC"
#> [1105] "AA[T>C]CC" "CA[T>C]CC" "GA[T>C]CC" "TA[T>C]CC" "AC[T>C]CC" "CC[T>C]CC"
#> [1111] "GC[T>C]CC" "TC[T>C]CC" "AG[T>C]CC" "CG[T>C]CC" "GG[T>C]CC" "TG[T>C]CC"
#> [1117] "AT[T>C]CC" "CT[T>C]CC" "GT[T>C]CC" "TT[T>C]CC" "AA[T>C]GC" "CA[T>C]GC"
#> [1123] "GA[T>C]GC" "TA[T>C]GC" "AC[T>C]GC" "CC[T>C]GC" "GC[T>C]GC" "TC[T>C]GC"
#> [1129] "AG[T>C]GC" "CG[T>C]GC" "GG[T>C]GC" "TG[T>C]GC" "AT[T>C]GC" "CT[T>C]GC"
#> [1135] "GT[T>C]GC" "TT[T>C]GC" "AA[T>C]TC" "CA[T>C]TC" "GA[T>C]TC" "TA[T>C]TC"
#> [1141] "AC[T>C]TC" "CC[T>C]TC" "GC[T>C]TC" "TC[T>C]TC" "AG[T>C]TC" "CG[T>C]TC"
#> [1147] "GG[T>C]TC" "TG[T>C]TC" "AT[T>C]TC" "CT[T>C]TC" "GT[T>C]TC" "TT[T>C]TC"
#> [1153] "AA[T>C]AG" "CA[T>C]AG" "GA[T>C]AG" "TA[T>C]AG" "AC[T>C]AG" "CC[T>C]AG"
#> [1159] "GC[T>C]AG" "TC[T>C]AG" "AG[T>C]AG" "CG[T>C]AG" "GG[T>C]AG" "TG[T>C]AG"
#> [1165] "AT[T>C]AG" "CT[T>C]AG" "GT[T>C]AG" "TT[T>C]AG" "AA[T>C]CG" "CA[T>C]CG"
#> [1171] "GA[T>C]CG" "TA[T>C]CG" "AC[T>C]CG" "CC[T>C]CG" "GC[T>C]CG" "TC[T>C]CG"
#> [1177] "AG[T>C]CG" "CG[T>C]CG" "GG[T>C]CG" "TG[T>C]CG" "AT[T>C]CG" "CT[T>C]CG"
#> [1183] "GT[T>C]CG" "TT[T>C]CG" "AA[T>C]GG" "CA[T>C]GG" "GA[T>C]GG" "TA[T>C]GG"
#> [1189] "AC[T>C]GG" "CC[T>C]GG" "GC[T>C]GG" "TC[T>C]GG" "AG[T>C]GG" "CG[T>C]GG"
#> [1195] "GG[T>C]GG" "TG[T>C]GG" "AT[T>C]GG" "CT[T>C]GG" "GT[T>C]GG" "TT[T>C]GG"
#> [1201] "AA[T>C]TG" "CA[T>C]TG" "GA[T>C]TG" "TA[T>C]TG" "AC[T>C]TG" "CC[T>C]TG"
#> [1207] "GC[T>C]TG" "TC[T>C]TG" "AG[T>C]TG" "CG[T>C]TG" "GG[T>C]TG" "TG[T>C]TG"
#> [1213] "AT[T>C]TG" "CT[T>C]TG" "GT[T>C]TG" "TT[T>C]TG" "AA[T>C]AT" "CA[T>C]AT"
#> [1219] "GA[T>C]AT" "TA[T>C]AT" "AC[T>C]AT" "CC[T>C]AT" "GC[T>C]AT" "TC[T>C]AT"
#> [1225] "AG[T>C]AT" "CG[T>C]AT" "GG[T>C]AT" "TG[T>C]AT" "AT[T>C]AT" "CT[T>C]AT"
#> [1231] "GT[T>C]AT" "TT[T>C]AT" "AA[T>C]CT" "CA[T>C]CT" "GA[T>C]CT" "TA[T>C]CT"
#> [1237] "AC[T>C]CT" "CC[T>C]CT" "GC[T>C]CT" "TC[T>C]CT" "AG[T>C]CT" "CG[T>C]CT"
#> [1243] "GG[T>C]CT" "TG[T>C]CT" "AT[T>C]CT" "CT[T>C]CT" "GT[T>C]CT" "TT[T>C]CT"
#> [1249] "AA[T>C]GT" "CA[T>C]GT" "GA[T>C]GT" "TA[T>C]GT" "AC[T>C]GT" "CC[T>C]GT"
#> [1255] "GC[T>C]GT" "TC[T>C]GT" "AG[T>C]GT" "CG[T>C]GT" "GG[T>C]GT" "TG[T>C]GT"
#> [1261] "AT[T>C]GT" "CT[T>C]GT" "GT[T>C]GT" "TT[T>C]GT" "AA[T>C]TT" "CA[T>C]TT"
#> [1267] "GA[T>C]TT" "TA[T>C]TT" "AC[T>C]TT" "CC[T>C]TT" "GC[T>C]TT" "TC[T>C]TT"
#> [1273] "AG[T>C]TT" "CG[T>C]TT" "GG[T>C]TT" "TG[T>C]TT" "AT[T>C]TT" "CT[T>C]TT"
#> [1279] "GT[T>C]TT" "TT[T>C]TT" "AA[T>G]AA" "CA[T>G]AA" "GA[T>G]AA" "TA[T>G]AA"
#> [1285] "AC[T>G]AA" "CC[T>G]AA" "GC[T>G]AA" "TC[T>G]AA" "AG[T>G]AA" "CG[T>G]AA"
#> [1291] "GG[T>G]AA" "TG[T>G]AA" "AT[T>G]AA" "CT[T>G]AA" "GT[T>G]AA" "TT[T>G]AA"
#> [1297] "AA[T>G]CA" "CA[T>G]CA" "GA[T>G]CA" "TA[T>G]CA" "AC[T>G]CA" "CC[T>G]CA"
#> [1303] "GC[T>G]CA" "TC[T>G]CA" "AG[T>G]CA" "CG[T>G]CA" "GG[T>G]CA" "TG[T>G]CA"
#> [1309] "AT[T>G]CA" "CT[T>G]CA" "GT[T>G]CA" "TT[T>G]CA" "AA[T>G]GA" "CA[T>G]GA"
#> [1315] "GA[T>G]GA" "TA[T>G]GA" "AC[T>G]GA" "CC[T>G]GA" "GC[T>G]GA" "TC[T>G]GA"
#> [1321] "AG[T>G]GA" "CG[T>G]GA" "GG[T>G]GA" "TG[T>G]GA" "AT[T>G]GA" "CT[T>G]GA"
#> [1327] "GT[T>G]GA" "TT[T>G]GA" "AA[T>G]TA" "CA[T>G]TA" "GA[T>G]TA" "TA[T>G]TA"
#> [1333] "AC[T>G]TA" "CC[T>G]TA" "GC[T>G]TA" "TC[T>G]TA" "AG[T>G]TA" "CG[T>G]TA"
#> [1339] "GG[T>G]TA" "TG[T>G]TA" "AT[T>G]TA" "CT[T>G]TA" "GT[T>G]TA" "TT[T>G]TA"
#> [1345] "AA[T>G]AC" "CA[T>G]AC" "GA[T>G]AC" "TA[T>G]AC" "AC[T>G]AC" "CC[T>G]AC"
#> [1351] "GC[T>G]AC" "TC[T>G]AC" "AG[T>G]AC" "CG[T>G]AC" "GG[T>G]AC" "TG[T>G]AC"
#> [1357] "AT[T>G]AC" "CT[T>G]AC" "GT[T>G]AC" "TT[T>G]AC" "AA[T>G]CC" "CA[T>G]CC"
#> [1363] "GA[T>G]CC" "TA[T>G]CC" "AC[T>G]CC" "CC[T>G]CC" "GC[T>G]CC" "TC[T>G]CC"
#> [1369] "AG[T>G]CC" "CG[T>G]CC" "GG[T>G]CC" "TG[T>G]CC" "AT[T>G]CC" "CT[T>G]CC"
#> [1375] "GT[T>G]CC" "TT[T>G]CC" "AA[T>G]GC" "CA[T>G]GC" "GA[T>G]GC" "TA[T>G]GC"
#> [1381] "AC[T>G]GC" "CC[T>G]GC" "GC[T>G]GC" "TC[T>G]GC" "AG[T>G]GC" "CG[T>G]GC"
#> [1387] "GG[T>G]GC" "TG[T>G]GC" "AT[T>G]GC" "CT[T>G]GC" "GT[T>G]GC" "TT[T>G]GC"
#> [1393] "AA[T>G]TC" "CA[T>G]TC" "GA[T>G]TC" "TA[T>G]TC" "AC[T>G]TC" "CC[T>G]TC"
#> [1399] "GC[T>G]TC" "TC[T>G]TC" "AG[T>G]TC" "CG[T>G]TC" "GG[T>G]TC" "TG[T>G]TC"
#> [1405] "AT[T>G]TC" "CT[T>G]TC" "GT[T>G]TC" "TT[T>G]TC" "AA[T>G]AG" "CA[T>G]AG"
#> [1411] "GA[T>G]AG" "TA[T>G]AG" "AC[T>G]AG" "CC[T>G]AG" "GC[T>G]AG" "TC[T>G]AG"
#> [1417] "AG[T>G]AG" "CG[T>G]AG" "GG[T>G]AG" "TG[T>G]AG" "AT[T>G]AG" "CT[T>G]AG"
#> [1423] "GT[T>G]AG" "TT[T>G]AG" "AA[T>G]CG" "CA[T>G]CG" "GA[T>G]CG" "TA[T>G]CG"
#> [1429] "AC[T>G]CG" "CC[T>G]CG" "GC[T>G]CG" "TC[T>G]CG" "AG[T>G]CG" "CG[T>G]CG"
#> [1435] "GG[T>G]CG" "TG[T>G]CG" "AT[T>G]CG" "CT[T>G]CG" "GT[T>G]CG" "TT[T>G]CG"
#> [1441] "AA[T>G]GG" "CA[T>G]GG" "GA[T>G]GG" "TA[T>G]GG" "AC[T>G]GG" "CC[T>G]GG"
#> [1447] "GC[T>G]GG" "TC[T>G]GG" "AG[T>G]GG" "CG[T>G]GG" "GG[T>G]GG" "TG[T>G]GG"
#> [1453] "AT[T>G]GG" "CT[T>G]GG" "GT[T>G]GG" "TT[T>G]GG" "AA[T>G]TG" "CA[T>G]TG"
#> [1459] "GA[T>G]TG" "TA[T>G]TG" "AC[T>G]TG" "CC[T>G]TG" "GC[T>G]TG" "TC[T>G]TG"
#> [1465] "AG[T>G]TG" "CG[T>G]TG" "GG[T>G]TG" "TG[T>G]TG" "AT[T>G]TG" "CT[T>G]TG"
#> [1471] "GT[T>G]TG" "TT[T>G]TG" "AA[T>G]AT" "CA[T>G]AT" "GA[T>G]AT" "TA[T>G]AT"
#> [1477] "AC[T>G]AT" "CC[T>G]AT" "GC[T>G]AT" "TC[T>G]AT" "AG[T>G]AT" "CG[T>G]AT"
#> [1483] "GG[T>G]AT" "TG[T>G]AT" "AT[T>G]AT" "CT[T>G]AT" "GT[T>G]AT" "TT[T>G]AT"
#> [1489] "AA[T>G]CT" "CA[T>G]CT" "GA[T>G]CT" "TA[T>G]CT" "AC[T>G]CT" "CC[T>G]CT"
#> [1495] "GC[T>G]CT" "TC[T>G]CT" "AG[T>G]CT" "CG[T>G]CT" "GG[T>G]CT" "TG[T>G]CT"
#> [1501] "AT[T>G]CT" "CT[T>G]CT" "GT[T>G]CT" "TT[T>G]CT" "AA[T>G]GT" "CA[T>G]GT"
#> [1507] "GA[T>G]GT" "TA[T>G]GT" "AC[T>G]GT" "CC[T>G]GT" "GC[T>G]GT" "TC[T>G]GT"
#> [1513] "AG[T>G]GT" "CG[T>G]GT" "GG[T>G]GT" "TG[T>G]GT" "AT[T>G]GT" "CT[T>G]GT"
#> [1519] "GT[T>G]GT" "TT[T>G]GT" "AA[T>G]TT" "CA[T>G]TT" "GA[T>G]TT" "TA[T>G]TT"
#> [1525] "AC[T>G]TT" "CC[T>G]TT" "GC[T>G]TT" "TC[T>G]TT" "AG[T>G]TT" "CG[T>G]TT"
#> [1531] "GG[T>G]TT" "TG[T>G]TT" "AT[T>G]TT" "CT[T>G]TT" "GT[T>G]TT" "TT[T>G]TT"
```

You can also plot mutation spectra, for example

``` r
library(mutationsR)
kmer = gen_contexts(3)
muts = get_wt_seq(kmer)
value = 1:96
spectra_dt = data.frame(kmer = kmer, muts = muts, value = value)
spectra_plot(spectra_dt)
```

<img src="man/figures/README-mutation spectra-1.png" width="100%" />
