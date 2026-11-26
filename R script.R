library(tidyr)
china_export_long<-pivot_longer(
  data=china_export,
  cols=c(2:32),
  names_to = "year",
  values_to="export(1000 USD)"
)

View(china_export_long)

write.csv(china_export_long,"china_export_1",row.names=F)

china_import_long<-pivot_longer(
  data=china_import,
  cols=c(2:32),
  names_to = "year",
  values_to="import(1000 USD)"
)

View(china_import_long)

china_trade<-merge(china_export_long,china_import_long, by= c("Partner Name","year"))

View(china_trade)

write.csv(china_trade,"china_trade.csv",row.names=F)

china_indicator_1<-merge(china_trade,ISQ_AMS, by.x= c("Partner Name","year"), by.y=c("Host","Year"),all=T)
View(china_indicator_1)
write.csv(china_indicator_1,"china_indicator_1.csv",row.names = F)

china_education<-merge(inbound_chin_students,outbound_chin_students, by= c("receiving_country","year"),all=T)
write.csv(china_education,"china_education.csv",row.names = F)

china_education_1<-merge(china_education,confucius_institutes,by= c("receiving_country","year"),all=T)

china_education_1<-china_education_1[china_education_1$year!=0,]
write.csv(china_education_1,"china_education_1.csv",row.names = F)

View(china_education_1)
 
china_indicator_2<-merge(china_indicator_1,china_education_1,by.x= c("Partner Name","year"),by.y=c("receiving_country","year"),all=T)
write.csv(china_indicator_2,"china_indicator_2.csv",row.names = F)
china_indicator_3<-merge(china_indicator_2,china_AI_commitment,by.x= c("Partner Name","year"),by.y = c("Recipient","Commitment.Year"),all=T)
head(china_indicator_3)
write.csv(china_indicator_3,"china_indicator_3.csv",row.names = F)

chin_diplomacy<-pivot_wider(
  chin_diplomacy,
  names_from="diplomacy_type",
  values_from = "diplomacy_count"
)
View(china_indicator_3)
china_indicator_4<-merge(china_indicator_3,chin_diplomacy,by.x= c("Partner Name","year"),by.y=c("receiving_country","year"),all=T)
head(china_indicator_4)
write.csv(china_indicator_4,"china_indicator_4.csv",row.names = F)
china_indicator_5<-merge(china_indicator_4,CPdata092025_1,by.x=c("Partner Name","year"),by.y=c("country","year"),all=T)
head(china_indicator_5)
write.csv(china_indicator_5,"china_indicator_5.csv",row.names = F)
library(tidyr)
china_arms_transfer<-pivot_longer(
  data=china_arms_transfer,
  cols=c(2:36),
  names_to = "year",
  values_to = "arms_transfer"
)

china_indicator_5<-merge(china_indicator_5,china_arms_transfer,by.x=c("Partner Name","year"),by.y=c("Recipient","year"),all=T)
View(china_indicator_5)
View(china_arms_transfer)
write.csv(china_indicator_5,"china_indicator_5.csv",row.names = F)

View(china_AI_commitment)
View(china_indicator_5)
head(china_indicator_5)
china_indicator_with_regions<-merge(china_indicator_5,countries_with_regional_dummies,by=c("Partner.Name"),all=T)
head(china_indicator_with_regions)
write.csv(china_indicator_with_regions,"china_indicator_with_regions.csv",row.names = F)

un_vote_score<-completeVotes[,c("Countryname","year","vote")]
View(un_vote_score)
write.csv(un_vote_score,"un_vote_score.csv",row.names = F)
data.frame(un_vote_score)
un_vote_score_1<-aggregate(un_vote_score$vote~un_vote_score$Countryname+un_vote_score$year,FUN = sum)

china_indicator_regions_un<-merge(china_indicator_with_regions,un_vote_score_1,by.x=c("Partner.Name","year"),by.y=c("un_vote_score$Countryname","un_vote_score$year"),all=T)
head(china_indicator_regions_un)
write.csv(china_indicator_regions_un,"china_indicator_regions_un_2.csv",row.names=F)
getwd()

