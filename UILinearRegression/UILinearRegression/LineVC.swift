//
//  LineVC.swift
//  UILinearRegression
//
//  Created by Михаил Фокин on 09.04.2021.
//

import Cocoa
import Charts

class LineVC: NSViewController {

    @IBOutlet weak var lineChartView: LineChartView!
   // @IBOutlet weak var lineChartView: ScatterChartView!
    
    var dict: [Double: Double]?
    var k: Double?
    var b: Double?
    
   // @IBOutlet weak var filePath: NSTextField!
    @IBOutlet weak var text: NSScrollView!
    
    @IBAction func readButton(_ sender: NSButton) {
        let textView : NSTextView? = text?.documentView as? NSTextView
        guard let text = textView?.string else { return }
        let lr = LinearRegression(text: text)
        self.dict = lr.dict
        self.k = lr.k
        self.b = lr.b
        //self.dict = lr.dictNormalize
        displayChart()
        //self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayChart()
    }
    
    
    private func displayChart() {
        guard let dict = self.dict else { return }
        if dict.isEmpty { return }
        guard let k = self.k, let b = self.b else { return }
        //print(dict)
        //let ys1 = Array(1..<100).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        //let ys2 = Array(1..<100).map { x in return cos(Double(x) / 2.0 / 3.141) }
        var yse1 = [ChartDataEntry]()
        var yse2 = [ChartDataEntry]()
        let keys = dict.map{ $0.key }.sorted(by: { $0 < $1 })
        let values = keys.map{ dict[$0] ?? 0 }
        guard let max = keys.max() else { return }
        guard let min = keys.min() else { return }
//        for (i, elem) in values.enumerated() {
//            yse1.append(ChartDataEntry(x:  Double(i), y: elem))
//        }
//        for (key, value) in dict {
//            yse2.append(ChartDataEntry(x: value, y: key))
//        }
        yse2.append(ChartDataEntry(x: min, y: k * min + b))
        yse2.append(ChartDataEntry(x: max, y: k * max + b))
        for (key, value) in zip(keys, values) {
            //yse2.append(ChartDataEntry(x: key, y: value))
            yse1.append(ChartDataEntry(x: key, y: value))
        }
        
        //let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        //let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()
        //let data = ScatterChartData()
        let ds1 = LineChartDataSet(entries: yse1, label: "Data")
        ds1.colors = [NSUIColor.red]
        data.append(ds1)
        
        let ds2 = LineChartDataSet(entries: yse2, label: "Model")
        ds2.colors = [NSUIColor.blue]
        data.append(ds2)
        self.lineChartView.data = data
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white

        self.lineChartView.chartDescription.text = "Linear Regression"
    }
}
