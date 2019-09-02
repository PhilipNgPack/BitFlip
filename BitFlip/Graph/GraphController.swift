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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var barChartView: BarChartView!
//    var lineChart: LineChart?
    var barChart: BarChart?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawChart()
    }
    
    func drawChart() {
        barChart?.drawChart(barChartView)
    }
    @IBAction func rightButtonTapped(_ sender: Any) {
        barChart?.clear(barChartView)
    }
    
}
