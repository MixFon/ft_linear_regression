//
//  LinearRegression.swift
//  LinearRegression
//
//  Created by Михаил Фокин on 07.04.2021.
//

import Foundation


struct Exception: Error {
    var massage: String
}

class LinearRegression {
    
    func run() {
        let arguments = CommandLine.arguments
        let errorMassage = "Pass the name of the training file as a parameter.\n./ft_linear_regression file_name"
        if arguments.count != 2 {
            systemError(massage: errorMassage)
        }
        guard let fileName = arguments.last else {
            systemError(massage: "Error file name.")
            return
        }
        if fileName.isEmpty {
            systemError(massage: errorMassage)
        }
        do {
            let text = try readFile(fileName: fileName)
            try workingText(text: text)
        } catch let exception as Exception {
            systemError(massage: exception.massage)
        } catch {
            systemError(massage: "Error open file.")
        }
    }
    
    // MARK: Обработка файла и сбор информации.
    private func workingText(text: String) throws {
        let lines = text.split() { $0 == "\n" }.map{ String($0) }
        let errorDataFile = "Invalid data file."
        if lines.count < 2 {
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
        var mileage = [Double]()
        var price = [Double]()
        for line in lines[1...] {
            let miliagePrice = line.split() { $0 == "," }.map{ String($0) }
            if miliagePrice.count != 2 {
                throw Exception(massage: "Error data file: {\(line)}")
            }
            guard let mileageDouble = Double(miliagePrice[0]) else {
                throw Exception(massage: "Error data file: {\(line)}")
            }
            guard let priceDouble = Double(miliagePrice[1]) else {
                throw Exception(massage: "Error data file: {\(line)}")
            }
            mileage.append(mileageDouble)
            price.append(priceDouble)
        }
        print(mileage)
        print(price)
    }
    
    // MARK: Вывод сообщения об ошибке в поток ошибок
    private func systemError(massage: String) {
        fputs(massage + "\n", stderr)
        exit(-1)
    }
    
    // MARK: Чтение данных из файла.
    private func readFile(fileName: String) throws -> String {
        let manager = FileManager.default
        let currentDirURL = URL(fileURLWithPath: manager.currentDirectoryPath)
        let fileURL = currentDirURL.appendingPathComponent(fileName)
        return try String(contentsOf: fileURL)
        
    }
    
    // MARK: Запись в файл.
    private func writeFile(fileName: String, text: String) throws {
        let manager = FileManager.default
        let currentDirURL = URL(fileURLWithPath: manager.currentDirectoryPath)
        let fileURL = currentDirURL.appendingPathComponent(fileName)
        try text.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}
