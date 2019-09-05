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
    
    // MARK: - State variables
    
    var currentGraph: toggleGraphs = toggleGraphs.flips
    
    // MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// hide nodata display
        lineChartView.noDataText = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDisplay()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        clearGraphs()
    }
    
    // MARK: - Functions
    
    /// selects the current graph to display
    func updateDisplay() {
        clearGraphs()
        switch currentGraph {
        case .flips:
            titleLabel.text = "Flips"
            barChart?.drawChart(barChartView)
            
        case .probs:
            titleLabel.text = "Probability"
            lineChart?.drawChart(lineChartView)
            
        case .money:
            titleLabel.text = "Money"
            print("implement money system later lol")
        }
    }
    
    /// clears the data from the graphs
    func clearGraphs() {
        barChart?.clear(barChartView)
        lineChart?.clear(lineChartView)
    }
    
    /// When the right button is tapped then go to the next graph
    @IBAction func rightButtonTapped(_ sender: Any) {
        // TODO: - handle switching between graphs
        currentGraph.next()
        updateDisplay()
    }
    
    /// When the left button is tapped then go to the previous graph
    @IBAction func leftButtonTapped(_ sender: Any) {
        currentGraph.prev()
        updateDisplay()
    }
}

// MARK: - Extension for enumeration logic

extension GraphController {
    enum toggleGraphs {
        case flips
        case probs
        case money
        mutating func next() {
            switch self {
            case .flips:
                self = .probs
            case .probs:
                self = .money
            case .money:
                self = .flips
            }
        }
        
        mutating func prev() {
            switch self {
            case .flips:
                self = .money
            case .probs:
                self = .flips
            case .money:
                self = .probs
            }
        }
    }
}
