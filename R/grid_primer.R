#MY INTRO INTO GRIDS- NORMFLUODBF HAS CARRIED ME INTO UNKNOWN TERRITORIES
#AS ALWAYS LOOK FOR A DELIVERY SYSTEM (ALWAYS A PROJECT)

library(grid)
library(dplyr)

metadata <-
  expand.grid(LETTERS[1:8], 1:12, stringsAsFactors = FALSE) %>%
  magrittr::set_colnames(c("row", "col")) %>%
  dplyr::mutate(
    well = sprintf("%s%02d", row, col),
    sample = NA, 
    target_ch1 = NA,
    target_ch2 = NA,
    used = FALSE
  ) %>%
  dplyr::select(c("well", "sample", "row", "col", "used"))

#Needed for grid
x = unique(metadata$row)
y = unique(metadata$col)

#Grid Primer (Some funky stuff)
gdat <- data.frame(x = rep(seq(0, 0.8, 1/5), 5),
                  y = rep(seq(0, 0.8, 1/5), each = 5),
                  val = sample(1:25, 25) )

grid.newpage()
vp1 <- viewport(x = 0.1, y = 0.1, w = 0.8, h = 0.8, 
                just = c("left", "bottom"), name = "vp1")
grid.rect(x=x,y=y ,height=1/5,width=1/5,hjust=0,vjust=0,vp=vp1)

#Some more funk
grid.newpage()
x <- unit(1:36/36, "npc")
y <- unit(1:48/48, "npc")
grid.grill(h=y, v=x, gp=gpar(col="red"))
draw.text(c("bottom"), 1, 1)
draw.text(c("left", "bottom"), 2, 1)
draw.text(c("right", "bottom"), 3, 1)

grid.newpage()
grid.grill(h = unit(seq(0.25, 0.75, 0.25), "npc"),
           v = unit(seq(0.25, 0.75, 0.25), "npc"),
           default.units = "npc", gp=gpar(col = "blue"), vp = NULL)

#Some attempt at applying it to normfluodbf
create_blank_plate <- function(well_row = LETTERS[1:8], well_col = 1:12) {
  library(tibble)
  tidyr::crossing(well_row = as.factor(well_row),
                  well_col = as.factor(well_col)) %>%
    as_tibble() %>%
    tidyr::unite("well", well_row, well_col, 
                 sep = "", remove = FALSE)
}

bp = create_blank_plate()

grid.newpage()
xout = grid.layout(nrow = 8, ncol = 12)
grid.show.layout(xout, )
#it is almost certain grid.locator will be needed for normfluodbf but I think
#my helper pkg has that covered.


#I have found a way to draw the plate grids with ggplot and I am learning that but not very 
#possible with grid so far, more to learn here.
#I was able to plot something.

