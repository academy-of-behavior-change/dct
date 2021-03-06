#' Apply multiple DiagrammeR global graph attributes
#'
#' @param dctGraph The [DiagrammeR::DiagrammeR] graph to apply the attributes to.
#' @param ... One or more character vectors of length three, where the first element is
#' the attribute, the second the value, and the third, the attribute type (`graph`,
#' `node`, or `edge`).
#'
#' @return The [DiagrammeR::DiagrammeR] graph.
#' @examples
#' parsedSpecs <- load_dct_specs(text=dct::example_dct_spec);
#' dctGraph <- parsedSpecs$output$basic_graph;
#' dctGraph <- apply_graph_theme(dctGraph,
#'                               c("color", "#0000AA", "node"),
#'                               c("fillcolor", "#00FFFF", "node"));
#' @export
apply_graph_theme <- function(dctGraph,
                              ...) {
  for (currentSetting in list(...)) {
    if ((length(currentSetting) != 3) && is.character(currentSetting)) {
      stop("Only provide character vectors of length 3 in the dots (...) argument!");
    } else {
      dctGraph <-
        DiagrammeR::add_global_graph_attrs(dctGraph,
                                           currentSetting[1],
                                           currentSetting[2],
                                           currentSetting[3]);
    }
  }
  return(dctGraph);
}
