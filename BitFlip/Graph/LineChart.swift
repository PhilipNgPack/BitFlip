//
//  LineChart.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 9/2/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation
import Charts

class LineChart {
    
    // MARK: - Dependency injection variable
    
    var coreDataManager: CoreDataManager
    
    // MARK: - Initialization
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Functions
    
    
    // MARK: - Draw the line chart
    
    /// Create the probability chart plotting heads vs tails probabilities
    func drawChart(_ lineChartView: LineChartView)  {
        let flips = coreDataManager.fetchProbs(range: 1000)
        var headsProbs: [Double] = []
        var tailsProbs: [Double] = []
        let count = flips.count
        
        for dict in flips {
            headsProbs.append(dict["headsProb"] as! Double)
            tailsProbs.append(dict["tailsProb"] as! Double)
        }

        // first set is the heads probability
        let values1 = (0..<count).map { (i) -> ChartDataEntry in
            let yVal1 = headsProbs[i]
            let yVal = Double(yVal1)
            return ChartDataEntry(x: Double(i), y: yVal)
        }

        // second set is the tails probability
        let values2 = (0..<count).map { (i) -> ChartDataEntry in
            let yVal3 = tailsProbs[i]
            let yVal2 = Double(yVal3)
            return ChartDataEntry(x: Double(i), y: yVal2)
        }

        // create the dataset with the values from the notification
        let set1 = LineChartDataSet(entries: values1, label: "head:tails %")
        
        // create the dataset with the values from the notification
        let set2 = LineChartDataSet(entries: values2, label: "tails:heads %")

        // create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)

        // pass in the dataset into the Data
        let data = LineChartData(dataSets: dataSets)

        // finally set our data
        lineChartView.data = data
    }

    /// Clear the chart
    func clear(_ lineChartView: LineChartView) {
        lineChartView.clear()
    }



    
}
