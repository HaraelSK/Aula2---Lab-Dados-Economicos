# WDI = World development indicators

#install.packages("WDI")
#library(WDI)

# PIB preços correntes US$ -> GDP (current US$)(NY.GDP.MKTP.CD)
# Código: NY.GDP.MKTP.CD

options(scipen = 999) #Ajusta notação científica

varpib <- WDIsearch('gdp')
dadospib <- WDI(country = 'all', indicator = 'NY.GDP.MKTP.CD')
dadospib2023 <- WDI(country = 'all', indicator = 'NY.GDP.MKTP.CD', start = 2023, end = 2023)