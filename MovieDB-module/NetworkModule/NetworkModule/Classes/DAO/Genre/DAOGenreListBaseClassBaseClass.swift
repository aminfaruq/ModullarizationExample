//
//  DAOGenreListBaseClassBaseClass.swift
//
//  Created by Amin faruq on 30/09/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DAOGenreListBaseClassBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let genres = "genres"
  }

  // MARK: Properties
  public var genres: [DAOGenreListBaseClassGenres]?

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
    if let items = json[SerializationKeys.genres].array { genres = items.map { DAOGenreListBaseClassGenres(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.genres = aDecoder.decodeObject(forKey: SerializationKeys.genres) as? [DAOGenreListBaseClassGenres]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(genres, forKey: SerializationKeys.genres)
  }

}
