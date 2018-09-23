# RapidFire

RapidFire is a simple networking library. It is suitable for casual use such as prototyping and example project.
It wraps URLSession and is written in Swift.

## Requirements
- Swift 4.2
- iOS 8.0 or later

## Features
- Chainable Request
- GET / POST / PUT / PATCH / DELETE
- URL / JSON Parameter Encoding
- multipart/form-data
- JSON to Array / JSON to Dictionary Helper Method


## Installation

### Carthage

* Cartfile

```Cartfile
github "keygx/RapidFire"
```
or

```Cartfile
github "keygx/RapidFire" "branch-name"
```
or

```Cartfile
github "keygx/RapidFire" "tag"
```

* install

```
$ carthage update
```
To integrate "RapidFire.framework" into your Xcode project

## Usage

### Basic Request
```swift
RapidFire(.get, "https://example.com/users")
	.setCompletionHandler({ (response: RapidFire.Response) in
		switch response.result {
		case .success:
            // success
        case .failure:
            // failure
        }
	})
	.fire()
```

### Init
```swift
RapidFire(HTTP Method, baseURL)
```

```swift
// HTTP Method
public enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}
```
```swift
// baseURL
ex: "https://example.com"
```

### Path
```swift
.setPath("/path")
```

### Headers
```swift
.setHeaders(["x-myheader-1":"value1", "x-myheader-2":"value2"])
```

### Query Parameters
```swift
.setQuery(["a":"1", "b":"2"]) //?a=1&b=2
```

### Body Parameters
```swift
.setBody(["a":"1", "b":"2"])
```

### application/json
```swift
.setJSON(["a":"1", "b":"2"])
```

### multipart/form-data
```swift
.setPartData(["a":"1", "b":"2"])
.setPartData(RapidFire.PartData(name: "image", filename: "sample.png", value: imageData, mimeType: "image/png"))
```

### Timeout
```swift
.setTimeout(30) //sec.
```

### Retry
```swift
.setRetry(3) //default interval 15 sec.

.setRetry(3, intervalSec: 30)
```

### Response
```swift
.setCompletionHandler({ (response: RapidFire.Response) in
    switch response.result {
    case .success:
        print("success:\n \(response.statusCode as Any): \(response.response as Any)")
        print(response.toDictionary())
    case .failure:
        print("error:\n \(response.statusCode as Any): \(response.error as Any)")
    }
})
```

###### RapidFire.Response.swift
```swift
public enum Result {
    case success
    case failure
}
    
public var result:     Result
public var statusCode: Int?
public var data:       Data?
public var response:   URLResponse?
public var error:      Error?


// Convert JSON to Dictionary
public func toDictionary() -> [String: Any]

// Convert JSON to Array
public func toArray() -> [[String: Any]]

// Convert JSON to String
public func toString() -> String
```

### Utilities
```swift
// Convert JSON to Dictionary
RapidFire.Util.toDictionary(from: response.data)

// Convert JSON to Array
RapidFire.Util.toArray(from: response.data)

// Convert JSON to String
RapidFire.Util.toString(from: response.data)

// Convert to JSON
RapidFire.Util.toJson(from: ["a":"1", "b":"2"])
```


## License

RapidFire is released under the MIT license. See LICENSE for details.

## Author

Yukihiko Kagiyama (keygx) <https://twitter.com/keygx>
