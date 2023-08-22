

#' Get the central mutation from a context mutation,
#' If only the central mutation is provided then return the mutation itself
#'
#' @param kmer a character for the kmer of interest
#' @return a character of mutation
#' @export
#'
#' @examples
#' get_mut('A[C>T]G')
#' get_mut('C>T')
#'
get_mut = function(kmer) {
  if (nchar(kmer) == 3 & substr(kmer, 2, 2) == ">")
    return(kmer)

  tail_mer = strsplit(kmer, "[", fixed = T)[[1]][2]
  return(strsplit(tail_mer, "]", fixed = T)[[1]][1])
}

#' applied when the input has the following order
#' donor_id, chromosome, chrom_start, chrom_end, reference_genome_allele, mutated_from_base, mutated_to_base
#' this is in line with VCF/MAF format
get_context_vcf = function(x, seq, flank) {
  pos = as.numeric(x[3])
  if (x[5] != seq[pos])
    stop("reference base from mutation dataframe should be the same as in the genome assembly")
  if (x[3] != x[4])
    stop("sbs should have the same chrom_start and chrom_end")
  result = paste0(seq[(pos - flank):(pos - 1)], "[", x[6], ">", x[7], "]", seq[(pos + 1):(pos + flank)])
  return(result)
}

#' applied when the input has the following order
#' donor_id (SampleID), chromosome (Chr), position (Pos), reference_base (Ref), mutated_base (Alt)
#' this is in line with the simplified VCF/MAF format
get_context_simplified = function(x, seq, flank) {
  pos = as.numeric(x[3])
  if (x[4] != seq[pos])
    stop("reference base from mutation dataframe should be the same as in the genome assembly")
  result = paste0(seq[(pos - flank):(pos - 1)], "[", x[4], ">", x[5], "]", seq[(pos + 1):(pos + flank)])
  return(result)
}



#' get the relevant sequence & a kmer size and output a function that gets the context. This output function will be used in the apply function along a dataframe
#' Note that input to the get_context function should be of the following orders if format_ is vcf (default):
#' donor_id, chromosome, chrom_start, chrom_end, reference_genome_allele, mutated_from_base, mutated_to_base
#' or this order if format_ is simplified
#' donor_id (SampleID), chromosome (Chr), position (Pos), reference_base (Ref), mutated_base (Alt)
#'
#' @param seq a vector of characters representing a DNA sequence)
#' @param k an odd number greater than 1, default to 3
#' @param format_ either 'vcf' (default) or 'simplified' depending on the input dataframe
#' @return a function to be applied to a dataframe, when applying the resulting function to a relevant dataframe, it returns a vector of mutations and their contexts
#' @export
#'
#' @examples
#' if (requireNamespace('seqinr', quietly = TRUE)) {
#' mut_dt = data.frame(donor_id = c('PD1','PD2'), chromosome = c('3', 'X'), chrom_start = c(5,7), chrom_end = c(5,7), reference_genome_allele = c('A','C'), mutated_from_base = c('A','C'), mutated_to_base = c('T', 'A'))
#' seq = seqinr::s2c('AGCTAGCTGA')
#' get_context = get_context_param(seq, k = 3)
#' apply(mut_dt, MARGIN = 1, get_context)
#'}
get_context_param = function(seq,
                             k = 3,
                             format_ = c('vcf', 'simplified')) {
  # k is the kmer size
  if (k %% 2 != 1 | k <= 1)
    stop("k should be an odd number greater than 1")
  flank = k %/% 2
  force(seq)  # force is required for every function factory as best practice
  format_ = match.arg(format_)

  if (format_ == 'vcf') {
    get_context = function(x) get_context_vcf(x, seq, flank)
  } else if (format_ == 'simplified') {
    get_context = function(x) get_context_simplified(x, seq, flank)
  }

  return(get_context)
}
