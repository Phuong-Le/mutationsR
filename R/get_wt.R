#' Get the original wildtype sequence given the mutations, this is useful for example to get the x ticks in the difference plot
#'
#'@param mut a character of mutation in kmer, eg 'A[C>T]G'
#'@return a character of the original sequence
#'@export
#'
#'@examples
#'get_wt_seq('A[C>T]G')
get_wt_seq = function(mut) {
    sep1 = strsplit(mut, "[", fixed = T)[[1]]
    base1 = sep1[1]
    wt = strsplit(sep1[2], ">", fixed = T)[[1]][1]
    base2 = strsplit(mut, "]", fixed = T)[[1]][2]
    return(paste0(base1, wt, base2, sep = ""))
}
