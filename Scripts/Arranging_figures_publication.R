######################### arranging the figures for publication ################
######figure 1 #############
#done with Flowchartdesigner 3

############# figure 2##########
#ocurrence of auxotrophies together, abundance of amino acid auxotrophies in the gut, number of auxotrophies
#run these scripts
#number of auxotrophies
#Load models (completeness >= 85% and contamination <=2)

source("Scripts/init_models_filtered.R")

#Predict auxotrophies

source("Scripts/predict_auxos.R")

#Add information about the genomes

source("Scripts/auxotable_not_melted.R")

#Analyze and visualize the distribution of the number of auxotrophies in every phylum

source("Scripts/number_auxo_per_phylum.R")
#ocurrence of auxotrophies

source("Scripts/Occurence_Auxos_together.R")

# abundancies in HRGM
#Add information about the genomes

source("Scripts/auxotable_melted_merged.R")

#Analyze amino acid auxotrophies

source("Scripts/Abundancies.R")

#### create figure ####
library(gridExtra)
library(cowplot)
fi <- grid.arrange(arrangeGrob(pt,o, ncol=2),
             nrow=2,
             abun)
fi2 <- as_ggplot(fi) +
  draw_plot_label(label= c("A", "B","C"), size =12,
                  x = c(0,0.5,0), y = c(1, 1, 0.5))
fi2

ggsave("output/plots/figure2.pdf", plot = fi2,
       width = 10, height = 8)

#################figure 3#################
#Load models (completeness >= 85% and contamination <=2)

source("Scripts/init_models_filtered.R")

#Predict auxotrophies

source("Scripts/predict_auxos.R")

#Add information about the genomes

source("Scripts/auxotable_not_melted.R")

#Analyze and visualize the distribution of the number of auxotrophies in every phylum

source("Scripts/number_auxo_per_phylum.R")

#create figure
fi3 <- ggarrange(fi_or, ba_or, ac_or, pr_or, ba_fam,
                 labels = c("A","","","", "B"),
                 ncol=1, nrow= 5, common.legend = FALSE,
                 heights = c(1,1,1,1), widths= c(1,1,1,1))
fi3

ggsave("output/plots/figure3_26.03.22.pdf", plot = fi3,
       width = 10, height = 14)

################  figure 4 ####################################
#completeness of the pathways
#Load models (Completeness >=85%, Contamination <=2)

source("Scripts/init_models_filtered.R")

#Predict auxotrophies

source("Scripts/predict_auxos.R")

#Add information about the genomes

source("Scripts/auxotable_not_melted.R")

#Analyze and then visualize the completeness of the amino acid biosynthesis pathways

source("Scripts/Completeness_pathways.R")

#### create figure ###
fi4 <- ggarrange(tr,hi,ch,se,le,il1,il2,il3,va,il4,il5,
                 labels = c("A","B","C", "D","E"),
                 hjust = c(-0.1,0.5,0.5,0.5,-0.1),
                 ncol=4, nrow= 3, common.legend = TRUE, legend = "bottom",
                 heights = c(1,1,1,1), widths= c(1,1,1,1))
fi4

ggsave("output/plots/figure4_26.03.22_new.pdf", plot = fi4,
       width = 9, height = 9)


#################figure 4 #################
#### fermentation products
#Analyze the production of by products with statistical analysis

source("Scripts/byproduct_production.R")

#### create figure #####
fi5.1 <- ggplot(stat_BP_x_auxo[auxo.compound != "Gly"], aes(auxo.compound, by.product,
                                                        fill = -log2(fisher.or))) +
  geom_tile() +
  geom_point(aes(shape = sign.label1), size = 1) +
  scale_fill_gradient2(high = "#ca0020", mid = "white", low = "#0571b0") +
  scale_shape_manual(values = 8, na.translate = FALSE) +
  scale_x_discrete(expand = c(0,0)) + scale_y_discrete(expand = c(0,0)) +
  labs(x = "Auxotrophy", y = "Fermentation\nproduct", shape = "",
       fill = expression(log[2]~'(odds ratio)')) +
  theme_bw() +
  theme(legend.position = "bottom",
        legend.justification = 	1,
        axis.text.x = element_text(color = "black", angle = 45, hjust = 1, size = 9),
        axis.text.y = element_text(color = "black", size = 9)) +
  theme(axis.title.y = element_text(margin = margin(t = 0, r = 10, b= 0, l = 0), face = "bold")) +
  theme(axis.title.x = element_text(face = "bold", margin = margin(t = 10, r = 0, b= 0, l = 0))) +
  theme(panel.background = element_blank())

fi5.1 +theme(plot.margin = unit(c(1,0.5,2,0.5), "cm")) +
  theme(legend.text = element_text(size=10),
        legend.title = element_text(size=8))

fi5 <- ggarrange(length_count,fi4.1,
                 labels = c("A","B"),
                 ncol=2, nrow= 1, common.legend = FALSE,
                 heights = c(1,2), widths= c(1.5,2))
fi5
ggsave("output/plots/figure5_26.03.22.pdf", plot = fi5,
       width = 8, height = 3)


################# figure 6 ###########
#Load models (completeness >=85% and a contamination <=2)

source("Scripts/init_models_filtered.R")

#Predict auxotrophies

source("Scripts/predict_auxos.R")

#Add information about the genomes

source("Scripts/auxotable_melted_merged.R")

#Analyze associations with diseases or health factors(BMI, weight, age)

source("Scripts/Diseases_health_factors.R")

#multivariate regression analysis and abundance of amino acid auxotrophies in the gut 
fi6 <- ggarrange(b, linear_health_BMI_age1,all2, ncol=3,
                   nrow=1, heights = c(1,1,1), widths= c(3,1,1.4),
                 labels = "AUTO", hjust = c(-0.5,1,-3))
fi6
ggsave("output/plots/figure6.pdf", plot = fi6,
       width = 9, height = 5)
