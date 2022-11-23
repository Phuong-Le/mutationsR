
#' generater all possible symmetric mutations given the kmer size (ie the length of the sequence)
#'
#' @param k an odd integer
#' @return a vector of characters that represent the symmetric mutations with their corresponding kmer size
#' @export
#'
#' @examples
#' gen_contexts(1)
#' gen_contexts(3)
#' gen_contexts(5)
gen_contexts = function(k) {
  # k is the kmer size
  if(k %% 2 != 1) stop('k is an odd number')

  mut_types = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G")
  bases = c('A','C','G','T')
  flank = k %/% 2

  if (k ==1) return(mut_types)
  if (k == 3) lefts = bases else
  {
    lefts = as.data.frame(matrix(replicate(flank, bases), nrow = length(bases)))
    lefts = expand.grid(lefts)
    lefts = apply(lefts, MARGIN = 1, function(i) paste0(i[1], i[2], sep = ''))}

  contexts = expand.grid(lefts, lefts)
  contexts = apply(contexts, MARGIN = 1, function(i) paste(i[1], i[2], sep = '[-]'))

  kmers = expand.grid(mut_types, contexts); colnames(kmers) = c('mut_types', 'bases')
  kmers = dplyr::arrange(kmers, mut_types, bases)
  combine_mut_context = function(mut_context) {
    mut = mut_context[1]; context = mut_context[2]
    context = unlist(strsplit(context, split = '-'))
    return(paste0(context[1], mut, context[2], sep = ''))
  }
  kmers = apply(kmers, MARGIN = 1, combine_mut_context)
  return(kmers)
}
