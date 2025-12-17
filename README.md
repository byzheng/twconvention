
> [!CAUTION]
> This package will modify and delete tidders in Tiddlywiki. Use it with caution. 
> Create a backup and test it before using,


# twconvention
![R-CMD-check](https://github.com/byzheng/twconvention/workflows/R-CMD-check/badge.svg)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/twconvention)](https://cran.r-project.org/package=twconvention)


'TWConventions' provides utilities for encoding and enforcing conventions and semantic meaning 
of TiddlyWiki tiddler titles, fields, and tags. It includes functions to handle canonical 
names, alternative names (aka), project-specific inclusion rules, and other structured 
assumptions about TiddlyWiki content. The package allows R scripts and projects to reliably 
interpret TiddlyWiki data according to standardized conventions without depending on 
transport or workflow mechanisms.

## Installation

Install the developing version from [Github](https://github.com/byzheng/twconvention).
```r
remotes::install_github('byzheng/twconvention')
```
