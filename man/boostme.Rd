% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/boostme.R
\name{boostme}
\alias{boostme}
\title{Function for training and and imputing with a boostme model.}
\usage{
boostme(bs, impute = TRUE, randomCpGs = TRUE, trainChr = "chr3",
  validateChr = "chr22", testChr = "chr4", trainSize = 1e+06,
  validateSize = 1e+06, testSize = 1e+06, minCov = 10, sampleAvg = TRUE,
  neighbMeth = TRUE, neighbDist = TRUE, featureBEDs = NULL, mask = FALSE,
  filterDist = 1000, threads = 2, seed = 1, save = NULL, verbose = TRUE)
}
\arguments{
\item{bs}{a bsseq object containing the methylation & coverage values
as well as the features loaded into \code{pData(bs)}. If no features
are loaded into \code{pData(bs)}, the model will simply use neighboring
CpGs and the sample average of the other CpGs.}

\item{impute}{boolean of whether or not to impute CpG methylation
values below the minCov. Default is TRUE. Set to FALSE if want to do a dry
run and see the RMSE for each sample.}

\item{randomCpGs}{logical value of whether or not to select a simple random
sample of CpGs genome-wide or not. If TRUE, will ignore the trainChr,
validateChr, and testChr parameters and select CpGs for the
training, validation, and test sets at random. Can modify how large
each of these sets will be individually using the trainSize, validateSize,
and testSize parameters. Defaults are 1 million CpGs each. Default is TRUE.}

\item{trainChr}{which chromosome(s) to use for training.
default = chr3 (approximately 1.5 million CpGs). Note that the more CpGs
used for training, the more memory required to train and store the model.}

\item{validateChr}{which chromosome(s) to use for validation.
default = chr22 (approximately 550,000 CpGs).}

\item{testChr}{which chromosome(s) to use for testing.
default = chr4 (approximately 1.4 million CpGs).}

\item{trainSize}{integer of how many CpGs to use for train set. Default is
1 million. NOTE: only kicks into effect when randomCpGs = TRUE.}

\item{validateSize}{integer of how many CpGs to use for validation set.
Default is 1 million. NOTE: only kicks into effect when randomCpGs = TRUE.}

\item{testSize}{integer of how many CpGs to use for test set. Default is 1
million. NOTE: only kicks into effect when randomCpGs = TRUE.}

\item{minCov}{the minimum coverage required to consider a methylation
value trainable, default is 10 (i.e. 10 total reads at a CpG). Also used
as the cutoff below which to impute and replace the methylation value, given
that none of the features used for that CpG are NA. E.g. if a CpG has
coverage of 2, but sampleAvg = TRUE and < 2 samples have coverage >=10 for
that CpG, then that CpG's value will not be imputed and replaced.}

\item{sampleAvg}{logical value of whether to not to include the sample
average as a feature. Default is TRUE.}

\item{neighbMeth}{logical value of whether or not to include nearest non-
missing neighboring CpG methylation values. Default is TRUE.}

\item{neighbDist}{logical value of whether or not to include nearest non-
missing neighboring CpG distances. Default is TRUE.}

\item{featureBEDs}{optional vector of paths to BED files to be included
as features in the model. If the file only has 3 columns, assumes that the
file is just one feature. If the file has 4 columns, 4th column is considered
to be the feature(s). If the 4th column has multiple factors (i.e. multiple
different strings) then each factor is converted to its own binary feature
(1 if present, else 0). Ignores all columns past the 4th. Ranges must be
non-overlapping (can be solved with \code{bedtools merge} or separating into
multiple BED files).}

\item{mask}{logical value of whether to mask all unimputed values as NA
in resulting data frame.}

\item{filterDist}{integer of the maximam value of neighbDist to use for
training. Default is 1000.}

\item{threads}{(optional) number of threads to use for training. default = 2}

\item{seed}{optional integer random seed used before selecting random CpGs
for training/validation/testing.}

\item{save}{(optional) file path to save metrics to (e.g. results.txt)}

\item{verbose}{logical value of whether to print status messages. Default is
TRUE.}
}
\value{
a matrix that has the imputed values (if impute is TRUE). Otherwise
doesn't return anything; just prints RMSE for each sample (dry run).
}
\description{
Uses the \code{xgboost} framework (C) Tianqi Chen, Tong He, Michael Benesty,
Vadim Khotilovich, Yuan Tang. Sample average feature requires at
least 3 samples in the bsseq object.
}
