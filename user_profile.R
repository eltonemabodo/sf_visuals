###############################################
# School Feeding Visuals – User Profile
# Script 01: Environment Setup & Global Options
###############################################

# Load required packages
required_packages <- c(
  "tidyverse",
  "readxl",
  "janitor",
  "lubridate",
  "here",
  "rmarkdown",
  "gt",
  "glue",
  "haven",
  "writexl",
  "scales",
  "labelled",
  "showtext",
  "sysfonts",
  "showtext",
  "webshot2",
  "ggtext"
)

# Install any missing packages
installed <- installed.packages()[, "Package"]
for (pkg in required_packages) {
  if (!(pkg %in% installed))
    install.packages(pkg)
}
# Load all
lapply(required_packages, library, character.only = TRUE)

# Set global options
options(scipen = 999)  # Avoid scientific notation
options(dplyr.summarise.inform = FALSE)  # Clean summarise output


# Set relative paths using `here`
data_dir      <- here::here("data")
code_dir       <- here::here("code")
figures_dir        <- here::here("figures")
report_dir         <- here::here("report")

# Add multiple font weights from Google Fonts
font_add_google("Open Sans", "opensans_regular", regular.wt = 400)   # Normal
font_add_google("Open Sans", "opensans_light", regular.wt = 300)     # Light
font_add_google("Open Sans", "opensans_semibold", regular.wt = 600)  # Semi-Bold
font_add_google("Open Sans", "opensans_bold", regular.wt = 700)      # Bold
font_add_google("Open Sans", "opensans_extrabold", regular.wt = 800) # Extra-Bold
showtext_opts(dpi = 300)
showtext_auto() # Automatically use showtext for text rendering

# Timestamp for logging
run_time <- Sys.time()
message("Environment setup complete: ", run_time)