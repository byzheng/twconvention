# Get Standard Names for Given Names

This function retrieves the standard name for a given name by matching
against TiddlyWiki tiddler titles and their aliases (aka field). The
function uses filtering to obtain a list of relevant tiddlers and
performs matching using both the tiddler title and the aka field (which
contains a list of alternative tiddler titles). When a match is found,
the tiddler's title is returned as the standard name.

## Usage

``` r
standard_name(names, filter, case_sensitive = FALSE)
```

## Arguments

- names:

  Character string. The name to find the standard form for.

- filter:

  Character string. Filter expression for tiddlers.

- case_sensitive:

  Logical. Whether the matching should be case sensitive. FALSE by
  default.

## Value

Character string. The standard name (tiddler title) corresponding to the
input name, or the original name if no match is found.

## Examples

``` r
if (FALSE) { # \dontrun{
# Assuming you have a tiddlers dataset
standard_name <- get_standard_name("alternative_name", "[tag[ExampleTag]]")
} # }
```
