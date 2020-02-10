#' PUT new file on WebDAV server
#'
#' PUTs new file into a WebDAV drive, in the HTTP sense:
#' Existing files at the same `url` are overwritten.
#' Will retry as per [httr::retry()].
#'
#' @param local `character[1]`, giving the path to the local file to upload.
#' @param url `character[1]`, giving the path to the file to create or overwrite on the WebDAV server.
#' Remember to include the target filename.
#' @param user `character[1]`, giving the username to log in with.
#'
#' @export
#'
#' @return [httr::response]
webdav_put <- function(local, url, user) {
  checkmate::assert_file_exists(x = local)
  checkmate::assert_string(x = url, null.ok = FALSE)
  checkmate::assert_string(x = user, null.ok = FALSE)

  r <- httr::RETRY(
    verb = "PUT",
    url = url,
    config = httr::authenticate(
      user = user,
      password = getPass::getPass(),
      type = "basic"
    ),
    body = httr::upload_file(path = local, type = "application/octet-stream"),
    ua
  )

  httr::stop_for_status(x = r, task = "upload")
}

