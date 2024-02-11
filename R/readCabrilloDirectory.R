#' Read Cabrillo Files from Directory
#'
#' Reads all Cabrillo (.log) files from a specified directory and compiles them into a single dataframe. Optionally includes the Cabrillo file header in the output.
#'
#' @author W. Kyle Hamilton
#'
#' @param directoryPath The path to the directory containing Cabrillo files.
#' @param includeHeader Logical, indicating whether to include the file header in the output. Defaults to FALSE.
#'
#' @return A tibble containing all QSOs from the Cabrillo files in the directory, with each row representing a QSO.
#'
#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
#'
#' @examples
#' \dontrun{
#' # Assuming 'Data/' directory contains Cabrillo (.log) files
#' completeDF <- readCabrilloDirectory("Data/")
#'}
#'
#' @export

readCabrilloDirectory <-
  function(directoryPath, includeHeader = FALSE) {
    readCabrillo <- function(filePath) {
      qsos <- list()

      lines <- readLines(filePath)

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
        }
      }

      qsosDF <- bind_rows(qsos)
      return(qsosDF)
    }

    cabrilloFiles <-
      list.files(directoryPath, pattern = "\\.log$", full.names = TRUE)

    dfs <- list()

    for (filePath in cabrilloFiles) {
      dfs <- append(dfs, list(readCabrillo(filePath)))
    }

    completeDF <- bind_rows(dfs)

    return(completeDF)
  }


