test_that("tiddler", {
    skip_if(!is_test_tw())


    # Inject test data
    for (i in seq_len(10)) {
        id <- sprintf("Variety %s", i)
        id_aka <- c(sprintf("variety%s", i), sprintf("apsim_variety%s", i))
        rtiddlywiki::put_tiddler(id, text="", tags = c("Variety", "test"),
                                fields = list(aka = id_aka, crop = "Wheat"))
    }
    id <- sprintf("Variety %s", 12)
    rtiddlywiki::put_tiddler(id, text="", tags = c("Variety"),
                                fields = list(aka = paste0("[[", id, "]]"), crop = "Wheat"))
    # standard_name
    names <- c(paste0("variety", seq(1, 11)), "Variety 12")
    filter <- "[tag[Variety]]"
    sname <- standard_name(c(paste0("variety", seq(1, 11)), "Variety 12"), "[tag[Variety]]")
    expect_equal(length(sname), 12)
    expect_equal(c(paste0("Variety ", seq(1, 10)), NA, "Variety 12"), sname)

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


