library(data.table)

# Filtering ----

data(mtcars)

setDT(mtcars, keep.rownames = TRUE)

mtcars[rn == "Hornet Sportabout", , ]

mtcars[disp > mean(disp), ,]

# Choose columns ----

mtcars[, list(rn, mpg, carb), ]

# Group by and summarise ----

mtcars[, sum(disp), by = cyl]

mtcars[, .N, ] # number of obs

# Subset of Data

mtcars[, print(.SD), by = cyl]
