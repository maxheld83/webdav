test_that("upload", {
  skip(message = "needs non-interactive auth")
  testthat::expect_error(
    object = {
      webdav_put(
        local = "test-webdav_put.R",
        url = "https://www.maxheld.de",  # does not have WebDAV
        user = "info@maxheld.de"
      )
    }
  )
  testthat::expect_s3_class(
    object = {
      webdav_put(
        local = "test-webdav_put.R",
        url = "https://my.powerfolder.com/webdav/webdav-test/test-webdav_put.R",
        user = "info@maxheld.de"
      )
    },
    class = "response"
  )
})
