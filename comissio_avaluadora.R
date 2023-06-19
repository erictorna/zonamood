library(tidyverse)
library(dplyr)
library(data.table)
load('~/idiap/projects/zonamood/esferes.RData')
esferes = esferes %>% mutate(esfera_alterada = ifelse(resultat_tot!='sense risc' | resultat_benestar!='sense risc' | resultat_emocional!='sense risc' |
                                                        resultat_familiar!='sense risc' | resultat_escolar!='sense risc' | resultat_social!='sense risc',
                                                      1, 0)) %>% 
  mutate(centinella = ifelse(sol>=1 | social>=1 | no_grup_amics>=1 | casa_bien>=1 | actuar_davant_abus>=1, 1, 0))

esferes = esferes %>% mutate(avaluar = ifelse(esfera_alterada==1 & centinella==1, 1, 0))

alumnes_avaluar = esferes %>% select(CODI, avaluar, resultat_tot, resultat_benestar, resultat_emocional, resultat_familiar, resultat_escolar, resultat_escolar, resultat_social,
                                     sol, social, no_grup_amics, casa_bien, actuar_davant_abus)

save(alumnes_avaluar, file='~/idiap/projects/zonamood/alumnes_avaluar.RData')
