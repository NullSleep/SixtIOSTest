# Sixt Car Finder Test

Sixt car finder iOS test application. Find a nearby cars to rent in the Munich area.

## Technical Stack

### Enviroment
- Xcode 10.2.1
- Swift 5.0.1

### Dependencies
This project uses Cocapods [Cocoapods](https://cocoapods.org/) for dependcy managment.

- SwiftLint - Linting of Swift code
- SDWebImage - Asynchronous image retrieval/caching

### Deployment
- Source Control - [GitHub](https://github.com/)
- Continuous Deployment - [BuddyBuild](https://buddybuild.com/)
- Hound CI - [Hound](https://www.houndci.com)

## Functionality
- Select any pin in the map to see the car information:

![](Functionality/detail.gif)

- Drag up and down the Car List view. This view has three states, closed, half opened and fully opened:

![](Functionality/carList.gif)

- On the Map View after selecting a pin you can tap on the car image to be redirected to the Apple Maps to get directions to the car location:

![](Functionality/route.gif)

## Getting Started
### Getting the project
- The project can be cloned from https://github.com/NullSleep/SixtIOSTest

### Managing dependencies
[Cocoapods](https://cocoapods.org/) is used for dependency management. To install dependencies:

- open terminal and `cd` into root directory of project, where the `Podfile` is located.

- type command:

      pod install

- open project

      open SixtCarFinder.xcworkspace

     Note, do not open the `.xcodeproj`, but always work with the `.xcworkspace` file.
