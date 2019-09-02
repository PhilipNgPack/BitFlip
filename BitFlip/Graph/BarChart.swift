//
//  BarChart.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/26/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import Foundation
import Charts

class BarChart {
    
    //MARK: - Dependency injection variable
    var coreDataManager: CoreDataManager
    
    //MARK: - Initialization
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func drawChart(_ barChartView: BarChartView) {
        
        // MARK: xAxis
        let xAxis = barChartView.xAxis
        xAxis.labelPosition = XAxis.LabelPosition.bottom
        xAxis.granularity = 1.0
        xAxis.drawGridLinesEnabled = false
        let labels = ["Heads ", "Tails"]
        xAxis.labelCount = labels.count
        xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        
        
        // MARK: leftAxis
        let leftAxis = barChartView.leftAxis
        leftAxis.drawGridLinesEnabled = false
        leftAxis.axisMinimum = 0.0
        
        
        // MARK: rightAxis
        let rightAxis = barChartView.rightAxis
        rightAxis.enabled = false
        rightAxis.axisMinimum = 0.0
        
        
        // MARK: legend
        let legend = barChartView.legend
        legend.wordWrapEnabled = true
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        
        
        // MARK: description
        barChartView.noDataText = ""
        barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0)
        barChartView.isUserInteractionEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.chartDescription?.enabled = false
        
        let flips = coreDataManager.fetchOutcomes(range: 1000)
        let headsCount = flips["heads"]!
        let tailsCount = flips["tails"]!
        print(headsCount + tailsCount)
        
        let swag = BarChartDataEntry(x: 0.0, y: Double(headsCount))
        let swag2 = BarChartDataEntry(x: 1.0, y: Double(tailsCount))
        let values1 = [swag, swag2]
        
        let chartDataSet = BarChartDataSet(entries: values1, label: "flips")
        
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        
        barChartView.data = chartData
        
        self.prettifyData(chartData)
    }
    
    func prettifyData(_ data: BarChartData) {
        data.setDrawValues(false)
    }
    
    func clear(_ barChartView: BarChartView) {
        barChartView.clear()
    }
    
}
