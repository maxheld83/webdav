test_that("upload", {
  testthat::expect_error(
    object = {
      webdav_put(
        local = test_path("test-webdav_put.R"),
        remote = "https://www.maxheld.de",  # does not have WebDAV
        user = "info@maxheld.de",
        password = "foo"
      )
    }
  )
  testthat::expect_s3_class(
    object = {
      webdav_put(
        local = test_path("test-webdav_put.R"),
        remote = "https://my.powerfolder.com/webdav/webdav-test/test-webdav_put.R",
        user = "info@maxheld.de",
        password = Sys.getenv("POWERFOLDER_PW")
      )
    },
    class = "response"
  )
})
