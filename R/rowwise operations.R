library(data.table)
library(tidyverse)

# SO user's example ----


tarjae <- function(x) {
  x %>% 
    pivot_longer(-1) %>% 
    group_by(group = rep(row_number(), each=ncol(test[,-1]), length.out=n())) %>% 
    add_count(value) %>% 
    filter(ncol(test[,-1]) == n) %>%
    pivot_wider(names_from = name, values_from = value) %>%
    ungroup() %>% 
    select(-c(group, n))
}

# data.table

set.seed(2022)
test <- data.frame(id = floor(runif(10, min = 0, max = 111)),
               var1 = ceiling(runif(10, min = 5, max = 10)),
               var2 = c(6, 5, 4, 8, 12, 1223, 14, 1, 90, 1),
               var3 = c(6, 3, 4, 8, 11, 45, 56, 78, 0, 9))

setDT(test)

test[, sd_var := matrixStats::rowSds(as.matrix(.SD)),
     .SDcols = c("var1", "var2", "var3"), by = 1:nrow(test)] %>% 
  .[sd_var == 0, , ]
