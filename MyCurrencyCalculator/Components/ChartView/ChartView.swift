//
//  ChartView.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import UIKit
import DGCharts

class ChartView: UIView {
    
    var entries = [ChartDataEntry]()
    public var graphData: ChartData = [] {
        didSet {
            lineChartView.data = graphData
        }
    }
    private lazy var graphBGView = UIView()
    let lineChartView: LineChartView = LineChartView.customizeLineChartView()
    
    lazy var xAxis = lineChartView.xAxis
    // Add a custom view with the current x and y values
    let xLabel = UILabel()
    let yLabel = UILabel()
    let chartBGView = UIView()
    lazy var indicatorCustomView: UIView = {
        let view = UIView()
        view.addSubview([chartBGView, xLabel, yLabel])
        chartBGView.fillSuperView()
        xLabel.anchor(
            top: view.topAnchor,
            right: view.rightAnchor,
            left: view.leftAnchor,
            paddingTop: 8,
            paddingRight: 18,
            height: 16
        )
        yLabel.anchor(
            top: xLabel.bottomAnchor,
            right: xLabel.rightAnchor, left: xLabel.leftAnchor,
            paddingTop: 2,
            height: 18
        )
        return view
    }()
    let verticalLine = UIView()
    let dot = UIView()
    let labelView: UIView = {
        let view = UIView()
        return view
    }()
    var viewModel: BaseViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(graphBGView)
        graphBGView.addSubview(lineChartView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineChartView.delegate = self
        layoutGraphViews()
        labelView.cornerRadius = 5
    }
    
    private func updateLineChartView() {
        lineChartView.data = createChart(data: viewModel?.lineData ?? [])
        lineChartView.xAxis.spaceMin = 0.2
        lineChartView.xAxis.spaceMax = 0.25
        lineChartView.drawBordersEnabled = false
        lineChartView.autoScaleMinMaxEnabled = false
        lineChartView.notifyDataSetChanged()
        lineChartView.backgroundColor = .green
    }
    
    private func layoutGraphViews() {
        layoutGraphView()
        layoutLineChartView()
    }
    
    private func layoutGraphView() {
        graphBGView.anchor(
            top: topAnchor,
            right: rightAnchor, left: leftAnchor,
            paddingTop: 25,
            paddingRight: -10, paddingLeft: -10,
            height: 200
        )
    }
    
    private func layoutLineChartView() {
        lineChartView.fillSuperView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

