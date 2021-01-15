# おんどとり
# データの結合のみ
# 2021/1/5
# Yuki Watanabe


# パッケージの読み込み

library(ggplot2)
library(dplyr)

# 事前データ

colname = c("date", "date2","Temperature", "nulldata")

# データ読み込み＆データ処理

data_paths = list.files(path = "data", full.names = T,
                        pattern = ".txt")

data_list = lapply(data_paths,
                   function(x)read.table(x,
                                         skip = 4, sep = ",",
                                         col.names = colname)) %>%
  bind_rows(.id = NULL) %>% 
  select(date, Temperature)

data_list$date = as.POSIXct(data_list$date,
                            format = "%Y-%m-%d %H:%M:%S",
                            tz = "JAPAN")
ggplot() +
  geom_point(data = data_list,
             aes(x = date,
                 y = Temperature))

write.csv(data_list, "302.csv",
          row.names = F)
