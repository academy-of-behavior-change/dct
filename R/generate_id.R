#' Generate unique identifier(s)
#'
#' To allow unique reference to constructs, they require unique identifiers.
#' These functions generate such identifiers by combining one or more identifier
#' prefixes (usually a human-readable construct name such as 'attitude') with
#' a unique identifier based on the second the identifier was generated. The
#' identifier prefix may only contain lowercase and uppercase letters and
#' underscores.
#'
#' @param prefix An identifier prefix.
#' @param x A vector of identifier prefixes.
#' @param stopOnIllegalChars Whether to [base::stop()] or produce a [base::warning()]
#'        when encountering illegal characters (i.e. anything other than a letter or
#'        underscore).
#'
#' @return a character vector containing the identifier(s).
#' @examples generate_id('attitude');
#' @name generate_id
#' @rdname generate_id
#' @export
generate_id <- function(prefix = paste(sample(letters, 4), collapse=""),
                        stopOnIllegalChars = FALSE) {

  if (length(prefix) > 1) {
    warning("Use `generate_ids` to generate multiple ids at once; ",
            "calling it for you now and returning the result.");
    return(generate_ids(prefix,
                        stopOnIllegalChars=stopOnIllegalChars));
  }

  if ((grepl("[^a-zA-Z_]+",
             prefix))) {
    if (stopOnIllegalChars) {
      stop("The specified prefix contains illegal characters, and argument ",
           "`stopOnIllegalChars` is set to TRUE, so I'm stopping.");
    } else {
      warning("The specified prefix contains illegal characters, and argument ",
              "`stopOnIllegalChars` is set to FALSE, so I'm removing them.");
      prefix <-
        gsub("[^a-zA-Z_]+",
             "",
             prefix);
    }
  };

  #timeNrString <- gsub('\\.', '', format(Sys.time(), "%y%m%d%H%M%OS2"));
  timeNrString <- as.character(round(as.numeric(Sys.time()) * 100, 0));

  res <- numericToBase30(as.numeric(timeNrString));
  return(paste0(prefix, "_", res));
}
