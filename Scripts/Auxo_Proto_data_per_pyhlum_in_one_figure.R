############# proportion of auxotrophic/prototrophic MAGs per phylum ###########

Auxotrophy_12 <- Auxotrophy_12[complete.cases(Auxotrophy_12), ]

relphylum <- unique(Auxotrophy_12$phylum)
prop_all <- list()
k <- 1
for (pi in relphylum) {
  Auxo_all <- nrow(Auxotrophy_12[Auxotrophy_12$phylum == pi & Auxotrophy_12$Status == 0])
  Proto_all <- nrow(Auxotrophy_12[Auxotrophy_12$phylum == pi & Auxotrophy_12$Status == 1])
  p <- rbind(Auxo_all,Proto_all)
  p1 <- data.frame(p)
  p1$Status <- c("Auxotrophy", "Prototrophy")
  p1$nrow <- nrow(Auxotrophy_12[Auxotrophy_12$phylum == pi])
  p1$phylum <- pi
  prop_all[[k]] <- p1
  k <- k+1
}

prop_all_phyla <- rbindlist(prop_all)
prop_all_phyla$perc <- prop_all_phyla$p/prop_all_phyla$nrow

####################         visualization         #############################

p <- ggplot(prop_all_phyla, aes(phylum, perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "right") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 12, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 12, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 14, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 12, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 12, colour = "black")) 
p

ggsave("/Users/Svenja/Desktop/Auxos_Proto_prop.pdf", plot = p,
       width = 7, height = 5)
  

####################  proportions for every AA Auxotrophy    ##################
relAA <- unique(colnames(Auxotrophy_12[,c(2:22)]))
relphylum <- unique(Auxotrophy_12$phylum)
new <- list()
k <- 1

for (i in relAA) {
  print(i)
  for (p in relphylum) {
    Auxo <- nrow(Auxotrophy_12[Auxotrophy_12[[i]]== 0 & Auxotrophy_12$phylum == p])
    Proto <- nrow(Auxotrophy_12[Auxotrophy_12[[i]]== 1 & Auxotrophy_12$phylum == p])
    xz <- rbind(Auxo,Proto)
    xy <- data.frame(xz)
    xy$AA <- i
    xy$phylum <- p
    xy$Prototrophy <- c(0,1)
    xy$nrow <- nrow(Auxotrophy_12[Auxotrophy_12$phylum == p])
    new[[k]] <- xy
    k <- k+1
  }
}

prop <- rbindlist(new)
prop$perc <- (prop$xz/prop$nrow)
prop$Status <- ifelse(prop$Prototrophy == 0, "Auxotrophy", "Prototrophy")



##################               visualization              ####################

Ala <- ggplot(prop[AA == "Ala"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Alanine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Ala
Val <- ggplot(prop[AA == "Val"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Valine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Val

Met <- ggplot(prop[AA == "Met"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Methionine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Met
Leu <- ggplot(prop[AA == "Leu"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Leucine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Leu
Ile <- ggplot(prop[AA == "Ile"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Isoleucine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Ile

Pro <- ggplot(prop[AA == "Pro"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Proline") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

Trp <- ggplot(prop[AA == "Trp"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Tryptophan") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Trp


Phe <- ggplot(prop[AA == "Phe"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Phenylalanine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))



Lys <- ggplot(prop[AA == "Lys"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Lysin") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Lys
Arg <- ggplot(prop[AA == "Arg"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Arginine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

His <- ggplot(prop[AA == "His"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Histidine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

Tyr <- ggplot(prop[AA == "Tyr"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Tyrosine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

Thr <- ggplot(prop[AA == "Thr"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Threonine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Thr
Glu <- ggplot(prop[AA == "Glu"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Glutamate") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Glu
Gln <- ggplot(prop[AA == "Gln"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Glutamine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Gln
Gly <- ggplot(prop[AA == "Gly"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Glycine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

Ser <- ggplot(prop[AA == "Ser"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Serine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Ser

Cys <- ggplot(prop[AA == "Cys"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Cysteine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

Asp <- ggplot(prop[AA == "Asp"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Aspartate") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Asp
Asn <- ggplot(prop[AA == "Asn"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Asparagine") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))

Chor <- ggplot(prop[AA == "Chor"], aes(phylum,perc)) +
  geom_bar(stat = "identity", aes(fill = Status)) +
  ylab("Proportion of MAGs") +
  scale_fill_manual(values = c('#fdd0a2','#fdae6b')) +
  theme(legend.position = "none") +
  theme(panel.background = element_rect(fill="white", colour= "white")) +
  theme(axis.text.x = element_text(size = 8, angle = 50, colour = "black", hjust = 1, margin = margin(0,0,0,0))) +
  theme(axis.text.y = element_text(size = 8, colour = "black")) +
  theme(axis.title.x = element_blank()) +
  theme(axis.ticks = element_blank())+
  theme(axis.title.y = element_text(colour = "Black", face = "bold", size = 8, margin = margin(0,10,0,0))) +
  theme(legend.title = element_text(colour = "black", size = 8, face = "bold",  vjust = 1, margin = margin(10,5,5,0))) +
  theme(legend.text = element_text(size = 8, colour = "black")) +
  ggtitle("Chorismate") +
  theme(title = element_text(size=8, colour = "black", face ="bold"))
Chor



plot1 <- ggarrange(Asp, Asn, Glu, Gln,
                   ncol=2, nrow= 2)
plot1
ggsave("output/plots/plot1_proportions.pdf", plot = plot1,
       width = 6, height = 6)

plot2 <- ggarrange(Leu, Val,
                   ncol=2, nrow= 2)
plot2
ggsave("output/plots/plot2_proportions.pdf", plot = plot2,
       width = 6, height = 6)

plot3 <- ggarrange(Chor, Trp, Tyr, Phe,
                   ncol=2, nrow= 2)
plot3
ggsave("output/plots/plot3_proportions.pdf", plot = plot3,
       width = 6, height = 6)

plot4 <- ggarrange(Ser,Met,
                   ncol=2, nrow= 2)
plot4
ggsave("output/plots/plot4_proportions.pdf", plot = plot4,
       width = 6, height = 6)

plot5 <- ggarrange(Lys, Arg, Pro, His,
                   ncol=2, nrow= 2, common.legend = TRUE, legend = "none")
plot5
ggsave("output/plots/plot5_proportions.pdf", plot = plot5,
       width = 6, height = 6)

plot6 <- ggarrange(Ala,Ile,
                   ncol=2, nrow= 2, common.legend = TRUE, legend = "bottom")

plot6

plot7 <- ggarrange(Thr, Cys,
                   ncol=2, nrow= 2, common.legend = TRUE, legend = "bottom")
plot7
ggsave("output/plots/ala_proportions.pdf", plot = Ala,
       width = 4, height = 4)
