#' PUT new file on WebDAV server
#'
#' PUTs new file into a WebDAV drive, in the HTTP sense:
#' Existing files at the same `url` are overwritten.
#' Will retry as per [httr::RETRY()].
#'
#' @param local `character[1]`, giving the path to the local file to upload.
#' @param remote `character[1]`, giving the path to the file to create or overwrite on the WebDAV server.
#' Remember to include the target filename.
#' @inheritParams passhelpr::get_pass2
#'
#' @details
#' The request is authenticated using [passhelpr::authenticate2()], with the `service` as the domain root from remote.
#'
#' @export
#'
#' @return [httr::response]
webdav_put <- function(local, remote, user, password, keyring) {
  checkmate::assert_file_exists(x = local)
  checkmate::assert_string(x = remote, null.ok = FALSE)
  r <- httr::RETRY(
    verb = "PUT",
    url = remote,
    config = passhelpr::authenticate2(user = user, password = password, service = remote),
    body = httr::upload_file(path = local, type = "application/octet-stream"),
    ua
  )

  httr::stop_for_status(x = r, task = "upload")
}
