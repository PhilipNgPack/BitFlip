//
//  GraphController.swift
//  BitFlip
//
//  Created by Sean Ng Pack on 8/24/19.
//  Copyright © 2019 Lengjai. All rights reserved.
//

import UIKit
import Charts

class GraphController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    // MARK: - Depedency injection variables
    
    var lineChart: LineChart?
    var barChart: BarChart?
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawChart()
        lineChartView.noDataText = ""
    }
    
    // MARK: - Functions
    
    /// Draw the barchart
    func drawChart() {
        barChart?.drawChart(barChartView)
    }
    
    /// When the right button is tapped then switch graphs
    @IBAction func rightButtonTapped(_ sender: Any) {
        // TODO: - handle switching between graphs
        barChart?.clear(barChartView)        
        lineChart?.drawChart(lineChartView)
    }
    
}
