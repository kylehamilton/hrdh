#' Convert Maidenhead Locator to Latitude and Longitude
#'
#' This function takes a Maidenhead locator string and converts it into
#' geographic coordinates (latitude and longitude). The Maidenhead locator
#' system is commonly used by amateur radio operators. The function supports
#' locators of 4 or 6 characters length.
#'
#' @author W. Kyle Hamilton
#'
#' @param maidenhead A string representing the Maidenhead locator.
#' @return A named vector with `Latitude` and `Longitude` values in decimal degrees. Returns `NA` for both `Latitude` and `Longitude` if the input format is incorrect.
#'
#' @references Tyson, E. T. (1989) Conversion Between Geodic and Grid Locator Systems. QST, 30-43.
#'
#' @importFrom stats setNames
#'
#' @examples
#' convertMaidenheadToLatLon("DM07CE")
#' convertMaidenheadToLatLon("CM97SH")
#'
#' @export

convertMaidenheadToLatLon <- function(maidenhead) {
  # Default NA output if the input doesn't match the expected format
  if (!grepl("^[A-R]{2}[0-9]{2}([A-X]{2})?$", maidenhead)) {
    return(c(Latitude = NA, Longitude = NA))
  }

  # Define the size of the grid
  lon_size <- 20
  lat_size <- 10

  # Initialize latitude and longitude
  lat <- NA
  lon <- NA

  # Parse the Maidenhead locator
  if (nchar(maidenhead) == 4 || nchar(maidenhead) == 6) {
    # First two letters
    lon_field <- (as.integer(charToRaw(substr(maidenhead, 1, 1))) - 65) * lon_size
    lat_field <- (as.integer(charToRaw(substr(maidenhead, 2, 2))) - 65) * lat_size

    # Next two numbers
    lon_square <- as.numeric(substr(maidenhead, 3, 3)) * (lon_size / 10)
    lat_square <- as.numeric(substr(maidenhead, 4, 4)) * (lat_size / 10)

    # Calculate initial longitude and latitude
    lon <- lon_field + lon_square - 180
    lat <- lat_field + lat_square - 90

    # If the locator is 6 characters long, calculate subsquare
    if (nchar(maidenhead) == 6) {
      lon_subsquare <- ((as.integer(charToRaw(substr(maidenhead, 5, 5))) - 65) * (lon_size / 240)) + (lon_size / 240 / 2)
      lat_subsquare <- ((as.integer(charToRaw(substr(maidenhead, 6, 6))) - 65) * (lat_size / 240)) + (lat_size / 240 / 2)

      lon <- lon + lon_subsquare
      lat <- lat + lat_subsquare
    } else {
      # Adjust to center of the grid square
      lon <- lon + (lon_size / 10 / 2)
      lat <- lat + (lat_size / 10 / 2)
    }
  }

  # Return as a named vector for simplicity
  return(c(Latitude = lat, Longitude = lon))
}
