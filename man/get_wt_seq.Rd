% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_wt.R
\name{get_wt_seq}
\alias{get_wt_seq}
\title{Get the original wildtype sequence given the mutations, this is useful for example to get the x ticks in the difference plot}
\usage{
get_wt_seq(mut)
}
\arguments{
\item{mut}{a character of mutation in kmer, eg 'A\link{C>T}G'}
}
\value{
a character of the original sequence
}
\description{
Get the original wildtype sequence given the mutations, this is useful for example to get the x ticks in the difference plot
}
\examples{
get_wt_seq('A[C>T]G')
}
