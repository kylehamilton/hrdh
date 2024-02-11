library(testthat)
library(hrdh)

context("Tests for convertMaidenheadToLatLon function")

# Test valid inputs
test_that("Valid inputs return correct coordinates", {
  expect_equal(convertMaidenheadToLatLon("CM97"), c(Latitude = 37.5, Longitude = -121.0))
  expect_equal(convertMaidenheadToLatLon("DM07"), c(Latitude = 37.5, Longitude = -119.0))
})

# Test input validation
test_that("Invalid inputs return NA", {
  expect_equal(convertMaidenheadToLatLon("XXXXXX"), c(Latitude = NA, Longitude = NA))
  expect_equal(convertMaidenheadToLatLon("123456"), c(Latitude = NA, Longitude = NA))
  expect_equal(convertMaidenheadToLatLon(""), c(Latitude = NA, Longitude = NA))
})
