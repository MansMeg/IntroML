# Run the R cells from the Colab notebook in a fresh R session.
install.packages("jsonlite", repos = "https://cloud.r-project.org")
notebook <- jsonlite::read_json("additional_material/colab_nb/setup_r_colab.ipynb")
stopifnot(notebook$metadata$kernelspec$name == "ir",
          notebook$metadata$language_info$name == "R")
for (cell in notebook$cells) {
  if (cell$cell_type == "code")
    eval(parse(text = paste0(unlist(cell$source), collapse = "")))
}
