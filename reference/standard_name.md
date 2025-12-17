# Get standard names

Get standard names

## Usage

``` r
standard_name(names, filter)
```

## Arguments

- names:

  A character vector for names

- group:

  Group of standard names

- is_apsim_name:

  whether to return names only if group is "Variety".

## Value

A vector for standard name if is_apsim_name is FALSE, but a data.frame
of standard_name and apsim_name if is_apsim_name is TRUE.
