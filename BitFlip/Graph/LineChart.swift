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
    
    /// Plot heads vs tails probs
    ///
    /// - Parameters
    ///     - lineChartView: the LineChartView passed from the graph controller
    func drawChart(_ lineChartView: LineChartView)  {
        
        // xAxis
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = true

        // leftAxis
        let leftAxis = lineChartView.leftAxis
        leftAxis.drawGridLinesEnabled = false
        
        // rightAxis
        let rightAxis = lineChartView.rightAxis
        rightAxis.enabled = false
        
        // lineChart settings
        lineChartView.leftAxis.spaceBottom = 0.0
        lineChartView.legend.enabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.isUserInteractionEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.drawMarkers = false
        lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0)
        
        let flips = coreDataManager.fetchProbs(range: 1000)
        var headsProbs: [Double] = []
        var tailsProbs: [Double] = []
        let count = flips.count
        
        for dict in flips {
            headsProbs.append(dict["headsProb"] as! Double * 100)
            tailsProbs.append(dict["tailsProb"] as! Double * 100)
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
        self.prettifyDataSet(set1, UIColor.green)
        
        // create the dataset with the values from the notification
        let set2 = LineChartDataSet(entries: values2, label: "tails:heads %")
        self.prettifyDataSet(set2, UIColor.red)
        
        // create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)

        // pass in the dataset into the Data
        let data = LineChartData(dataSets: dataSets)
        prettifyData(data)
        
        // finally set our data
        lineChartView.data = data
    }
    
    /// Make the dataset look nicer
    func prettifyData(_ data: LineChartData) {
        data.setDrawValues(false)
    }

    /// Clear data from the chart
    func clear(_ lineChartView: LineChartView) {
        lineChartView.clear()
    }
    
    /// Make the dataset look prettier
    func prettifyDataSet(_ dataSet: LineChartDataSet, _ color: UIColor) {
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2.0
        dataSet.setColor(color)
        dataSet.fillAlpha = 65 / 255.0
    }
}
