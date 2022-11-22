
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
