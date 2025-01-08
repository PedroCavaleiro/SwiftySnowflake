# SwiftySnowflake
A simple library for Swift to handle Snowflake IDs

## Table of Contents

- [Configuration](#configuration)
  - [Using default configuration](#using-default-configuration)
  - [Using custom configuration](#using-custom-configuration)
  - [Configuration Object](#configuration-object)
- [Usage](#usage)
  - [Generating a new snowflake](#generating-a-new-snowflake)
  - [Parsing a Snowflake](#parsing-a-snowflake)
- [Snowflake Object](#snowflake-object)

## Configuration

### Using default configuration
It's possible to the defaults, no need to call any method or initialize any class for this purpose.

### Using custom configuration
You can also configure the Snowflake ID with your own parameters (Epoch, Worker ID and if the snowflake is in UTC) for this follow the following steps:

1. Set the configuration ([see here](#configuration-object)) object 
```swift
fileprivate let dateComponents = DateComponents(calendar: Calendar.current, year: 2024, month: 7, day: 19, hour: 0, minute: 0, second: 0)
let snowflakeConfiguration = Configuration(epoch: dateComponents.date ?? Date(), workedId: 0, alwaysUseUtc: true)
```

2. In your AppDelegate.swift or projectApp.swift configure the SwiftySnowflake, this doesn't need to be upon startup but it's recommended
```swift
SwiftySnowflake.configure(configuration: snowflakeConfiguration) // the configuration in the step 1.
```

### Configuration Object

The configuration object can be initialized using a Int64 for the epoch or a Date object, the example provided [here](#using-custom-configuration) describes how to use the initialization with date object

* Using Int64 as epoch

| Parameter Name | Type    | Required | Default         | Description                                                          |
|----------------|---------|----------|-----------------|----------------------------------------------------------------------|
| `epoch`        | `Int64` | no       | `1275350400000` | Epoch TimeStamp (in milliseconds) to start generating the Snowflakes |
| `workerId`     | `Int`   | no       | `1`             | Worker ID that is going to generate the Snowflakes                   |
| `alwaysUseUtc` | `Bool`  | no       | `true`          | Generates the timestamps in UTC (recommended)                        |

* Using Date as epoch

| Parameter Name | Type    | Required | Default         | Description                                                                    |
|----------------|---------|----------|-----------------|--------------------------------------------------------------------------------|
| `epoch`        | `Date`  | yes      |                 | Date where the Worker ID should start generating timestamps for the Snowflakes |
| `workerId`     | `Int`   | no       | `1`             | Worker ID that is going to generate the Snowflakes                             |
| `alwaysUseUtc` | `Bool`  | no       | `true`          | Generates the timestamps in UTC (recommended)                                  |

## Usage

### Generating a new snowflake

No matter if you want to use the default configuration or a custom one, to generate a Snowflake ID you just need to call the following function. If called before the `.configuration()` method is called the default values will be used

```swift
let newSnowflakeId = SwiftySnowflake.shared.generateSnowflake()
```

If you fee the method is too long you can always declare a global method in your project to shorten that call, for example
```swift
func GenerateSnowflake() -> Int64 {
    return SwiftySnowflake.shared.generateSnowflake()
}
```

### Parsing a Snowflake

SwiftySnowflake includes a extension to parse a Snowflake ID from a `String` or `Int64` with minimal effort. The example below is applied in a `Int64` but the same method is available for `String`.

```swift
let snowflake = 61574699733221376.toSnowflake()                              // using the configuration in SwiftySnowflake.shared
let snowflake = 61574699733221376.toSnowflake(useGlobalConfiguration: false) // using the default Configuration
let snowflake = 61574699733221376.toSnowflake(yourConfiguration)             // if you want to use a custom configuration for this snowflake 
```

## Snowflake Object

This object contains:
* Timestamp: When the Snowflake ID was generated
* Machine ID: The machine that generated this Snowflake ID
* Sequence

It's possible to update it's configuration (in case it was parsed with wrongfully configuration) by calling `.updateConfiguration(_ configuration: Configuration)`

To get the `Date` object for when it was created just access the computed variable `time`
