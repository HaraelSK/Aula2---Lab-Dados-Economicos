# WORLD DEVELOPMENT INDICATORS (WDI)
# INDICADORES DE DESENVOLVIMENTO MUNDIAL

# PIB (PRODUTO INTERNO BRUTO)

#install.packages('WDI')
library(WDI)

options(scipen = 999)

# DADOS EM PAINEL
dadospib <- WDI(country = 'all',
                indicator = 'NY.GDP.MKTP.CD')

paises <- c('BR', 'JB')

dadospibbrjp <- WDI(country = paises,
                    indicator = 'NY.GDP.MKTP.CD')

# CORTE TRANSVERSAL
dadospib2023 <- WDI(country = 'all',
                    indicator = 'NY.GDP.MKTP.CD',
                    start = 2023, end = 2023)

# SÉRIE TEMPORAL
dadospibbr <- WDI(country = 'BR',
                  indicator = 'NY.GDP.MKTP.CD')

# GRÁFICOS

# BIBLIOTECA ggplot2 (tidyverse)
#install.packages("tidyverse")
library(tidyverse)

## DADOS EM PAINEL

grafpainel <- ggplot(dadospib,
                     mapping = aes(y = NY.GDP.MKTP.CD,
                                   x = year)) +
  geom_point()

#print(grafpainel)

# CORTE TRANSVERSAL

grafcorte <- ggplot(dadospib2023,
                    mapping = aes(y = NY.GDP.MKTP.CD,
                                  x = year)) +
  geom_point()

#print(grafcorte)

# SÉRIE TEMPORAL

grafserie <- ggplot(dadospibbr,
                    mapping = aes(y = NY.GDP.MKTP.CD,
                                  x = year)) +
  geom_line()

#print(grafserie)