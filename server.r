library(shiny)
library(caret)
library(rattle)
library(rpart)
library(e1071)
library(rpart.plot)

carTable = read.table("car.data", sep=",")
carDS = as.data.frame(carTable)

colnames(carDS) = c("car_acceptability", "price", "doors", "persons", "lug_boot", "safety", "comfort")

shinyServer(
  function(input, output) {
    output$rpartPlot = renderPlot({
      cvCtrl <- trainControl(method = "cv", number=5, allowParallel = TRUE)
      gmbGrid = expand.grid(maxdepth=c(2:input$maxdepth))
      carDSselected = carDS[, colnames(carDS) %in% input$vars]
      need(ncol(carDSselected) == 0, "Please select at least one variable")
      if (length(input$vars) == 1){
        carDSselected = carDS[, input$vars]
        carDSselected = as.data.frame(carDSselected)
        colnames(carDSselected) = input$vars
      }
      else{
        carDSselected = carDS[, input$vars]
      }
        
              
      carDSselected$car_acceptability = carDS$car_acceptability
      carDSselected$comfort = carDS$comfort
      trainObjRPART = train(car_acceptability~., data=carDSselected, method="rpart2", trControl = cvCtrl, tuneGrid = gmbGrid)
      fancyRpartPlot(trainObjRPART$finalModel, main="Car acceptability", sub="")
    })
  }
)