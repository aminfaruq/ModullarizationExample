//
//  DAOMovieListDates.swift
//
//  Created by Amin faruq on 25/09/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOMovieListDates: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let maximum = "maximum"
    static let minimum = "minimum"
  }

  // MARK: Properties
  public var maximum: String?
  public var minimum: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    maximum = json[SerializationKeys.maximum].string
    minimum = json[SerializationKeys.minimum].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = maximum { dictionary[SerializationKeys.maximum] = value }
    if let value = minimum { dictionary[SerializationKeys.minimum] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.maximum = aDecoder.decodeObject(forKey: SerializationKeys.maximum) as? String
    self.minimum = aDecoder.decodeObject(forKey: SerializationKeys.minimum) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(maximum, forKey: SerializationKeys.maximum)
    aCoder.encode(minimum, forKey: SerializationKeys.minimum)
  }

}
