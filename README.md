# Vollmed iOS App

## Introduction

*(Briefly explain what your app does. You can mention its main features or its purpose.)*

## Screenshots

*(Add the screenshots os animated .gif later on.)*


## Getting Started

### Prerequisites

*(List any prerequisites for your project here. For example, the minimum iOS version, necessary tools like Xcode, etc.)*

### Installation

*(Step by step instructions on how to get your app running on a local machine for development and testing purposes.)*

## Features

*(Describe each feature of your app in detail. You can organize this section by feature or by screen.)*

## Code Snippets

*(Include a few code snippets that you are particularly proud of or that you think represent your coding style well. Explain what each snippet does.)*

For example:

```swift
extension String {
    func convertDateStringToReadableDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = inputFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
            return dateFormatter.string(from: date)
        }

        return ""
    }
}
