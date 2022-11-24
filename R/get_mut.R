
#' Get the central mutation from a context mutation
#'
#' @param kmer a character for the kmer of interest
#' @return a character of mutation
#' @export
#'
#' @examples
#' get_mut('A[C>T]G')
#'
get_mut = function(kmer) {
  tail_mer = strsplit(kmer,"[", fixed = T)[[1]][2]
  return(strsplit(tail_mer,"]", fixed = T)[[1]][1])
}

#' get the relevant sequence & a kmer size and output a function that gets the context. This output function will be used in the apply function along a dataframe
#' Note that input to the get_context function should be of the following orders: donor_id, chromosome, chrom_start, chrom_end, reference_genome_allele, mutated_from_base, mutated_to_base
#'
#' @param seq a vector of characters representing a DNA sequence)
#' @param k an odd number greater than 1, default to 3
#' @return a function to be applied to a dataframe, when applying the resulting function to a relevant dataframe, it returns a vector of mutations and their contexts
#' @export
#'
#' @examples
#' mut_dt = data.frame(donor_id = c('PD1','PD2'), chromosome = c('3', 'X'), chrom_start = c(5,7), chrom_end = c(5,7), reference_genome_allele = c('A','C'), mutated_from_base = c('A','C'), mutated_to_base = c('T', 'A'))
#' seq = seqinr::s2c('AGCTAGCTGA')
#' get_context = get_context_param(seq, k = 3)
#' apply(mut_dt, MARGIN = 1, get_context)
#'
get_context_param = function(seq, k = 3) {
  # k is the kmer size
  if(k %% 2 != 1 | k <= 1) stop("k should be an odd number greater than 1")

  get_context = function(x) {
    pos = as.numeric(x[3])
    if (x[5] != seq[pos]) stop("reference base from mutation dataframe should be the same as in the genome assembly")
    if (x[3] != x[4]) stop("sbs should have the same chrom_start and chrom_end")
    flank = k %/% 2
    result = paste0(seq[(pos-flank):(pos-1)], "[", x[6], ">", x[7], "]", seq[(pos+1):(pos+flank)])
    return(result)
  }
  return(get_context)
}
