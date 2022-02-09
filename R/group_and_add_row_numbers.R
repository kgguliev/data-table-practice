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

data[, row_n := .I, by = .(qrt, month)]
