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