//
//  CurrencyListViewController.swift
//  RevolutCurrencyApplication
//
//  Created by Emily Ip on 25/01/2019.
//  Copyright © 2019 Emily Ip. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var stateView: NoDataStateView?
    @IBOutlet var tableView: UITableView?
    
    // MARK: - Params
   
    var latestCurrencies: LatestCurrencies? {
        didSet {
            guard let rates = self.latestCurrencies?.getExchangeRates(withAmount: self.amountEntered) else {
                return
            }
            self.rates = rates
            self.updateRates(amount: self.amountEntered)
            self.reloadTable()
            self.startTimer()
        }
    }
    
    var currentlyEditing: Bool = false
    var amountEntered: Float = 100
    var baseRate: CurrencyType = .EUR
    
    var rates: [RVExchangeRate]?
    var modifiedRates = [RVExchangeRate]()
    
    var timer: Timer?
    
    var showStateView: Bool = false {
        didSet {
            self.stateView?.isHidden = !self.showStateView
            self.stateView?.setup(
                .noDataAvailable,
                reloadTapped: { [weak self] in
                    guard let self = self else { return }
                    self.refresh()
            })
        }
    }

    // MARK: - View lifecycle
    
    deinit {
        self.killTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.showStateView = false
        self.tableView?.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
        self.tableView?.rowHeight = 80
        self.tableView?.contentInsetAdjustmentBehavior = .automatic
        self.tableView?.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getData()
    }
    
    // MARK: - Request
    
    private func reloadTable() {
        DispatchQueue.main.async {
            if self.currentlyEditing {
                self.updateCells()
            } else {
                self.tableView?.reloadData()
            }
        }
    }
    
    // When editing a textfield update the cell information
    // instead of calling .reloadData()
    private func updateCells() {
        for (index, rate) in self.modifiedRates.enumerated() {
            guard let cell = self.tableView?.cellForRow(at: IndexPath(row: index, section: 0)) as? CurrencyTableViewCell,
                let model = self.latestCurrencies?.modelFor(exchangeRate: rate) else {
                    continue
            }
            cell.setup(model: model)
        }
    }
    
    private func getData() {
        let datasource = CurrencyListDatsource(currency: self.baseRate) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failed(_):
                
                self.showStateView = true
                self.killTimer()
            case .success(let currencies):
                
                guard let latestCurrencies = currencies as? LatestCurrencies else {
                    return
                }
                self.latestCurrencies = latestCurrencies
                self.showStateView = false
            }
        }
        datasource.load()
    }

    @objc private func refresh() {
        guard let contentOffset = self.tableView?.contentOffset else {
            return
        }

        self.getData()
        self.tableView?.contentOffset = contentOffset
    }
    
    private func updateRates(amount: Float) {
        guard let rates = self.rates else {
            return
        }
        
        // CurrencyOne is the currency to exchange
        // where CurrencyOne == CurrencyTwo is the base rate
        // Only update the first rate if there is an existing one
        if self.baseRate != rates.first?.currencyOne,
            rates.first?.currencyOne == rates.first?.currencyTwo {
            let baseRate = RVExchangeRate(
                currencyOne: self.baseRate,
                currencyTwo: self.baseRate,
                rate: 0,
                amount: amount
            )
            
            self.modifiedRates.remove(at: 0)
            self.modifiedRates.insert(baseRate, at: 0)
        }
        
        for rate in rates {
            let exchangeRateModel = RVExchangeRate(
                currencyOne: self.baseRate,
                currencyTwo: rate.currencyTwo,
                rate: rate.rate,
                amount: amount
            )
            // Keep the order of the rate in the array and just
            // update the value of existing rate
            if let indexOfRate = self.modifiedRates.firstIndex(where: { $0.currencyTwo == rate.currencyTwo }) {
                self.modifiedRates[indexOfRate] = exchangeRateModel
            } else {
                self.modifiedRates.append(exchangeRateModel)
            }
        }
    }
    
    // MARK: - Timer
    
    private func startTimer() {
        guard self.timer == nil else {
            return
        }
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.refresh),
            userInfo: nil,
            repeats: true
        )
    }
    
    private func killTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

// MARK: - UITextFieldDelegate
extension CurrencyListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        var updatedText: String? = ""
       
        if string == "", text.count > 0 {
            updatedText = String(text.dropLast())
        } else if let textRange = Range(range, in: text) {
            updatedText = text.replacingCharacters(in: textRange, with: string)
        }
        
        let numberValueToCheck = NSDecimalNumber(string: updatedText)
        self.amountEntered = updatedText?.isEmpty == true ? 0 : numberValueToCheck.floatValue
        self.updateRates(amount: numberValueToCheck.floatValue)
        self.getData()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentlyEditing = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.currentlyEditing = false
    }
}

// MARK: - UITableViewDatasource
extension CurrencyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !self.modifiedRates.isEmpty ? self.modifiedRates.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CurrencyTableViewCell.self),
            for: indexPath) as? CurrencyTableViewCell,
            !self.modifiedRates.isEmpty else {
                fatalError("Unexpected cell dequeued from tableView, expecting \(String(describing: CurrencyTableViewCell.self))")
        }
        
        let exchangeRate = Array(self.modifiedRates)[indexPath.row]
        
        guard let model = self.latestCurrencies?.modelFor(exchangeRate: exchangeRate) else {
            fatalError("Model doesn't exist")
        }
        cell.setup(model: model)
        cell.setTextDelegate(indexPath.row == 0 ? self : nil)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CurrencyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rateToRemoveAndReInsert = self.modifiedRates.remove(at: indexPath.row)
        self.baseRate = rateToRemoveAndReInsert.currencyTwo
        self.amountEntered = rateToRemoveAndReInsert.exchangeValue
        
        tableView.beginUpdates()
        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        self.modifiedRates.insert(rateToRemoveAndReInsert, at: 0)
        tableView.endUpdates()
        
        UIView.animate(withDuration: 0.3, animations: {
             tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }) { (finished) in
            if finished {
                // first cell to become first responder when tapped
                let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CurrencyTableViewCell
                firstCell?.setTextDelegate(self, becomeResponder: true)
            }
        }
    }
}
