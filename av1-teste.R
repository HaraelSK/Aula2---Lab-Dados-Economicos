# WORLD DEVELOPMENT INDICATORS (WDI)

#install.packages("WDI")
#install.packages('tidyverse')
#library(tidyverse)
#library(WDI) # CARREGAR BIBLIOTECA/PACOTE

options(scipen = 999) # REMOVER A NOT. CIENT.
# DADOS EM PAINEL

americasul <- c('AR', 'BO', 'BR', 'CL', 'CO', 'EC', 'GY', 'PY', 'PE', 'SR', 'UY', 'VE')

dadosgini <- WDI(country = americasul,
                indicator = 'SI.POV.GINI',
                start = 2000, end = 2022)

# CORTE TRANSVERSAL
dadosgini2022 <- WDI(country = americasul,
                    indicator = 'SI.POV.GINI',
                    start = 2022, end = 2022)

# SÉRIE TEMPORAL
dadosginibr <- WDI(country = 'BR',
                  indicator = 'SI.POV.GINI',
                  start = 1981, end = 2022)

## DADOS EM PAINEL

grafpainel <- ggplot(dadosgini,
                     mapping = aes(y = SI.POV.GINI,
                                   x = year)) +
  geom_point()

#print(grafpainel)

# CORTE TRANSVERSAL

grafcorte <- ggplot(dadosgini2023,
                    mapping = aes(y = SI.POV.GINI,
                                  x = year)) +
  geom_point()

#print(grafcorte)

# SÉRIE TEMPORAL

grafserie <- ggplot(dadosginibr,
                    mapping = aes(y = SI.POV.GINI,
                                  x = year)) +
  geom_line()

#print(grafserie)
