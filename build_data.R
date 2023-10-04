library(tidyverse)
library(dplyr)
library(ggplot2)
library(readxl)
library(data.table)
data = read_excel('~/idiap/data/zonamood/results-survey26.04.2023_DEFINITIU.xlsx', sheet = 15, col_names = TRUE)
# Canviem els valors de 'valorat' ja que hi ha un error en en l'excel i estan les dades al revés
data = data %>% mutate(valorat=ifelse(valorat==2, 0, 2))
setDT(data)
benestar_emocional = data %>% select(1:12)
emocional = data %>% select(1,2,13:21)
social = data %>% select(1,2,22:27)
familiar = data %>% select(1,2,28:30)
relacional_escolar = data %>% select(1,2,31:48)


data <- data[, suma := rowSums(.SD[, 3:48, with = FALSE])]
data = data %>% mutate(resultat = ifelse(suma<=45, 'sense risc',
                                         ifelse(suma>45 & suma<=70, 'lleu',
                                                ifelse(suma>70 & suma<= 95, 'moderat', 'greu'))))

benestar_emocional <- benestar_emocional[, suma := rowSums(.SD[, 3:10, with = FALSE])]
benestar_emocional = benestar_emocional %>% mutate(resultat = ifelse(suma<=12, 'sense risc',
                                                                     ifelse(suma>12 & suma<=18, 'lleu',
                                                                            ifelse(suma>18 & suma<= 25, 'moderat', 'greu'))))
emocional <- emocional[, suma := rowSums(.SD[, 3:11, with = FALSE])]
emocional = emocional %>% mutate(resultat = ifelse(suma<=10, 'sense risc',
                                                   ifelse(suma>10 & suma<=15, 'lleu',
                                                          ifelse(suma>15 & suma<= 21, 'moderat', 'greu'))))

social <- social[, suma := rowSums(.SD[, 3:8, with = FALSE])]
social = social %>% mutate(resultat = ifelse(suma<=6, 'sense risc',
                                             ifelse(suma>6 & suma<=9, 'lleu',
                                                    ifelse(suma>9 & suma<= 12, 'moderat', 'greu'))))

familiar <- familiar[, suma := rowSums(.SD[, 3:5, with = FALSE])]
familiar = familiar %>% mutate(resultat = ifelse(suma<=3, 'sense risc',
                                                 ifelse(suma>3 & suma<=5, 'lleu',
                                                        ifelse(suma>5 & suma<= 7, 'moderat', 'greu'))))

relacional_escolar <- relacional_escolar[, suma := rowSums(.SD[, 3:20, with = FALSE])]
relacional_escolar = relacional_escolar %>% mutate(resultat = ifelse(suma<=14, 'sense risc',
                                                                     ifelse(suma>14 & suma<=23, 'lleu',
                                                                            ifelse(suma>23 & suma<= 30, 'moderat', 'greu'))))




save.image('~/idiap/projects/zonamood/build_data.RData')
