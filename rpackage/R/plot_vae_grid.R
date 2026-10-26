#' Decode and plot a grid from a two-dimensional VAE latent space
#'
#' @param generator A trained keras3 decoder model, or a function taking a
#'   numeric matrix with two columns of latent coordinates. It must return
#'   grayscale images with pixel values in `[0, 1]`: a matrix with one flattened
#'   image per row, or an array with dimensions (images, rows, columns),
#'   optionally followed by a singleton channel dimension.
#' @param grid_x,grid_y Finite numeric vectors of latent coordinates. Values
#'   in grid_x run from left to right; values in grid_y run from bottom to top.
#' @param image_dim The image dimensions, as c(rows, columns).
#' @param batch_size Optional prediction batch size for a keras3 decoder.
#' @param plot Whether to display the assembled image grid.
#' @param ... Additional graphical arguments passed to [graphics::plot()].
#' @return Invisibly, a numeric matrix containing the assembled grayscale
#'   image grid. Use `plot = FALSE` to obtain it without displaying a plot.
#' @details This function only predicts from the supplied decoder; it never
#'   trains or changes the model. keras3 is needed only when generator is a
#'   model rather than an R function. Flattened images are reshaped in R's
#'   column-major order, matching the course feed-forward VAE example.
#' @examples
#' # A small decoder function; no Keras installation is needed for this example.
#' decoder <- function(z) {
#'   matrix(rep(plogis(z[, 1] + z[, 2]), 4), ncol = 4)
#' }
#' canvas <- plot_vae_grid(decoder, grid_x = c(-1, 1),
#'                         grid_y = c(-1, 1), image_dim = c(2, 2),
#'                         plot = FALSE)
#' dim(canvas)
#' \dontrun{
#' # After training either of the course MNIST VAE examples:
#' plot_vae_grid(generator)
#' }
#' @export
plot_vae_grid <- function(generator,
                          grid_x = seq(-4, 4, length.out = 15),
                          grid_y = grid_x, image_dim = c(28L, 28L),
                          batch_size = NULL, plot = TRUE, ...) {
  checkmate::assert_numeric(grid_x, finite = TRUE, any.missing = FALSE,
                            min.len = 1L)
  checkmate::assert_numeric(grid_y, finite = TRUE, any.missing = FALSE,
                            min.len = 1L)
  checkmate::assert_integerish(image_dim, lower = 1, len = 2L,
                               any.missing = FALSE)
  checkmate::assert_flag(plot)
  if (!is.null(batch_size)) checkmate::assert_int(batch_size, lower = 1)

  latent_grid <- as.matrix(expand.grid(z1 = grid_x, z2 = grid_y))
  # Keras models can also be callable R closures via reticulate.
  if (is.function(generator) && !inherits(generator, "python.builtin.object")) {
    images <- generator(latent_grid)
  } else {
    if (!requireNamespace("keras3", quietly = TRUE)) {
      stop("Install keras3 to predict from a decoder model.")
    }
    images <- stats::predict(generator, latent_grid,
                             batch_size = batch_size, verbose = 0L)
  }
  if (!is.numeric(images) || is.null(dim(images)) ||
      any(!is.finite(images)) || any(images < 0 | images > 1)) {
    stop("The decoder must return numeric images with finite pixels in [0, 1].")
  }
  image_dim <- as.integer(image_dim)
  dims <- dim(images)
  n <- nrow(latent_grid)
  flat <- identical(dims, c(n, as.integer(prod(image_dim))))
  shaped <- identical(dims, c(n, image_dim)) ||
    identical(dims, c(n, image_dim, 1L))
  if (!flat && !shaped) {
    stop("Decoder output dimensions do not match the grid and image_dim.")
  }
  if (shaped) images <- array(images, dim = c(n, image_dim))

  nx <- length(grid_x)
  ny <- length(grid_y)
  canvas <- matrix(0, ny * image_dim[1], nx * image_dim[2])
  for (iy in seq_len(ny)) {
    for (ix in seq_len(nx)) {
      index <- (iy - 1L) * nx + ix
      tile <- if (flat) matrix(images[index, ], nrow = image_dim[1]) else
        matrix(images[index, , ], nrow = image_dim[1])
      rows <- seq.int((ny - iy) * image_dim[1] + 1L,
                       (ny - iy + 1L) * image_dim[1])
      cols <- seq.int((ix - 1L) * image_dim[2] + 1L, ix * image_dim[2])
      canvas[rows, cols] <- tile
    }
  }
  if (plot) graphics::plot(grDevices::as.raster(canvas), ...)
  invisible(canvas)
}
