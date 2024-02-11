#' Log Data from KG6BXW
#'
#' Log data from a short WSJT-X for FT8 contacts made by the author.
#'
#' @author W. Kyle Hamilton
#'
#' @format A data.frame with 18 rows and 13 columns
#' \describe{
#'   \item{call}{\code{character} Amateur station call signs contacted.}
#'   \item{gridsquare}{\code{character} Maidenhead grid square of the station contacted.}
#'   \item{mode}{\code{character} Mode of communication, e.g., FT8.}
#'   \item{rst_sent}{\code{character} Readability, Signal strength, and Tone sent.}
#'   \item{rst_rcvd}{\code{character} Readability, Signal strength, and Tone received.}
#'   \item{qso_date}{\code{numeric} Date of the QSO (contact) start, format YYYYMMDD.}
#'   \item{time_on}{\code{character} Time of the QSO start, format HHMMSS.}
#'   \item{qso_date_off}{\code{numeric} Date of the QSO end, format YYYYMMDD.}
#'   \item{time_off}{\code{character} Time of the QSO end, format HHMMSS.}
#'   \item{band}{\code{character} Band of operation, e.g., 20m, 40m.}
#'   \item{freq}{\code{numeric} Frequency of operation in MHz.}
#'   \item{station_callsign}{\code{character} Callsign of the operator's station.}
#'   \item{my_gridsquare}{\code{character} Maidenhead grid square of the operator's station.}
#' }
#'
#' @keywords datasets
#'
#' @source Hamilton, W. K. (2024).
"KG6BXW"
