# Migration from version 5.x.x to 6.x.x

## Dependency
The name of the SDK has been modified to `WorldlineConnectKit`. You need to update your dependencies:

### Cocoapods:
Update your `Podfile` by using the new SDK Pod name:
```
pod 'WorldlineConnectKit'
```

Afterwards, run the following command:
```
pod install
```

### Carthage:
Update your `Cartfile` with the new Github location of the SDK:
```
github "Worldline-Global-Collect/connect-sdk-client-swift"
```

Afterwards, run the following command:
```
carthage update
```

## Imports
Update your imports to the new naming of the SDK and its files.
- `IngenicoConnectKit` becomes `WorldlineConnectKit`

## Removed
The following enums have been removed:
- `Region`
- `Environment`
- `CurrencyCode`
- `CountryCode`

The following constructors have been removed:
- `Session(String, String, Region, Environment, String, Bool)`
- `C2SCommunicator(String, String, Region, Environment, String, Util?, Bool)`
- `C2SCommunicator(String, String, Region, Environment, String, String?, Util?, Bool)`
- `PaymentContext(PaymentAmountOfMoney, Bool, CountryCode)`
- `IINDetailsResponse(String, IINStatus, [IINDetail], CountryCode, Bool)`
- `PaymentAmountOfMoney(Int, CurrencyCode)`

The following functions have been removed:
- `convert(Int, CurrencyCode, CurrencyCode, (Int) -> Void, (Error) -> Void)` in `Session`
- `directory(String, CountryCode, CurrencyCode, (DirectoryEntries) -> Void, (Error) -> Void)` in `Session`
- `C2SBaseURL(Region, Environment)` and `assetsBaseURL(Region, Environment)` in `Util`

The following properties have been removed:
- `isEnvironmentTypeProduction` in `Session`
- `region`, `environment`, `isEnvironmentTypeProduction` in `C2SCommunicator`
