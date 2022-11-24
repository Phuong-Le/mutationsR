complementary_base = function(base) {
  bases = c('A','C','G','T'); rv = c('T', 'G', 'C', 'A')
  names(rv) = bases
  return(rv[base])
}

complementary_mut = function(mut) {
  mut_split = unlist(strsplit(mut, '>'))
  comp_bases = complementary_base(mut_split)
  complementary = paste0(comp_bases[1], '>', comp_bases[2])
  return(complementary)
}

#' takes a mutation context and outputs its reverse complementary counterpart
#'
#' @param context a character of mutation context
#' @return a character
#' @export
#'
#' @examples
#' rv_context('A[C>G]T')
rv_context = function(context) {
  split1 = unlist(strsplit(context, '[', fixed = T)); left = split1[1]
  split2 = unlist(strsplit(split1[2], ']', fixed = T)); mut = split2[1]; right = split2[2]
  comp_mut = complementary_mut(mut)
  comp_left = as.character(Biostrings::reverseComplement(Biostrings::DNAString(left)))
  comp_right = as.character(Biostrings::reverseComplement(Biostrings::DNAString(right)))
  return(paste0(comp_right, "[", comp_mut, "]", comp_left, sep = ''))
}


#' if the starting base is A or G, takes a mutation context and outputs its reverse complementary counterpart. The resulting mutations should always start with either a C or a T
#'
#' @param context a character of mutation context
#' @return a character
#' @export
#'
#' @examples
#' strand_symmetric('A[C>G]T')
#' strand_symmetric('A[A>G]T')
strand_symmetric = function(context) {
  split1 = unlist(strsplit(context, '[', fixed = T))[2]
  mut = unlist(strsplit(split1, '>'))[1]
  result = ifelse(mut %in% c('A','G'), rv_context(context), context)
  return(result)
}

