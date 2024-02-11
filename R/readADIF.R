#' Read ADIF File
#'
#' Reads an Amateur Data Interchange Format (ADIF) file and converts it into a dataframe. Each record in the ADIF file is transformed into a row in the dataframe.
#'
#' @author W. Kyle Hamilton
#'
#' @param filePath A string specifying the path to the ADIF file to be read.
#'
#' @return A dataframe where each row represents a record from the ADIF file. Columns correspond to tags found in the ADIF records, with column names matching tag names.
#'
#' @examples
#'
#' df <- readADIF(system.file("extdata", "KG6BXW.adif", package="ADIF"))
#' head(df)
#'
#' @importFrom utils strcapture
#' @export

readADIF <- function(filePath) {
  lines <- readLines(filePath)
  records <- list()

  # Pattern to match tag and value, ignoring tag length
  pattern <- "<([^>:]+):\\d+>([^<]+)"

  for (line in lines) {
    if (grepl("<eor>", line)) {
      matches <- gregexpr(pattern, line, perl = TRUE)
      tagValues <- regmatches(line, matches)

      currentRecord <- list()

      for (tagValue in tagValues[[1]]) {
        components <- strcapture(pattern, tagValue, proto = list(tag = character(), value = character()))
        currentRecord[[components$tag]] <- components$value
      }
      records <- append(records, list(currentRecord))
    }
  }

  # Convert the list of records into a dataframe
  df <- do.call(rbind, lapply(records, function(x) data.frame(as.list(x), stringsAsFactors = FALSE)))
  rownames(df) <- NULL

  return(df)
  # KG6BXW
}
