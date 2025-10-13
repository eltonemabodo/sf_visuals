## Data Cleaning and Preparation


costs_data <- read_excel("data/costs.xlsx")

trend_data <- read_excel("data/trend_data.xlsx")


schools_data <- trend_data %>% 
  select(year, wfp_sch, thr, nhgsf) %>%
  pivot_longer(
    cols = -year,
    names_to = "type",
    values_to = "value"
  ) %>% 
  mutate(
    start_year = substr(year, 1, 4),
    year_date = ymd(paste0(start_year, "-10-01"))
  ) 



label_df <- schools_data %>% slice(seq(1, n(), by =10))

  
######################################################################################


## Students trend data

students_data <- trend_data %>% 
  select(year, sm_hgsf_students,sm_students, students_hgsf,  thr_students, sm_hgsf_students) %>%
  mutate(
    start_year = substr(year, 1, 4),
    year_date = ymd(paste0(start_year, "-10-01"))
  ) %>% 
  arrange(year_date)

label_students_df <- students_data %>% slice(seq(1, n(), by = 10))
