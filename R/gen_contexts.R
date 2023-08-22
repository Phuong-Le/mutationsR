
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
    if (k%%2 != 1)
        stop("k is an odd number")

    mut_types = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G")
    bases = c("A", "C", "G", "T")
    flank = k%/%2

    if (k == 1)
        return(mut_types)

    # get mutations and contexts
    contexts = as.list(as.data.frame(matrix(rep(bases, flank * 2), nrow = 4)))
    kmers = append(list(mut_types), contexts)
    kmers = do.call(expand.grid, kmers)
    ordered_cols = c("muts",
                     sapply(1:flank, function(x) paste0("left_", x)),
                     sapply(1:flank, function(x) paste0("right_",x)))
    colnames(kmers) = ordered_cols

    # order them alphabetically
    arg_ls = append(list(kmers), lapply(ordered_cols, dplyr::sym))
    kmers = do.call(dplyr::arrange, arg_ls)

    # order based on position on kmer
    reordered_cols = c(sapply(1:flank, function(x) paste0("left_", x)),
                       "muts",
                       sapply(1:flank, function(x) paste0("right_", x)))
    kmers = dplyr::select(kmers, all_of(reordered_cols))

    combine_mut_context = function(mut_context) {
        mut_context = append(mut_context, "]", after = (flank + 1))
        mut_context = append(mut_context, "[", after = flank)
        arg_ls = append(mut_context, list(sep = ""))
        result = do.call(paste0, arg_ls)
        return(result)
    }
    kmers = apply(kmers, MARGIN = 1, combine_mut_context)
    return(kmers)
}
