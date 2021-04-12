//
//  Forecast.swift
//  LinearRegression
//
//  Created by Михаил Фокин on 09.04.2021.
//

import Foundation

struct Exception: Error {
    var massage: String
}

class Forecast {
    var k = Double(0)
    var b = Double(0)
    var miliage = Double(0)
    
    func run() {
        let arguments = CommandLine.arguments
        let errorMassage = "Pass the miliage as a parameter.\n./forecast miliage"
        if arguments.count != 2 {
            systemError(massage: errorMassage)
        }
        guard let miliage = arguments.last else {
            systemError(massage: "Error file name.")
            return
        }
        if miliage.isEmpty {
            systemError(massage: errorMassage)
        }
        guard let temp = Double(miliage) else {
            systemError(massage: errorMassage)
            return
        }
        self.miliage = temp
        let nameFile = "rezult.csv"
        do {
            let text = try readFile(fileName: nameFile)
            try workingText(text: text)
        } catch {
            fputs("Error open file \(nameFile).\n", stderr)
        }
        forecast()
    }
    
    private func forecast() {
        print("k = \(self.k)\nb = \(self.b)")
        let result = self.k * self.miliage + self.b
        print(result)
    }
    
    // MARK: Вывод сообщения об ошибке в поток ошибок
    private func systemError(massage: String) {
        fputs(massage + "\n", stderr)
        exit(-1)
    }
    
    // MARK: Считывание коэффициентов k и b
    private func workingText(text: String) throws {
        let lines = text.split() { $0 == "\n" }.map{ String($0) }
        let errorDataFile = "Invalid data file."
        if lines.count != 2 {
            throw Exception(massage: errorDataFile)
        }
        let errorString = "Invalid information at the beginning of the file."
        guard let designation = lines.first else {
            throw Exception(massage: errorString)
        }
        let abscissaOrdinate = designation.split(){ $0 == "," }.map{ String($0) }
        if abscissaOrdinate.count != 2 {
            throw Exception(massage: errorString)
        }
        if abscissaOrdinate[0] != "k" && abscissaOrdinate[1] != "b" {
            throw Exception(massage: errorString)
        }
        let line = lines.last!
        let coefficients = line.split() { $0 == "," }.map{ String($0) }
        if coefficients.count != 2 {
            throw Exception(massage: "Error data file: {\(line)}")
        }
        guard let k = Double(coefficients[0]) else {
            throw Exception(massage: "Error data file: {\(line)}")
        }
        guard let b = Double(coefficients[1]) else {
            throw Exception(massage: "Error data file: {\(line)}")
        }
        self.k = k
        self.b = b
    }
    
    // MARK: Чтение данных из файла.
    private func readFile(fileName: String) throws -> String {
        let manager = FileManager.default
        let currentDirURL = URL(fileURLWithPath: manager.currentDirectoryPath)
        let fileURL = currentDirURL.appendingPathComponent(fileName)
        return try String(contentsOf: fileURL)
    }
}
