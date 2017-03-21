//
//  UserDefaultsPasscodeRepository.swift
//  PasscodeLock
//
//  Created by Yanko Dimitrov on 8/29/15.
//  Copyright © 2015 Yanko Dimitrov. All rights reserved.
//

import Foundation
import UICKeyChainStore
class UserDefaultsPasscodeRepository: PasscodeRepositoryType {
    
    private let passcodeKey = "passcode.lock.passcode"
    
    private lazy var defaults: UserDefaults = {
        
        return UserDefaults.standard
    }()
  
    private lazy var keyChainStore: UICKeyChainStore = {
    
      return UICKeyChainStore(service: "sh.blink.auth")
    
    }()
  
    var hasPasscode: Bool {
        
        if passcode != nil {
            return true
        }
        
        return false
    }
    
    var passcode: [String]? {
      let passCodeString = keyChainStore.string(forKey: passcodeKey)
      var passCodeArray = [String]()
      for code in (passCodeString?.characters)! {
        passCodeArray.append(String(code))
      }
      return passCodeArray
    }
    
    func savePasscode(passcode: [String]) {
        var passCodeString = ""
      for code in passcode {
        passCodeString += code
      }
      keyChainStore.setString(passCodeString, forKey: passcodeKey)
    }
    
    func deletePasscode() {
        
        defaults.removeObject(forKey: passcodeKey)
        defaults.synchronize()
    }
}
