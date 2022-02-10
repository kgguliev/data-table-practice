# Проставить номер строки по группировке

library(data.table)

data <- data.frame(
  
  year = rep(2001, 24),
  qrt = rep(paste0("q", 1:4), each = 6),
  month = sample(c("jan", "jan", "feb", "march",
                   "apr", "june", "june", "july", 
                   "aug", "sept", "oct", "jan",
                   "jan", "feb", "march",
                   "apr", "june", "june", "july", 
                   "aug", "sept", "oct", "july", "aug"))
  
)

setDT(data)

setorder(data, qrt, month)
data[, row_n := .I, by = .(qrt, month)]


# Сравнение с dplyr и base R

mbm <- microbenchmark::microbenchmark(
  
  base_R = {
    
    data$rank <- ave(seq_len(nrow(data)), data[, c("year","qrt")], FUN = seq_along)
    
  },
  
  r2evans = {
    
    library(dplyr)
    data %>%
      group_by(year, qrt) %>%
      mutate(rank = row_number()) %>%
      ungroup()
  
},

  rg4s = {
    
    library(data.table)
    setDT(data)
    data[, row_n := .I, by = .(qrt, month)]
},

times = 100)

ggplot2::autoplot(mbm)
