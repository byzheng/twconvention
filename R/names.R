#' Get Standard Names for Given Names
#'
#' This function retrieves the standard name for a given name by matching against
#' TiddlyWiki tiddler titles and their aliases (aka field). The function uses
#' filtering to obtain a list of relevant tiddlers and performs matching using
#' both the tiddler title and the aka field (which contains a list of alternative
#' tiddler titles). When a match is found, the tiddler's title is returned as
#' the standard name.
#'
#' @param names Character string. The name to find the standard form for.
#' @param filter Character string. Filter expression for tiddlers.
#' @param case_sensitive Logical. Whether the matching should be case sensitive. FALSE by default.
#'
#' @return Character string. The standard name (tiddler title) corresponding
#'   to the input name, or the original name if no match is found.
#' 
#' @examples
#' \dontrun{
#' # Assuming you have a tiddlers dataset
#' standard_name <- get_standard_name("alternative_name", "[tag[ExampleTag]]")
#' }
#' @export
standard_name <- function(names, filter, case_sensitive = FALSE) {

    stopifnot(is.character(filter))
    stopifnot(length(filter) == 1)
    stopifnot(is.vector(names))
    stopifnot(length(names) > 0)

    tiddlers <- rtiddlywiki::get_tiddlers(filter)

    if (length(tiddlers) == 0) {
        stop("No tiddlers found for filter: ", filter)
    }
    i <- 1
    all_names <- list()
    for (i in seq(along = tiddlers)) {
        aka_titles <- tiddlers[[i]]$title
        if (!is.null(tiddlers[[i]]$aka)) {
            aka_i <- rtiddlywiki::split_field(tiddlers[[i]]$aka)
            aka_titles <- c(aka_titles, aka_i)
        }
        
        if(!case_sensitive) {
            aka_titles <- tolower(aka_titles)
        }
        aka_titles <- unique(aka_titles)
        all_names[[i]] <- tibble::tibble(
            standard_name = tiddlers[[i]]$title,
            aka = aka_titles
        )
    }
    all_names <- do.call(rbind, all_names)
    dup_aka <- all_names |> 
        dplyr::count(.data$aka) |> 
        dplyr::filter(.data$n > 1)
    if (nrow(dup_aka) > 0) {
        dup_aka <- dup_aka |> 
            dplyr::select("aka") |> 
            dplyr::left_join(all_names, by = "aka") |> 
            dplyr::rename(tiddler = "standard_name") |>
            dplyr::select("tiddler", "aka") |>
            as.data.frame()
        tbl_text <- paste(
            utils::capture.output(print(dup_aka)),
            collapse = "\n"
        )
        stop("Duplicate aka entries found in tiddlers: \n", tbl_text)
    }
    input_names <- names
    if(!case_sensitive) {
        input_names <- tolower(input_names)
    }
    standard_names <- tibble::tibble(input_name = input_names) |>
        dplyr::left_join(all_names, by = c("input_name" = "aka")) |>
        dplyr::pull(standard_name)
    if (length(standard_names) != length(names)) {
        stop("Length of output does not match length of input names.")
    }
    return(standard_names)
}
