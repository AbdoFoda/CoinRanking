# CoinList Application

## Overview
The **CoinList Application** is an iOS app that displays a list of cryptocurrencies, including their prices, performance, and icons. It uses a hybrid architecture of **UIKit** and **SwiftUI** to deliver a responsive and modular user interface.

---

## Features

- **List of Cryptocurrencies**:
  - Displays coin names, prices, and 24-hour performance changes.
  - Icons are dynamically loaded from the network (supports PNG and SVG formats).

- **Dynamic Image Loading**:
  - Uses **Kingfisher** for PNG/JPG images.
  - Uses **WKWebView** for rendering SVG images.
  - Includes skeleton placeholders while images are loading.

- **Hybrid UIKit & SwiftUI**:
  - **UITableView** for the list.
  - **SwiftUI `CoinImageView`** for handling image rendering inside table view cells.

---

## Technologies Used

### Frameworks
- **SwiftUI**: For rendering coin icons and implementing declarative UI components.
- **UIKit**: For managing the table view and providing the main list layout.
- **Kingfisher**: For efficient PNG/JPG image downloading and caching.
- **WebKit**: For rendering SVG images in a `WKWebView`.

### Libraries
- **KingfisherSwiftUI**: For handling image downloads and caching in SwiftUI.
- **SVGKit** (optional): For additional support if SVG rendering is required outside `WKWebView`.

---

## Installation

### Prerequisites
- Xcode 14.0 or higher.
- iOS 15.0 or higher.

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/CoinList.git
   cd CoinList
   ```

2. Open the project in Xcode:
   ```bash
   open CoinList.xcodeproj
   ```

3. Install dependencies using **Swift Package Manager** (SPM):
   - Go to **File > Add Packages**.
   - Add the following dependencies:
     - `https://github.com/onevcat/Kingfisher` (for Kingfisher)
     - `https://github.com/mchoe/SwiftSVG` (if SVGKit is needed).

4. Build and run the project:
   - Select a simulator or physical device.
   - Press **Command + R** to build and run.

---

## How It Works

### Architecture
The app uses a **MVVM (Model-View-ViewModel)** architecture for clean separation of concerns:

- **Model**:
  - Represents cryptocurrency data, including properties like name, price, and icon URL.

- **ViewModel**:
  - Provides the logic for fetching and formatting coin data.
  - Handles image URL validation and state management for UI updates.

- **View**:
  - Combines **UIKit** and **SwiftUI** components to render the user interface.

### Dynamic Image Loading
1. **PNG/JPG Images**:
   - Loaded using Kingfisher’s `KFImage`.
   - Automatically cached for performance.

2. **SVG Images**:
   - Rendered using `WKWebView`.
   - Embedded inside `UITableViewCell` using `UIHostingController`.

### Skeleton Placeholder
- Displays a shimmer effect using a custom **SwiftUI SkeletonView** until the image is fully loaded.

---

## Known Issues & Limitations

1. **SVG Rendering**:
   - Currently handled by `WKWebView`. Ensure that URLs point to valid SVG files.

2. **Error Handling**:
   - Image loading errors display a default placeholder.

3. **Simulator Differences**:
   - WebKit processes may behave differently on simulators compared to physical devices.

---

## Future Improvements

- **Enhanced Error Handling**:
  - Display more descriptive messages for image loading errors.

- **Dark Mode Support**:
  - Adjust UI elements for a better experience in dark mode.

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Contributing
Contributions are welcome! Please submit a pull request or create an issue for feature requests or bug reports.

---

## Contact
For questions or feedback, reach out at **youremail@example.com**.
