
#' plots mutation spectra for the 3-mer
#'
#' @param spectra_dt spectra data, a dataframe with columns kmer and value, where value can be anything correponding to kmer
#' @param cols colour vector
#' @return a ggplot of spectra
#' @import ggplot2
#' @export
#'
spectra_plot = function(spectra_dt, cols = NULL) {
  spectra = spectra_dt
  spectra$muts = sapply(spectra$kmer, get_mut)
  spectra = dplyr::arrange(spectra, muts, kmer)
  spectra$short_kmer = sapply(spectra$kmer, get_wt_seq)

  xmin_rect = seq(0,95,16); xmax_rect = seq(15,96,16)

  # define the colours
  if (is.null(cols)) cols = c("dodgerblue","black","red","grey70","olivedrab3","plum2")
  mut_types = c("C>A", "C>G", "C>T", "T>A", "T>C", "T>G")
  names(cols) = mut_types

  p1 = ggplot2::ggplot(spectra,mapping=aes(x=kmer, y=value,fill=muts)) +
    scale_x_discrete(limits = spectra$kmer, labels = spectra$short_kmer) +
    scale_fill_manual(values = cols) +
    annotate('segment',x=xmin_rect, xend = xmax_rect, y = Inf, yend = Inf, col = cols, linewidth = 10) +
    geom_col() +
    annotate('text',x=0:5 * 16 + 8,y=rep(Inf,6), label=mut_types, vjust = 3) +
    xlab('') +
    ggpubr::theme_pubr(legend = 'none', x.text.angle = 90) +
    theme(axis.text.x=element_text(size=rel(0.5), angle=90))

  return(p1)
}

