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
    
    var coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func drawChart(_ barChartView: BarChartView) {
        let flips = coreDataManager.fetchAllFlips()
        let headsCount = flips!.filter({ $0.outcome == 0}).count
        let tailsCount = flips!.filter({ $0.outcome == 1}).count
        print(headsCount + tailsCount)
        
        let swag = BarChartDataEntry(x: 0.0, y: Double(headsCount))
        let swag2 = BarChartDataEntry(x: 1.0, y: Double(tailsCount))
        let values1 = [swag, swag2]
        
        let chartDataSet = BarChartDataSet(entries: values1, label: "flips")
        self.prettifyDataSet(chartDataSet)
        
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        self.prettifyData(chartData)
        
        barChartView.data = chartData
        self.prettyifyChart(barChartView)
        
    }
    
    func prettifyData(_ data: BarChartData) {
        data.setDrawValues(false)
        
    }
    
    func prettifyDataSet(_ chartDataSet: BarChartDataSet) {
        
    }
    
    func prettyifyChart(_ barChartView: BarChartView) {
        let labels = ["Heads ", "Tails"]
        barChartView.isUserInteractionEnabled = false
        barChartView.xAxis.labelCount = labels.count
        barChartView.xAxis.granularity = 1.0
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        barChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        barChartView.drawValueAboveBarEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.rightAxis.enabled = false
        
        barChartView.animate(xAxisDuration: 0.5, yAxisDuration: 1.0)
    }
    
}
