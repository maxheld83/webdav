#' Authenticate against WebDAV server
#'
#' @param user `character[1]`, giving the username to use for interactive "basic" authentication with username and password (not recommended).
#' Defaults to `NULL`, in which case presently an error is thrown.
#' @export
webdav_auth <- function(user = NULL) {
  if (is.null(user)) {
    stop("No authentication procedure available.")
  } else {
    requireNamespace2(x = "getPass")
    httr::authenticate(
      user = user,
      password = getPass::getPass(),
      type = "basic"
    )
  }
}