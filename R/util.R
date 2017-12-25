#' Is an property valid?
#'
#' Compates `property` against a list of known, valid "graph" properties
#' and returns `TRUE` if valid.
#'
#' @md
#' @param property property to compare
#' @export
is_valid_property <- function(property) { property %in% .valid_properties }