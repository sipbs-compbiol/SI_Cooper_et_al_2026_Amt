# load_dataframes.R
#
# Provides the load_dataframes() function that returns dataframes
# required for the analysis

load_dataframes <- function() {
  
  # Figure 4c
  dfm_4c <- readr::read_csv("assets/data/fig_4c.csv", col_names=TRUE, col_types="ffdd", na=c("", "NA", "n/a")) |>
    dplyr::mutate(LPR = stringr::str_c("LPR", LPR))  # add prefix to LPR factor
  colnames(dfm_4c) <- c("LPR", "label", "amplitude", "decayrate")
  dfm_4c$LPR <- factor(dfm_4c$LPR, levels=c("LPR5", "LPR10", "LPR50"))  # order LPR factor levels
  
  # Figure 5a
  dfm_5a <- readr::read_csv("assets/data/fig_5a.csv", col_names=TRUE, col_types="fffdd") |>
    dplyr::mutate(Ligand = stringr::str_replace(Ligand, "\\+", ""))  # tidy ligand name
  colnames(dfm_5a) <- c("ligand", "exptID", "columnID", "amplitude", "decayrate")
  dfm_5a$ligand <- factor(dfm_5a$ligand, levels=c("NH4", "MeA"))  # order ligand factor levels
  
  # Figure 6b
  dfm_6b <- readr::read_csv("assets/data/fig_6b.csv", col_names=TRUE, col_types="ffffdd")
  colnames(dfm_6b) <- c("group", "sheet", "exptID", "label", "amplitude", "decayrate")
  dfm_6b$group <- factor(dfm_6b$group, levels=c("pH7 (baseline)", "pH7 after pH5", "pH7 after pH6", "pH7 after pH8"))  # order group factor levels
  
  # Figure 6d
  dfm_6d <- readr::read_csv("assets/data/fig_6d.csv", col_names=TRUE, col_types="ffffdd", na=c("", "NA")) |>
    dplyr::mutate(pH = stringr::str_c("pH", pH))  # add prefix to pH factor
  colnames(dfm_6d) <- c("pH", "sheet", "exptID", "label", "amplitude", "decayrate")
  dfm_6d$pH <- factor(dfm_6d$pH, levels=c("pH5", "pH6", "pH7", "pH8"))  # order pH factor levels
  
  # Figure 6f
  dfm_6f <- readr::read_csv("assets/data/fig_6f.csv", col_names=TRUE, col_types="fffdd", na=c("", "NA", "--")) |>
    dplyr::mutate(Group = stringr::str_replace_all(Group, "\\+", "")) |> # tidy group name
    dplyr::filter(Group != "pH7.5 (no gradient)")  # Exclude pH 7.5 data with no gradient (not in manuscript)
  colnames(dfm_6f) <- c("group", "day", "label", "amplitude", "decayrate")
  dfm_6f$group <- factor(dfm_6f$group, levels=c("pH6.5 (no gradient)", "pH6.5>7.5 gradient  NH4", "pH6.5>7.5 gradient, no NH4"))  # order pH factor levels  
  
  return(list(dfm_4c = dfm_4c,
              dfm_5a = dfm_5a,
              dfm_6b = dfm_6b,
              dfm_6d = dfm_6d,
              dfm_6f = dfm_6f))  
}

