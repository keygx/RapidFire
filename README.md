# RapidFire

RapidFire is a simple networking library. It is suitable for casual use such as prototyping and example project.
It wraps URLSession and is written in Swift.

## Requirements
- Swift 3.0.2
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

```
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

### Path
```
.setPath("/path")
```

### Headers
```
.setHeaders(["x-myheader-1":"value1", "x-myheader-2":"value2"])
```

### Query Parameters
```
.setQuery(["a":"1", "b":"2"])
```

### Body Parameters
```
.setBody(["a":"1", "b":"2"])
```

### application/json
```
.setJSON(["a":"1", "b":"2"])
```

### multipart/form-data
```
.setPartData(["a":"1", "b":"2"])
.setPartData(RapidFire.PartData(name: "image", filename: "sample.png", value: imageData, mimeType: "image/png"))
```

### Timeout
```
.setTimeout(30) //sec.
```

### Retry
```
.setRetry(3)

.setRetry(3, intervalSec: 30)
```

### Response
```
.setCompletionHandler({ (response: RapidFire.Response) in
    switch response.result {
    case .success:
        print("success:\n \(response.statusCode): \(response.response)")
        print(response.toDictionary())
    case .failure:
        print("error:\n \(response.statusCode): \(response.error)")
    }
})
```

### Utilities
```
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