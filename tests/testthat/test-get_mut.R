test_that("get_mut() gets the central mutation", {
  expect_equal(get_mut("A[C>T]G"), "C>T")
  expect_equal(get_mut("C>T"), "C>T")
})


test_that("get_context_param() works", {
  mut_dt = data.frame(
    donor_id = c("PD1", "PD2"),
    chromosome = c("3", "X"),
    chrom_start = c(5, 7),
    chrom_end = c(5,
                  7),
    reference_genome_allele = c("A", "C"),
    mutated_from_base = c("A", "C"),
    mutated_to_base = c("T", "A")
  )
  seq = seqinr::s2c("AGCTAGCTGA")
  get_context = get_context_param(seq, k = 3)
  result = apply(mut_dt, MARGIN = 1, get_context)
  expected = c("T[A>T]G", "G[C>A]T")
  expect_equal(result, expected)
})

test_that("get_context_param() even number error", {
  mut_dt = data.frame(
    donor_id = c("PD1", "PD2"),
    chromosome = c("3", "X"),
    chrom_start = c(5, 7),
    chrom_end = c(5,
                  7),
    reference_genome_allele = c("A", "C"),
    mutated_from_base = c("A", "C"),
    mutated_to_base = c("T", "A")
  )
  seq = seqinr::s2c("AGCTAGCTGA")
  expect_error(get_context_param(seq, k = 4),
               "k should be an odd number greater than 1",
               fixed = T)
  expect_error(get_context_param(seq, k = 12),
               "k should be an odd number greater than 1",
               fixed = T)
})

test_that("get_context_param() mut_dt differs from reference genome", {
  mut_dt = data.frame(
    donor_id = c("PD1", "PD2"),
    chromosome = c("3", "X"),
    chrom_start = c(5, 7),
    chrom_end = c(5,
                  7),
    reference_genome_allele = c("G", "C"),
    mutated_from_base = c("A", "C"),
    mutated_to_base = c("T", "A")
  )
  seq = seqinr::s2c("AGCTAGCTGA")
  get_context = get_context_param(seq, k = 3)
  expect_error(
    apply(mut_dt, MARGIN = 1, get_context),
    "reference base from mutation dataframe should be the same as in the genome assembly",
    fixed = T
  )
})

test_that("get_context_param() mut_dt chrom_start differs from chrom_end",
          {
            mut_dt = data.frame(
              donor_id = c("PD1", "PD2"),
              chromosome = c("3", "X"),
              chrom_start = c(5, 7),
              chrom_end = c(8,
                            7),
              reference_genome_allele = c("A", "C"),
              mutated_from_base = c("A", "C"),
              mutated_to_base = c("T", "A")
            )
            seq = seqinr::s2c("AGCTAGCTGA")
            get_context = get_context_param(seq, k = 3)
            expect_error(
              apply(mut_dt, MARGIN = 1, get_context),
              "sbs should have the same chrom_start and chrom_end",
              fixed = T
            )
          })

test_that("get_context_param() works with format_ = 'simplified'", {
  mut_dt = data.frame(
    SampleID = c("PD1", "PD2"),
    Chr = c("3", "X"),
    Pos = c(5, 7),
    Ref = c("A", "C"),
    Alt = c("T", "A")
  )
  seq = seqinr::s2c("AGCTAGCTGA")
  get_context = get_context_param(seq, k = 3, format_ = 'simplified')
  result = apply(mut_dt, MARGIN = 1, get_context)
  expected = c("T[A>T]G", "G[C>A]T")
  expect_equal(result, expected)
})
