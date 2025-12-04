Requirements Document: Cart Item Modification

1. Feature Description and Purpose

Feature Name: Cart Item Modification
Target Users: All customers using the sandwich ordering application.

Description:
This feature allows users to directly manage and adjust the items they have added to their shopping cart on the dedicated Cart Screen. Currently, users can only add items. The addition of modification capabilities—specifically changing the quantity of an existing sandwich configuration or removing it entirely—significantly enhances the user experience, providing control and flexibility before checkout. The system must correctly update the item's subtotal and the overall cart total in real-time following any modification.

Purpose:
To provide users with full control over the contents and cost of their order before proceeding to payment, reducing cart abandonment and improving order accuracy.

2. User Stories

The following user stories describe how different user types will interact with the new feature:

Story 1: Adjusting Item Quantity (Increment)

As a customer,
I want to increase the quantity of a specific sandwich I already added to my cart,
So that I can easily order a second of the exact same item without having to go back to the ordering screen.

Story 2: Adjusting Item Quantity (Decrement)

As a customer,
I want to decrease the quantity of a specific sandwich in my cart,
So that I can correct an accidental over-ordering without removing the item completely.

Story 3: Removing an Item

As a customer,
I want to completely remove an item from my cart,
So that I can easily decide not to purchase it anymore.

Story 4: Real-Time Total Update

As a customer,
I want the total price of my order to instantly reflect any changes in quantity or item removal,
So that I always know the current cost of my cart.

Story 5: Cart Integrity

As a system,
I must ensure that a decrease in quantity to zero results in the item being removed from the list of cart items,
So that the cart remains clean and only shows items with a quantity greater than zero.

3. Acceptance Criteria (AC)

The feature is considered complete when all the following criteria are met:

A. Data Model & Logic (Backend)

ID

Criterion

Details

AC-3.1

CartItem Model Defined

A CartItem model exists, containing a Sandwich instance and an integer quantity.

AC-3.2

Item Subtotal Calculation

The CartItem exposes a getter (e.g., itemSubtotal) that correctly uses the Pricing repository (calculatePrice(size, quantity)) to determine the subtotal for that item.

AC-3.3

Cart Total Recalculation

The Cart model's overall totalPrice getter correctly sums the itemSubtotal of all CartItems.

AC-3.4

Quantity Increment Logic

The Cart.updateItemQuantity method correctly locates the target CartItem and increases its quantity by 1 when the new quantity is positive.

AC-3.5

Quantity Decrement Logic

The Cart.updateItemQuantity method correctly locates the target CartItem and decreases its quantity by 1, provided the new quantity is greater than zero.

AC-3.6

Quantity Zero = Removal

If the Cart.updateItemQuantity method is called resulting in a newQuantity of 0, the CartItem must be removed from the cart's item list entirely.

AC-3.7

Explicit Removal Logic

The Cart.removeItem(Sandwich) method correctly identifies and removes the specified CartItem from the cart's item list.

AC-3.8

State Notification

After any successful modification (add, update quantity, remove), the Cart model must call notifyListeners() to update the UI.

B. User Interface (Frontend - CartScreen)

ID

Criterion

Details

AC-

3.9

Item Details Display

Each item in the cart prominently displays the sandwich's type, size, and breadType.

AC-3.10

Item Subtotal Display

The calculated itemSubtotal is displayed next to each item in the cart.

AC-3.11

Quantity Controls

For every item, a responsive control group (e.g., a row) is visible, consisting of: a decrement button (-), a live quantity display, and an increment button (+).

AC-3.12

Decrement Functionality

Tapping the decrement button (-) successfully calls Cart.updateItemQuantity to reduce the quantity by 1. The button is visually disabled or hidden if the quantity is already 1 (since a decrease to 0 should be handled by the explicit remove button/logic).

AC-3.13

Increment Functionality

Tapping the increment button (+) successfully calls Cart.updateItemQuantity to increase the quantity by 1.

AC-3.14

Remove Button Visibility

An explicit "Remove" control (e.g., a trash icon or button) is visible for every item.

AC-3.15

Remove Button Functionality

Tapping the "Remove" control successfully calls Cart.removeItem to delete the item from the cart.

AC-3.16

Grand Total Display

The overall totalPrice of the entire cart is prominently and persistently displayed at the bottom of the CartScreen, updating instantly with every user action.



Requirements Document: Profile Screen Placeholder

1. Feature Description and Purpose

Feature Name: User Profile (Placeholder) Screen
Target Users: All customers using the sandwich ordering application.

Description:
This feature introduces a new, dedicated screen (ProfileScreen) within the application's navigation flow. The screen will act as a foundational element for future user management, allowing users to view and edit personal details (e.g., name, email). For the initial implementation, this screen is a static placeholder that displays input fields and a save button but performs no actual data persistence or API calls. A navigation link will be added to the existing OrderScreen to enable access.

Purpose:
To establish the basic structure and navigation flow for user account management, preparing the application for future integration with authentication and database services.

2. User Stories

The following user stories describe how users will interact with the new feature:

Story 1: Accessing the Profile Screen

As a customer on the main ordering screen,
I want to see a clear link to my profile,
So that I can navigate to the area where I will eventually manage my account details.

Story 2: Viewing Profile Fields

As a customer on the Profile Screen,
I want to see input fields for common personal information (like Name and Email),
So that I can understand where my details will be viewed and edited in the future.

Story 3: Interacting with the Save Button

As a customer on the Profile Screen,
I want to see a "Save Details" button,
So that I can attempt to save any changes, even if the functionality is not yet live.

3. Acceptance Criteria (AC)

The feature is considered complete when all the following criteria are met:

A. Navigation and Routing

ID

Criterion

Details

AC-3.1

Navigation Link Added

The OrderScreen must contain a clearly visible ElevatedButton or TextButton labeled "View/Edit Profile".

AC-3.2

Navigation Functionality

Tapping the "View/Edit Profile" button successfully pushes the ProfileScreen onto the navigation stack using Navigator.of(context).push.

AC-3.3

Back Navigation

The ProfileScreen must have a standard Flutter AppBar allowing the user to easily return to the OrderScreen (usually via an automatic back arrow).

B. Profile Screen UI (ProfileScreen)

ID

Criterion

Details

AC-3.4

Screen Title

The ProfileScreen must display an AppBar with the title "User Profile".

AC-3.5

Input Field Presence

The screen body must contain at least three distinct input fields (TextFormField or TextField) styled for user input (e.g., Full Name, Email Address, Phone Number).

AC-3.6

Save Button Presence

A prominent ElevatedButton labeled "Save Details" must be present at the bottom of the input fields.

AC-3.7

Non-functional Save

Tapping the "Save Details" button must not cause errors and must only print a simple message to the console (e.g., "Save functionality is a placeholder.")

AC-3.8

Layout and Centering

The content (input fields and button) should be vertically centered and well-spaced using standard Flutter padding and SizedBox widgets for good aesthetics.


Requirements Document: Sandwich App Features

1. Feature Description and Purpose

(Previous content remains unchanged)

2. User Stories

(Previous content remains unchanged)

3. Acceptance Criteria (AC)

A. Data Model & Logic (Backend)

(AC-3.1 to AC-3.8 remain unchanged)

B. User Interface (Frontend - CartScreen)

(AC-3.9 to AC-3.16 remain unchanged)

C. User Interface (Frontend - ProfileScreen)

(AC-3.1 to AC-3.8 from the previous Profile Screen section are now re-numbered to AC-3.17 to AC-3.24)

ID

Criterion

Details

AC-3.17

Navigation Link Added

The OrderScreen must contain a clearly visible link ("View/Edit Profile") for navigation.

AC-3.18

Navigation Functionality

Tapping the "View/Edit Profile" link successfully pushes the ProfileScreen.

AC-3.19

Back Navigation

The ProfileScreen must have a standard Flutter AppBar allowing the user to return to the previous screen.

AC-3.20

Screen Title

The ProfileScreen must display an AppBar with the title "User Profile".

AC-3.21

Input Field Presence

The screen body must contain at least three distinct input fields (e.g., Full Name, Email Address, Phone Number).

AC-3.22

Save Button Presence

A prominent ElevatedButton labeled "Save Details" must be present.

AC-3.23

Non-functional Save

Tapping the "Save Details" button must print a console message and perform no data operation.

AC-3.24

Layout and Centering

The content should be well-spaced and aesthetically pleasing.

D. Navigation Drawer & Responsiveness

ID

Criterion

Details

AC-3.25

Reusable Drawer Widget

A single, separate AppDrawer widget must be created to contain all navigation links, eliminating code duplication across screens.

AC-3.26

Drawer Links (Functionality)

The AppDrawer must contain navigation links (using ListTiles) for the OrderScreen, CartScreen, and ProfileScreen. Tapping a link must navigate to the target screen and close the drawer.

AC-3.27

Universal Drawer Access

The AppDrawer widget must be accessible (via the drawer property of Scaffold) from the OrderScreen, CartScreen, and ProfileScreen.

AC-3.28

AppBar Icon Integration

The AppBar on each top-level screen must automatically display the hamburger icon to open the drawer on small screens.

AC-3.29

Responsive Navigation (Code structure)

A wrapper widget (e.g., AdaptiveScaffold or similar) must be implemented that uses MediaQuery or LayoutBuilder to determine screen size.

AC-3.30

Responsive Navigation (Small Screens)

For screens smaller than 600 logical pixels, the standard Drawer functionality (AC-3.27) must be used.

AC-3.31

Responsive Navigation (Large Screens)

For screens 600 logical pixels or wider, the Drawer must be disabled, and the navigation links must be displayed permanently as a NavigationRail or fixed column on the left side of the screen body.

4. Widget Testing Updates

ID

Criterion

Details

AC-4.1

Drawer Opening Test

A test must confirm that tapping the menu icon on a top-level screen successfully opens the AppDrawer.

AC-4.2

Drawer Navigation Test

A test must confirm that tapping a navigation link (ListTile) inside the drawer successfully navigates to the target screen (e.g., CartScreen or ProfileScreen) and the drawer closes.

AC-4.3

Responsive Layout Test

Tests must be added (using tester.binding.window.physicalSize and tester.binding.window.devicePixelRatio) to verify: 1) On small screens, the drawer icon is present. 2) On large screens, the NavigationRail (or equivalent fixed navigation) is visible and the drawer icon is absent.

## New Requirement: Navigation Drawer & Responsive Navigation

- Add a Drawer widget to the app for main navigation (About, Profile, Order, Cart, etc.).
- The Drawer should be accessible from all main screens via the AppBar.
- Refactor navigation code to avoid redundancy (e.g., use a shared widget or mixin for the Drawer).
- Make navigation responsive: on wide screens, show a navigation rail or sidebar instead of a Drawer.
- Update widget tests to cover navigation via the Drawer and responsive navigation.