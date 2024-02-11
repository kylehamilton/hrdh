#' Read a Cabrillo File
#'
#' Reads a Cabrillo file and extracts QSO (contact) data into a tibble. Optionally, it can also extract and return header information from the Cabrillo file.
#'
#' @author W. Kyle Hamilton
#'
#' @param filePath A string specifying the path to the Cabrillo file to be read.
#' @param includeHeader A logical value indicating whether to include the file's header information in the output. If TRUE, the function returns a list with two elements: `Header` containing header information, and `QSOs` containing the QSO data as a tibble. If FALSE, only the QSO data is returned as a tibble.
#'
#' @return If `includeHeader` is FALSE, returns a tibble where each row represents a QSO. If `includeHeader` is TRUE, returns a list with two elements: `Header`, a list of header information, and `QSOs`, a tibble of QSO data.
#'
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
#'
#' @examples
#' \dontrun{
#' qsos <- readCabrillo("KG6BXW.log")
#' # To include header information in the output
#' qsosWithHeader <- readCabrillo("KG6BXW.log", includeHeader = TRUE)
#' }
#'
#' @export

readCabrillo <- function(filePath, includeHeader = FALSE) {
  qsos <- list()
  headerInfo <- list()

  lines <- readLines(filePath)

  # Process each line
  for (line in lines) {
    if (grepl("^QSO:", line)) {
      parts <- strsplit(line, " +")[[1]]
      qsos[[length(qsos) + 1]] <- tibble(
        Frequency = parts[2],
        Mode = parts[3],
        Date = parts[4],
        Time = parts[5],
        CallSent = parts[6],
        RSTSent = parts[7],
        ExchangeSent = parts[8],
        CallReceived = parts[9],
        RSTReceived = parts[10],
        ExchangeReceived = parts[11]
      )
    } else if (includeHeader == TRUE) {
      # Process header lines only if includeHeader is TRUE
      headerParts <- strsplit(line, ":", fixed = TRUE)
      if (length(headerParts[[1]]) == 2) {
        key <- strtrim(headerParts[[1]][1], nchar(headerParts[[1]][1]))
        value <-
          strtrim(headerParts[[1]][2], nchar(headerParts[[1]][2]))
        headerInfo[[key]] <- value
      }
    }
  }

  # Combine all QSOs into a single dataframe
  qsosDF <- bind_rows(qsos)

  if (includeHeader) {
    return(list(Header = headerInfo, QSOs = qsosDF))
  } else {
    return(qsosDF)
  }
}
