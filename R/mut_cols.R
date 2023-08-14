
#' returns the colours based on the central mutation, colour scheme similar to COSMIC mutational signatures
#'
#' @param kmer a character of mutations with their contexts
#' @return the colour corresponding to the central base
#' @export
#'
#' @examples
#' mut_cols('A[C>T]G')
#' mut_cols('CT[T>G]AA')
mut_cols = function(kmer) {
    mut = get_mut(kmer)
    mut_types = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G")
    cols = c("dodgerblue", "black", "red", "grey70", "olivedrab3", "plum2")
    names(cols) = mut_types
    return(cols[mut])
}
