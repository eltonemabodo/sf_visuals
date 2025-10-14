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
  select(year, wfp_students, nhgsf_students, total_students) %>%
  pivot_longer(
    cols = -year,
    names_to = "type",
    values_to = "students"
  ) %>% 
  mutate(
    start_year = substr(year, 1, 4),
    year_date = ymd(paste0(start_year, "-10-01")), 
    students = if_else(students == 0, NA_real_, students)
  ) %>% 
  mutate(type = factor(
    type,
    levels = c("wfp_students", "nhgsf_students", "total_students")
  ))

label_students_df <- students_data %>% slice(seq(1, n(), by = 15))

#############################################################################################

## Cummulative Students Data

cumulative_students_data <- trend_data %>%
  select(year, cumulative_students) %>%
  mutate(
    start_year = substr(year, 1, 4),
    year_date = ymd(paste0(start_year, "-10-01"))
  )

label_cumulative_students_df <- cumulative_students_data %>%
  slice(seq(1, n(), by = 10))
#############################################################################################


beneficiaries_perc_data <- trend_data %>% 
  select(year,nat_students, total_students) %>% 
  mutate(
    perc =  total_students/nat_students  * 100,
    start_year = substr(year, 1, 4),
    year_date = ymd(paste0(start_year, "-10-01"))
  ) 

label_beneficiaries_perc_df <- beneficiaries_perc_data %>%
  slice(seq(1, n(), by = 10))
#############################################################################################
