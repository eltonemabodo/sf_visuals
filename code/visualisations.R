### Visualisations
#1. The history of school feeding in Cambodia

sf_trend_graph <- ggplot(schools_data, aes(x = year_date, 
                                   y = value, fill = type
                                   )) +
  geom_bar(stat = "identity", linewidth = 0.9, colour = "white", position = "stack") + 
  guides(fill = guide_legend(override.aes = list(shape = 21))) + 
  scale_x_date(
    expand = c(0, 0),  # Add some space on the right
    breaks = label_df$year_date,  # only every 3rd date
    labels = label_df$year        # show "1999-00", "2002-03", etc.
  ) + 
  scale_y_continuous(
    labels = scales::comma,  # Format y-axis with commas
    expand = c(0, 0),  # Remove extra space on the y-axis
    breaks = c(1000, 2000, 3000, 4000)
  ) +
  scale_fill_manual(
    values = c(
      "wfp_sch" = "#3C467B",
      "thr"         = "#954C2E",
      "nhgsf"       = "#FCC61D"
    ),
    labels = c("NHGSF", "THR", "WFP Schools")
  ) + 
  labs(
    title = "The History of School Feeding in Cambodia",
    subtitle = "School Feeding Program started with only 64 schools in the 1999/00 school calendar year. Take-home rations\nwere implemented from the 2009/10 to 2017/18 school calendar years. Government handover began in the\n2020/21 school year.",
    x = "School Calendar Year",
    y = "Number of Schools",
    fill = "Program Type",
    caption = "**Source:** WFP Cambodia School Feeding Data (1999-2025)<br><br>**Visualisation:** RAM Unit"
  ) +
  theme_minimal() + 
  theme(
    plot.title = element_text(size = 18,
                              family = "opensans_extrabold",
                              margin = margin(b = 10),
                              colour = "#3C467B"),
    plot.title.position = "plot",
    plot.subtitle = element_text(size = 15,
                                 family = "opensans_light",
                                 face = "italic",
                                 margin = margin(b = 20),
                                 colour = "#3C467B"),
    plot.caption = element_markdown(size = 12,
                                    family = "opensans_light",
                                    margin = margin(t = 20),
                                    hjust = 0,
                                    colour = "#3C467B"),
    plot.caption.position = "plot",
    axis.title.x = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(t = 15),
                                colour = "#3C467B"),
    axis.title.y = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(r = 10),
                                colour = "#3C467B"),
    axis.text = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B"),
    axis.ticks.x = element_line(colour = "#3C467B"),
    axis.ticks.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "#C5C7BC", linetype = 3),
    legend.text = element_text(size = 12, family = "opensans_light", colour = "#3C467B"),
    legend.key.size = unit(0.4, "cm"),
    legend.position = "bottom",
    legend.title = element_blank()
  )


# Save the trend graph

ggsave(
  filename = here::here("figures", "school_feeding_trend.png"),
  plot = sf_trend_graph,
  bg = "white",
  width = 10, height = 7, dpi = 300
)


############################################################################################

students_graph <- students_data %>% 
  filter(type != "total_students") %>%  # Exclude total_students for clarity
  #filter(type != "sm_students") %>%
  ggplot(aes(x = year_date, y = students, colour = type, fill = type, group = type)) +
  geom_line(size = 1, linetype = 3, show.legend = FALSE) +
  #geom_point(size = 2, shape = 21, color = "white", stroke = 1) +
  geom_area(
    position = "identity",
    alpha = 0.8,
    show.legend = TRUE
  ) + 
  scale_x_date(
    expand = c(0, 0.5),  # Add some space on the right
    breaks = label_students_df$year_date,  # only every 3rd date
    labels = label_students_df$year        # show "1999-00", "2002-03", etc.
  ) +
  scale_y_continuous(
    labels = scales::comma,  # Format y-axis with commas
    expand = c(0, 0),  # Remove extra space on the y-axis
    limits = c(0, 800000),  # Set y-axis limits
    breaks = c(200000, 400000, 600000, 800000)) +
  scale_color_manual(
    values = c(
      "wfp_students" =  "#3C467B",
      "nhgsf_students" = "#FCC61D",
      "total_students" = "#954C2E"
    ),
    labels = c("WFP Students", "NHGSF Students", "Total Students")
  ) +
  scale_fill_manual(
    values = c(
      "wfp_students" = "#3C467B",
      "nhgsf_students" = "#FCC61D",
      "total_students" = "#954C2E"
    ),
    labels = c("WFP Students", "NHGSF Students", "Total Students")
  ) +
  annotate(
    "curve",
    x = as.Date("2006-10-01"), y = 700000,
    xend = as.Date("2005-10-01"), yend = 600000,
    curvature = 0.2,
    arrow = arrow(length = unit(0.2, "cm"), type = "closed"),
    colour = "#3C467B",
    size = 0.3,
    alpha = 0.8
  ) + 
  annotate(
    "text",
    x = as.Date("2006-11-20"), y = 700000,
    label = "Students Benefiting\npeaked at ~590,000\nin 2006/5 school year",
    lineheight = 0.9,
    colour = "#3C467B",
    family = "opensans_extrabold",
    size = 4,
    hjust = 0
  ) +
  annotate(
    "curve",
    xend = as.Date("2017-06-01"), y = 10000,
    x = as.Date("2019-08-01"), yend = 150000,
    curvature = 0.2,
    arrow = arrow(length = unit(0.2, "cm"), type = "closed", ends = "first"),
    colour = "#FCC61D",
    size = 0.3
  ) +
  annotate(
    "text",
    x = as.Date("2017-03-01"), y = 150000,
    label = "Handover started in 2019/20,\nwith ~52,000 students\nenrolled in the NHGSF",
    lineheight = 0.9,
    colour = "#FCC61D",
    family = "opensans_extrabold",
    size = 4,
    hjust = 1
  ) +
  labs(
    title = "Students Benefiting from School Feeding in Cambodia",
    subtitle = "The number of students benefiting from school feeding programs has increased significantly since 1999,\naveraging ~330,000 beneficiaries per year.",
    x = "School Calendar Year",
    y = "Number of Students",
    fill = "Program Type",
    colour = "Program Type",
    caption = "**Source:** WFP Cambodia School Feeding Data (1999-2025)<br><br>**Visualisation:** RAM Unit"
  ) +
  theme_minimal() + 
  theme(
    plot.title = element_text(size = 18,
                              family = "opensans_extrabold",
                              margin = margin(b = 10),
                              colour = "#3C467B"),
    plot.title.position = "plot",
    plot.subtitle = element_text(size = 15,
                                 family = "opensans_light",
                                 face = "italic",
                                 margin = margin(b = 20),
                                 colour = "#3C467B"),
    plot.caption = element_markdown(size = 12,
                                    family = "opensans_light",
                                    margin = margin(t = 20),
                                    hjust = 0,
                                    colour = "#3C467B"),
    plot.caption.position = "plot",
    axis.title.x = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(t = 15),
                                colour = "#3C467B"),
    axis.title.y = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(r = 10),
                                colour = "#3C467B"),
    axis.text.y = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B"),
    axis.text.x = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B", hjust = 0.95),
    axis.ticks.x = element_line(colour = "#3C467B"),
    axis.ticks.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "#C5C7BC", linetype = 3),
    legend.text = element_text(size = 12, family = "opensans_light", colour = "#3C467B"),
    legend.key.size = unit(0.4, "cm"),
    legend.position = "bottom",
    legend.title = element_blank()
  )
# Save the students graph
ggsave(
  filename = here::here("figures", "students_benefiting_school_feeding.png"),
  plot = students_graph,
  bg = "white",
  width = 10, height = 7, dpi = 300
)

########################################################################################################

# Cumulative Students Graph

ben_perc_graph <- beneficiaries_perc_data %>% 
  ggplot(aes(x = year_date, y = percentage, group = type, color = type)) +
  geom_line(size = 1.1,  aes(colour = type), show.legend = FALSE) +
  geom_point(size = 2.5, shape = 21, 
             aes(fill = type), color = "white", stroke = 1.3,
             show.legend = FALSE) +
  scale_x_date(
    limits = c(
      min(label_beneficiaries_perc_df$year_date),
      max(label_beneficiaries_perc_df$year_date) + lubridate::years(7)  # extend by 2 years (adjust as needed)
    ),
    expand = c(0, 0),
    breaks = label_beneficiaries_perc_df$year_date,  # only every 3rd date
    labels = label_beneficiaries_perc_df$year        # show "1999-00", "2002-03", etc.
  ) +
  scale_y_continuous(
    labels = scales::percent_format(scale = 1),  # Format y-axis as percentage
    expand = c(0, 0),  # Remove extra space on the y-axis
    limits = c(0, 25), 
    breaks = seq(5, 25, by = 5)
  ) +
  scale_color_manual(
    values = c(
      "perc_tot" = "#3C467B",
      "perc_wfp" = "#FCC61D",
      "perc_nhgsf" = "#954C2E"
    ),
    labels = c("Total Students", "WFP Students", "NHGSF Students")
  ) +
  scale_fill_manual(
    values = c(
      "perc_tot" = "#3C467B",
      "perc_wfp" = "#FCC61D",
      "perc_nhgsf" = "#954C2E"
    ),
    labels = c("Total Students", "WFP Students", "NHGSF Students")
  ) +
  annotate(
    "rect",
    xmin = as.Date("2019-10-01"), xmax = max(label_beneficiaries_perc_df$year_date) + lubridate::years(7),
    ymin = 0, ymax = 25,
    alpha = 0.13,
    fill = "#3C467B"
  ) + 
  annotate(
    "text",
    x = as.Date("2022-10-01"), y = 23,
    label = "Handover Phase",
    lineheight = 0.9,
    colour = "#3C467B",
    family = "opensans_extrabold",
    size = 4.5,
    hjust = 0
  )+
  annotate(
    "text",
    x = as.Date("2025-02-01"), y = 14.8,
    label = "Total Relative\nBeneficiaries (14.8%)",
    lineheight = 0.9,
    colour = "#3C467B",
    family = "opensans_extrabold",
    size = 4,
    hjust = 0
  ) +
  annotate(
    "text",
    x = as.Date("2025-02-01"), y = 5,
    label = "WFP's Relative\nContribution (5.67%)",
    lineheight = 0.9,
    colour = "#FCC61D",
    family = "opensans_extrabold",
    size = 4,
    hjust = 0
  ) +
  annotate(
    "text",
    x = as.Date("2025-02-01"), y = 9.5,
    label = "NHGSF's Relative\nContribution (9.13%)",
    lineheight = 0.9,
    colour = "#954C2E",
    family = "opensans_extrabold",
    size = 4,
    hjust = 0
  ) +
  labs(
    title = "Percentage of Students Benefiting from School Feeding in Cambodia",
    subtitle = "The percentage of students benefiting from school feeding program relative to the total number of primary\nschool students in Cambodia. Since its inception in 1999, the program has benefited an average of 15.2% of\nstudents annually",
    x = "School Calendar Year",
    y = "Percentage of Students",
    caption = "**Source:** WFP Cambodia School Feeding Data (1999-2025)<br><br>**Visualisation:** RAM Unit"
  ) +
  theme_minimal() + 
  theme(
    plot.title = element_text(size = 18,
                              family = "opensans_extrabold",
                              margin = margin(b = 10),
                              colour = "#3C467B"),
    plot.title.position = "plot",
    plot.subtitle = element_text(size = 15,
                                 family = "opensans_light",
                                 face = "italic",
                                 margin = margin(b = 20),
                                 colour = "#3C467B"),
    plot.caption = element_markdown(size = 12,
                                    family = "opensans_light",
                                    margin = margin(t = 20),
                                    hjust = 0,
                                    colour = "#3C467B"),
    plot.caption.position = "plot",
    axis.title.x = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(t = 15),
                                colour = "#3C467B"),
    axis.title.y = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(r = 10),
                                colour = "#3C467B"),
    axis.text.y = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B"),
    axis.text.x = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B", hjust = 0.5),
    axis.ticks = element_line(colour = "#3C467B"),
    axis.line = element_line(colour = "#3C467B"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "#C5C7BC", linetype = 3),
    legend.text = element_text(size = 12, family = "opensans_light", colour = "#3C467B"),
    legend.key.size = unit(0.4, "cm"),
    legend.position = "bottom",
    legend.title = element_blank()
  )



# Save the beneficiaries percentage graph
ggsave(
  filename = here::here("figures", "beneficiaries_percentage_school_feeding.png"),
  plot = ben_perc_graph,
  bg = "white",
  width = 10, height = 7, dpi = 300
)
########################################################################################################

# Schools vs SFP Schools Graph

schools_graph <- schools_perc_data %>% 
  ggplot(aes(x = year_date, y = number, group = type, fill = type)) +
  geom_bar(
    stat = "identity", 
    linewidth = 0.9, 
    colour = "white", 
    position = "stack"
  ) +
  scale_x_date(
    expand = c(0, 0),  # Add some space on the right
    breaks = label_cumulative_students_df$year_date,  # only every 3rd date
    labels = label_cumulative_students_df$year        # show "1999-00", "2002-03", etc.
  ) +
  scale_y_continuous(
    labels = scales::comma,  # Format y-axis with commas
    expand = c(0, 0),  # Remove extra space on the y-axis
    limits = c(0, 15000),  # Set y-axis limits
    breaks = c(1000, 5000, 10000, 15000)
  ) +
  scale_fill_manual(
    values = c(
      "sfp_sch" = "#FCC61D",
      "nat_schools" = "#3C467B"
    ),
    labels = c("Total Schools", "SFP Schools")
  )+
  annotate(
    "rect",
    xmin = as.Date("2011-04-01"), xmax = as.Date("2014-04-01"),
    ymin = 0, ymax = 15000,
    alpha = 0.2,
    fill = "#3C467B"
  ) + 
  labs(
    title = "Schools Benefiting from School Feeding in Cambodia",
    subtitle = "The number of schools benefiting from school feeding programs has increased significantly since 1999,\naveraging ~3,000 beneficiaries per year.",
    x = "School Calendar Year",
    y = "Number of Schools",
    fill = "Program Type",
    caption = "**Source:** WFP Cambodia School Feeding Data (1999-2025)<br><br>**Visualisation:** RAM Unit"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 18,
                              family = "opensans_extrabold",
                              margin = margin(b = 10),
                              colour = "#3C467B"),
    plot.title.position = "plot",
    plot.subtitle = element_text(size = 15,
                                 family = "opensans_light",
                                 face = "italic",
                                 margin = margin(b = 20),
                                 colour = "#3C467B"),
    plot.caption = element_markdown(size = 12,
                                    family = "opensans_light",
                                    margin = margin(t = 20),
                                    hjust = 0,
                                    colour = "#3C467B"),
    plot.caption.position = "plot",
    axis.title.x = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(t = 15),
                                colour = "#3C467B"),
    axis.title.y = element_text(size = 14, family = "opensans_extrabold",
                                margin = margin(r = 10),
                                colour = "#3C467B"),
    axis.text.y = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B"),
    axis.text.x = element_text(size = 12, family = "opensans_extrabold", colour = "#3C467B", hjust = 0.5),
    axis.ticks.x = element_line(colour = "#3C467B"),
    axis.ticks.y = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(colour = "#C5C7BC", linetype = 3),
    legend.text = element_text(size = 12, family = "opensans_light", colour = "#3C467B"),
    legend.key.size = unit(0.4, "cm"),
    legend.position = "bottom",
    legend.title = element_blank()
  )


# Save the schools graph
ggsave(
  filename = here::here("figures", "schools_benefiting_school_feeding.png"),
  plot = schools_graph,
  bg = "white",
  width = 10, height = 7, dpi = 300
)
########################################################################################################