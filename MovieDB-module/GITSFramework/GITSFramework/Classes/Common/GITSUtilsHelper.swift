//
//  GITSUtilsHelper.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 13/03/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import Foundation
import MessageUI
import ContactsUI

public struct GITSUtilsHelper {
//    public static func doOpenUrl(url: String) {
//        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
//    }
//
//    public static func doCall(tel: String) {
//        if let url = URL(string: "tel://\(tel)"), UIApplication.shared.canOpenURL(url) {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
//    }
//
//    public static func doMessage(caller: UIViewController, tel: String, message: String, delegate: MFMessageComposeViewControllerDelegate?) {
//        if (MFMessageComposeViewController.canSendText()) {
//            let controller = MFMessageComposeViewController()
//            controller.body = message
//            controller.recipients = [tel]
//            controller.messageComposeDelegate = delegate
//            caller.present(controller, animated: true, completion: nil)
//        }
//    }
//
//    public static func doWhatsapp(tel: String, onError: @escaping onError) {
//        var phoneNum = tel
//        if tel.first == "0" {
//            phoneNum.removeFirst()
//        }
//        phoneNum = "+62\(phoneNum)"
//        if let url = URL(string: "whatsapp://send?phone=\(phoneNum)"), UIApplication.shared.canOpenURL(url) {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url)
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        } else {
//            onError("Whatsapp not installed on your phone")
//        }
//    }
//
//    public static func doAddPhoneBook(nav: UINavigationController, delegate: CNContactViewControllerDelegate, store: CNContactStore, firstName: String, lastName: String, email: String, tel: String, onError: @escaping onError) {
//        self.getAuthAccessPhoneBook(store: store) { (result) in
//            if !result {
//                onError("Access to write/read phone book is not authorized! Please goto Setting")
//            } else {
//                let newContact = CNMutableContact()
//                newContact.givenName = firstName
//                newContact.familyName = lastName
//
//                // email
//                if email != "" {
//                    let contactEmail = CNLabeledValue(label: CNLabelHome, value: email as NSString)
//                    newContact.emailAddresses = [contactEmail]
//                }
//
//                // phone
//                if tel != "" {
//                    let contactPhone = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: tel))
//                    newContact.phoneNumbers = [contactPhone]
//                }
//
//                let controller = CNContactViewController(forNewContact: newContact)
//                controller.contactStore = store
//                controller.delegate = delegate
//                controller.view.backgroundColor = UIColor.white
//                let navContact = UINavigationController(rootViewController: controller)
//                nav.present(navContact, animated: true, completion: nil)
//            }
//        }
//    }
//
//    public static func getAuthAccessPhoneBook(store: CNContactStore, onResult: @escaping (_ success: Bool)-> Void) {
//        switch CNContactStore.authorizationStatus(for: .contacts) {
//        case .authorized:
//            onResult(true)
//        case .notDetermined:
//            store.requestAccess(for: .contacts, completionHandler: { (success, error) in
//                guard error == nil && success else {
//                    return
//                }
//                onResult(true)
//            })
//        default:
//            onResult(false)
//        }
//    }
}
