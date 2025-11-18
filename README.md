# sandwich_shop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Sandwich Shop App

The Sandwich Shop App is a simple Flutter application that allows users to manage a sandwich counter. Users can select the type of sandwich (Footlong or Six-inch) and adjust the quantity of sandwiches within a specified range.

## Features

- **Sandwich Type Selection**: Choose between "Footlong" and "Six-inch" sandwiches using a segmented button.
- **Quantity Adjustment**: Add or remove sandwiches with buttons, ensuring the quantity stays within the range of 0 to 10.
- **Dynamic UI**: The app dynamically updates the displayed sandwich type and quantity based on user interaction.
- **Styled Buttons**: Buttons are styled to indicate whether they are enabled or disabled based on the current quantity.

## Project Structure

```
sandwich_shop/
├── lib/
│   └── main.dart  # Contains the main app logic and UI components
```

## How to Run

1. **Install Flutter**: Ensure you have Flutter installed on your system. Follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install) for your platform.
2. **Clone the Repository**: Clone this project to your local machine.
   ```bash
   git clone <repository-url>
   ```
3. **Navigate to the Project Directory**:
   ```bash
   cd sandwich_shop
   ```
4. **Run the App**:
   - Use the following command to run the app on an emulator or connected device:
     ```bash
     flutter run
     ```

## Code Overview

### `main.dart`

- **`App`**: The main stateful widget that manages the sandwich counter logic.
- **`StyledButton`**: A reusable widget for creating styled buttons with enabled/disabled states.

### Key Methods

- `_addQuantity`: Increases the sandwich quantity by 1, up to a maximum of 10.
- `_removeQuantity`: Decreases the sandwich quantity by 1, down to a minimum of 0.

## Screenshots

| Feature                | Screenshot |
|------------------------|------------|
| Sandwich Counter       | ![Counter](https://via.placeholder.com/300x600?text=Sandwich+Counter) |
| Type Selection         | ![Selection](https://via.placeholder.com/300x600?text=Type+Selection) |

## Future Enhancements

- Add more sandwich types.
- Implement a checkout feature.
- Enhance the UI with animations and additional styling.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Flutter](https://flutter.dev/) for providing an amazing framework for building cross-platform apps.