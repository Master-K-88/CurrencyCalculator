//
//  ChartView + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import UIKit
import DGCharts

extension ChartView: ChartViewDelegate {
    
    func createChart(data: [Double]) -> LineChartData {
        entries = []
        for x in 0..<data.count {
            let value = data[x]
            let xValue: Double = Double(x)
            
            let entry = ChartDataEntry(x: xValue, y: value)
            entries.append(entry)
        }
        let dataSet = LineChartDataSet(
            entries: entries,
            label: viewModel?.selectedDays.stringValue ?? ""
        )
        dataSet.mode = .cubicBezier
        dataSet.colors =  [.blue]
        dataSet.drawCirclesEnabled = false
        dataSet.drawFilledEnabled = true
        dataSet.setDrawHighlightIndicators(false)
        dataSet.drawValuesEnabled = false
        // Create a gradient fill for the line chart dataset
        dataSet.drawFilledEnabled = true
        let dataEntry = LineChartData(dataSet: dataSet)
        return dataEntry
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let xValue = entry.x
        let yValue = entry.y
        
        // Remove any previously added views
        lineChartView.subviews.forEach { $0.removeFromSuperview() }
        lineChartView.highlightPerTapEnabled = false
        // Add a vertical line at the selected x value
        let xPos = lineChartView.getTransformer(forAxis: .left).pixelForValues(x: xValue, y: 0)
        let yPos = lineChartView.getTransformer(forAxis: .left).pixelForValues(x: 0, y: yValue)
        let height = lineChartView.frame.height - yPos.y - 10
        verticalLine.frame = CGRect(x: xPos.x, y: yPos.y, width: 1.5, height: height - 10)
        verticalLine.backgroundColor = .blue
        lineChartView.addSubview(verticalLine)

        // Add a dot at the selected x and y values
        dot.frame = CGRect(x: xPos.x - 5, y: yPos.y - 5, width: 10, height: 10)
        dot.backgroundColor = .blue
        dot.layer.cornerRadius = 5
        lineChartView.addSubview(dot)
        
        let label: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = .blue
            label.text = ""
            label.layer.cornerRadius = 5
            label.backgroundColor = .blue
            label.textAlignment = .center
            return label
        }()
        
        let swap = xPos.x > lineChartView.frame.width - 110
        
        indicatorCustomView.frame = CGRect(x: swap ? xPos.x - 10 : xPos.x + 10,
                                           y: yPos.y - 27.5,
                                           width: swap ? -90 : 90,
                                           height: 55)
        
        let labelSize = label.sizeThatFits(
            CGSize(
                width: CGFloat.greatestFiniteMagnitude,
                height: label.frame.size.height
            )
        )
        let width = labelSize.width + 10
        
        labelView.addSubview(label)
        labelView.cornerRadius = 10
        label.fillSuperView()
        labelView.backgroundColor = .blue
        
        labelView.frame = CGRect(
            x: xPos.x - (width * 0.5),
            y: lineChartView.frame.height - 15,
            width: width,
            height: 20
        )
        lineChartView.addSubview(labelView)
        
        xLabel.textAlignment = .right
        
        xLabel.text = ""
        yLabel.text = "\(yValue)"
        lineChartView.addSubview(indicatorCustomView)
    }
    
    func chartViewDidEndPanning(_ chartView: ChartViewBase) {
        let indicators = [
            self.indicatorCustomView,
            self.verticalLine,
            self.dot,
            self.labelView
        ]
        UIView.animate(
            withDuration: 1.0,
            delay: 0.2,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0
        ) { [weak self] in
            self?.hideIndicatorViews(hide: true, views: indicators)
        } completion: { completed in
            if completed {
                self.clearAllIndicator(indicators: indicators)
                self.hideIndicatorViews(hide: false, views: indicators)
            }
        }
    }
    
    func clearAllIndicator(indicators: [UIView]) {
        indicators.forEach { newView in
            newView.removeFromSuperview()
        }
    }
    
    func hideIndicatorViews(hide: Bool, views: [UIView]) {
        views.forEach { newView in
            newView.isHidden = hide
        }
    }
}

extension LineChartView {
    class func customizeLineChartView() -> LineChartView {
        let lineChartView = LineChartView()
         // Customize the chart view
         lineChartView.backgroundColor = .white
         lineChartView.data?.setDrawValues(false)
         lineChartView.xAxis.labelPosition = .bottom
         lineChartView.xAxis.drawGridLinesEnabled = false
         lineChartView.leftAxis.drawGridLinesEnabled = false
         lineChartView.rightAxis.drawGridLinesEnabled = false
         lineChartView.leftAxis.drawLabelsEnabled = false
         lineChartView.rightAxis.drawLabelsEnabled = false
         lineChartView.highlightPerTapEnabled = false
         lineChartView.borderLineWidth = 0
         lineChartView.legend.enabled = false
         lineChartView.leftAxis.gridColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
         lineChartView.leftAxis.granularity = 1
         lineChartView.dragYEnabled = false
         lineChartView.dragEnabled = true
         lineChartView.xAxis.axisLineWidth = 0
        return lineChartView
    }
}
