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
    
   // @IBOutlet weak var filePath: NSTextField!
    @IBOutlet weak var text: NSScrollView!
    
    @IBAction func readButton(_ sender: NSButton) {
        let textView : NSTextView? = text?.documentView as? NSTextView
        print(textView?.string)
        textView?.string = "text"
//        guard let filePath = text.do else {
//            return
//        }
//        if filePath.isEmpty {
//            return
//        }
//        let lr = LinearRegression(filePath: filePath)
//        self.dict = lr.dict
//        //print(filePath)
//        self.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let dict = self.dict else { return }
        print(dict)
        let ys1 = Array(1..<100).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        let ys2 = Array(1..<100).map { x in return cos(Double(x) / 2.0 / 3.141) }
        
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()
        //let data = ScatterChartData()
        let ds1 = LineChartDataSet(entries: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.append(ds1)
        
        let ds2 = LineChartDataSet(entries: yse2, label: "World")
        ds2.colors = [NSUIColor.blue]
        data.append(ds2)
        self.lineChartView.data = data
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white

        self.lineChartView.chartDescription.text = "Linechart Demo"
    }
    
}
