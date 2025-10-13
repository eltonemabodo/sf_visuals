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
  width = 10, height = 7, dpi = 300
)


############################################################################################

students_data %>% 
  pivot_longer(
    cols = -year,
    names_to = "type",
    values_to = "students"
  ) %>% 
  filter(type != "sm_students") %>%
  ggplot(aes(x = year, y = students, colour = type, fill = type, group = type)) +
  geom_line(size = 1.2) +
  #geom_point(size = 3) +
  geom_area(
    position = "identity",
    alpha = 0.3,
    show.legend = TRUE
  )















