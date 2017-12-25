.read_parsed_doc <- function(x, ...) {

  props <- html_nodes(x, xpath=".//meta[contains(@property, ':')]")

  if (length(props) == 0) return(NULL)

  props_attr <- html_attr(props, "property")
  props_attr <- trimws(tolower(props_attr))

  props_split <- stri_split_fixed(props_attr, ":", 3,
                                  omit_empty = FALSE, simplify = TRUE)
  props_split <- data.frame(props_split, stringsAsFactors = FALSE)
  props_split <- set_names(props_split, c("prefix", "tag", "extra"))
  props_split[props_split[["extra"]] == "", "extra"] <- NA_character_
  props_split[["value"]] <- html_attr(props, "content")
  props_split[["timestamp"]] <- Sys.time()
  props_split[["property"]] <- props_attr

  class(props_split) <- c("tbl_df", "tbl", "data.frame")

  props_split

}

#' Read Open Graph tags from an HTML document
#'
#' @param x URL or parsed HTML/XML document
#' @param ... Additional arguments passed on to methods.
#' @export
read_properties <- function(x, ...) { UseMethod("read_properties") }

#' @export
#' @rdname read_properties
read_properties.character <- function(x, ...) {
  pg <- xml2::read_html(x, ...)
  .read_parsed_doc(pg, ...)
}

#' @export
#' @rdname read_properties
read_properties.html_document <- function(x, ...) { .read_parsed_doc(x, ...) }

#' @export
#' @rdname read_properties
read_properties.xml_document <- function(x, ...) { .read_parsed_doc(x, ...) }

#' @export
#' @rdname read_properties
read_properties.response <- function(x, ...) {
  pg <- xml2::read_html(x, ...)
  .read_parsed_doc(pg, ...)
}

#' @export
#' @rdname read_properties
read_properties.raw <- function(x, ...) {
  pg <- xml2::read_html(x, ...)
  .read_parsed_doc(pg, ...)
}