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
    @IBOutlet weak var text: NSScrollView!
    @IBOutlet weak var forecastData: NSTextField!
    @IBOutlet weak var selectData: NSSegmentedControl!
    
    private var dict: [Double: Double]?
    private var forecast: Double?
    private var k: Double?
    private var b: Double?
    
    // MARK: Открытие файла по имени и отображение его в ScrollView
    @IBAction func selectionData(_ sender: NSSegmentedCell) {
        guard let textView : NSTextView = text?.documentView as? NSTextView else { return }
        self.forecastData.stringValue = ""
        var fileName = String()
        switch sender.selectedSegment {
        case 0:
            fileName = "data"
        case 2:
            fileName = "the_cost_of_bread"
        default:
            textView.string = ""
            return
        }
        guard let text = try? readFile(fileName: fileName) else { return }
        textView.string = text
    }
    
    // MARK: Считывание строки из ScrollVeiw и вычисление k и b
    @IBAction func readButton(_ sender: NSButton) {
        let textView : NSTextView? = text?.documentView as? NSTextView
        guard let text = textView?.string else { return }
        if text.isEmpty { return }
        let lr = LinearRegression(text: text)
        self.dict = lr.dict
        self.k = lr.k
        self.b = lr.b
        self.forecast = nil
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        displayChart()
    }
    
    // MARK: Взятие значения для прогноза и отображения на экране.
    @IBAction func forecastButton(_ sender: NSButton) {
        self.forecast = Double(forecastData.stringValue)
        displayChart()
    }
    
    
    // MARK: Чтение данных из файла, находящихся в проекте и имеющие расширение .csv
    private func readFile(fileName: String) throws -> String {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "csv")  else { return "" }
        return try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    }
    
    // MARK: Отображение графика на экране.
    private func displayChart() {
        guard let dict = self.dict else { return }
        if dict.isEmpty { return }
        guard let k = self.k, let b = self.b else { return }
        var yse1 = [ChartDataEntry]()
        var yse2 = [ChartDataEntry]()
        
        let keys = dict.map{ $0.key }.sorted(by: { $0 < $1 })
        let values = keys.map{ dict[$0] ?? 0 }
        
        guard let max = keys.max() else { return }
        guard let min = keys.min() else { return }
        
        var modelData = [Double]()
        if let forecast = self.forecast {
            modelData.append(forecast)
        }
        modelData.append(max)
        modelData.append(min)
        
        for elem in modelData.sorted(by: { $0 < $1 }) {
            yse2.append(ChartDataEntry(x: elem, y: k * elem + b))
        }
        for (key, value) in zip(keys, values) {
            yse1.append(ChartDataEntry(x: key, y: value))
        }
        let data = LineChartData()
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
