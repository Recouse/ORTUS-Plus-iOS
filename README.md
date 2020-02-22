![Artwork](images/artwork.jpg)

# ORTUS+
![Platform](https://img.shields.io/badge/platform-ios-lightgrey) ![Language](https://img.shields.io/github/languages/top/ORTUS-Plus/iOS?color=orange)

ORTUS+ is a mobile application for Riga Technical University to provide a better experience for students. Some features:
* Schedule
* Entering to the ORTUS website without entering a password or PIN code
* Grades
* Full courses list
* Notifications
* News

And also:
* Dark mode support
* Home screen quick actions
* iOS native UI

> Join the [TestFlight beta](https://testflight.apple.com/join/kocXDWmm)

## Building

### Build dependencies
Install [Carthage](https://github.com/Carthage/Carthage) and in the project directory run:
```
carthage build --platform iOS
```

### Add keys and IDs
Create an extension of `Global` struct, and add:
```swift
extension Global {
    static let clientID = "*YOUR CLIENT ID*"
    static let clientSecret = "*YOUR CLIENT SECRET*"
    
    static let yandexAppMetricaKey = "*YOUR APP METRICA KEY OR EMPTY*"
}
```

## Contribution
Feel free to make pull requests and create issues.
