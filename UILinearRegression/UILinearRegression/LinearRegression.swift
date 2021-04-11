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
    
    var dict = [Double: Double]()
    var dictNormalize = [Double: Double]()
    var maxMiliage: Double?
    var minMiliage: Double?
    var maxPrice: Double?
    var minPrice: Double?
    var k = Double(0)
    var b = Double(0)
    
    init(text: String) {
        do {
            try workingText(text: text)
            try normalize()
            linearRegression()
            adjustmentCoefficient()
        } catch let exception as Exception {
            systemError(massage: exception.massage)
        } catch {
            systemError(massage: "Error open file.")
        }
    }
    
    // MARK: Корректирока коэффициента k.
    private func adjustmentCoefficient() {
        guard let maxMiliage = self.maxMiliage else { return }
        if maxMiliage == 0 { return }
        self.k = self.k / maxMiliage
    }
    
    // MARK: Нормализация данных Минимакс. Приведение данных по километрожу и стоимости к диапозону [0,1]
    private func normalize() throws {
        var normalizeDict = [Double: Double]()
        guard let maxM = maxMiliage, let minM = minMiliage, let maxP = maxPrice, let minP = minPrice else {
            throw Exception(massage: "Error data.")
        }
        if maxM == minM || maxP == minP {
            throw Exception(massage: "Error normalize.")
        }
        let deltaM = maxM - minM
        for (miliage, price) in self.dict {
            let miliageNorm = (miliage - minM) / deltaM
            normalizeDict[miliageNorm] = price
        }
        self.dictNormalize = normalizeDict
    }
    
    // MARK: Вычисление квадратичной ошибки.
    private func quadraticError(k: Double, b: Double, dict: [Double: Double]) -> Double {
        var error = Double(0)
        let count = Double(dict.count)
        for (mileage, price) in dict {
            error += (k * mileage + b - price)**2.0 / count
        }
        return error
    }
    
    // MARK: Обпределение коэфициентов k и b методом линейной регрессии.
    private func linearRegression() {
        var error = Double.infinity
        let lr = 0.01
        let count = Double(dictNormalize.count)
        while true {
            var summK = Double(0)
            var summB = Double(0)
            for (mileage, price) in dictNormalize {
                summB += (k * mileage + b - price)
                summK += (k * mileage + b - price) * mileage
            }
            k = k - lr * summK / count
            b = b - lr * summB / count
            let temp = quadraticError(k: k, b: b, dict: dictNormalize)
            if temp > error {
                return
            } else {
                error = temp
            }
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
            if self.maxMiliage == nil {
                self.maxMiliage = mileageDouble
            } else if self.maxMiliage! < mileageDouble {
                self.maxMiliage = mileageDouble
            }
            if self.minMiliage == nil {
                self.minMiliage = mileageDouble
            } else if self.minMiliage! > mileageDouble {
                self.minMiliage = mileageDouble
            }
            if self.maxPrice == nil {
                self.maxPrice = priceDouble
            } else if self.maxPrice! < priceDouble {
                self.maxPrice = priceDouble
            }
            if self.minPrice == nil {
                self.minPrice = priceDouble
            } else if self.minPrice! > priceDouble {
                self.minPrice = priceDouble
            }
            self.dict[mileageDouble] = priceDouble
        }
    }
    
    // MARK: Вывод сообщения об ошибке в поток ошибок
    private func systemError(massage: String) {
        fputs(massage + "\n", stderr)
    }
}

infix operator ** : MultiplicationPrecedence

func ** (num: Double, power: Double) -> Double{
    return pow(num, power)
}
