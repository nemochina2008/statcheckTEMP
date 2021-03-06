\name{statcheck}
\alias{statcheck}
\title{Extract statistics and recompute p-values.}
\description{This function extracts statistics from strings and returns the extracted values, reported p-values and recomputed p-values. The package relies on the program "pdftotext", see the paragraph "Note" for details on the installation.}
\usage{statcheck(x, stat = c("t", "F", "cor", "chisq", "Z"), OneTailedTests = FALSE, 
    alpha = 0.05, OneTailedTxt = FALSE, AllPValues = FALSE)}\arguments{
  \item{x}{A vector of strings containing whole articles.}
  \item{stat}{"t" to extract t-values, "F" to extract F-values, "cor" to extract correlations, "chisq"to extract chi-square values, and "Z" to extract Z-values.}
  \item{OneTailedTests}{Logical. Do we assume that all reported tests are one tailed (TRUE) or two tailed (FALSE, default)?}
  \item{alpha}{Assumed level of significance in the scanned texts. Defaults to .05. }
  \item{OneTailedTxt}{Logical. If TRUE, statcheck searches the text for "sided", "tailed", and "directional" to identify the possible use of one-sided tests. If one or more of these strings is found in the text AND the result would have been correct if it was a one-sided test, the result is assumed to be indeed one-sided and is counted as correct.}
  \item{AllPValues}{Logical. If TRUE, the output will consist of a dataframe with all detected p values, also the ones that were not part of the full results in APA format}
}
\details{Statcheck uses regular expressions to find statistical results in APA format. When a statistical result deviates from APA format, statcheck will not find it. The APA formats that statcheck uses are: t(df) = value, p = value; F(df1,df2) = value, p = value; r(df) = value, p = value; [chi]2 (df, N = value) = value, p = value (N is optional, delta G is also included); Z = value, p = value. All regular expressions take into account that test statistics and p values may be exactly (=) or inexactly (< or >) reported. Different spacing has also been taken into account.
This function can be used if the text of articles has already been imported in R. To import text from pdf files and automatically send the results to this function use \code{\link{checkPDFdir}} or \code{\link{checkPDF}}. To import text from HTML files use the similar functions \code{\link{checkHTMLdir}} or \code{\link{checkHTML}}. Finally, \code{\link{checkdir}} can be used to import text from both PDF and HTML files in a folder.
Note that the conversion from PDF (and sometimes also HTML) to plain text and extraction of statistics can result in errors. Some statistical values can be missed, especially if the notation is unconventional. It is recommended to manually check some of the results.
PDF files should automatically be converted to plain text files. However, if this does not work, it might help to manually install the program "pdftotext". You can obtain pdftotext from \code{http://www.foolabs.com/xpdf/download.html}. Download and unzip the precompiled binaries. Next, add the folder with the binaries to the PATH variables so that this program can be used from command line.
Also, note that a seemingly inconsistent p value can still be correct when we take into account that the test statistic might have been rounded after calculating the corresponding p value. For instance, a reported t value of 2.35 could correspond to an actual value of 2.345 to 2.354 with a range of p values that can slightly deviate from the recomputed p value. Statcheck will not count cases like this as errors.}
\value{A data frame containing for each extracted statistic:
Source: Name of the file of which the statistic is extracted

Statistic: Character indicating the statistic that is extracted

df1: First degree of freedom

df2: Second degree of freedom (if applicable)

Test.Comparison: Reported comparison of the test statistic, when importing from pdf this will often not be converted properly

Value: Reported value of the statistic

Reported.Comparison: Reported comparison of the p value, when importing from pdf this will often not be converted properly

Reported.P.Value: The reported p-value, or NA if the reported value was NS

Computed: The recomputed p-value

Raw: Raw string of the statistical reference that is extracted

Error: The computed p value is not congruent with the reported p value

DecisionError: The reported result is significant whereas the computed result is not, or vice versa.

OneTail: Logical. Is it likely that the reported p value resulted from a correction for one-sided testing?

OneTailedInTxt: Logical. Does the text contain the string "sided", "tailed", and/or "directional"?

CopyPaste: Logical. Does the exact string of the extracted raw results occur anywhere else in the article?
}

\author{Sacha Epskamp <mail@sachaepskamp.com> & Michele B. Nuijten <m.b.nuijten@uvt.nl>}



\seealso{\code{\link{checkPDF}}, \code{\link{checkHTMLdir}}, \code{\link{checkHTML}}, \code{\link{checkdir}}}
\examples{
txt <- "blablabla the effect was very significant (t(100)=1, p < 0.001)"
statcheck(txt)
}
