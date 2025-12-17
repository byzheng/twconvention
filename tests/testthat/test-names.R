test_that("tiddler", {
    skip_if(!is_test_tw())


    # Inject test data
    for (i in seq_len(10)) {
        id <- sprintf("Variety %s", i)
        id_aka <- c(sprintf("variety%s", i), sprintf("apsim_variety%s", i))
        rtiddlywiki::put_tiddler(id, text="", tags = c("Variety", "test"),
                                fields = list(aka = id_aka, crop = "Wheat"))
    }

    # standard_name
    names <- paste0("variety", seq(1, 11))
    filter <- "[[wroing-filter]]"
    sname <- standard_name(paste0("variety", seq(1, 11)), "Variety")
    expect_equal(c(paste0("Variety ", seq(1, 10)), NA), sname)

    # Case sensitive
    names <- c("Variety1", "Variety2", "VARIETY3", "variety4")
    sname_cs <- standard_name(names, "[tag[Variety]]", case_sensitive = TRUE)
    expect_equal(c(NA, NA, NA, "Variety 4"), sname_cs)
    # Error cases
    expect_error(standard_name(names, c("A", "B")))
    expect_error(standard_name(names, "[[wroing-filter]]"))
    expect_error(standard_name(NULL, "[tag[Variety]]"))

    # Clean tiddlers
    tiddlers <- rtiddlywiki::get_tiddlers("[tag[Variety]]")
    for (i in seq(along = tiddlers)) {
        rtiddlywiki::delete_tiddler(tiddlers[[i]]$title)
    }
})


