- **Prompt 1**: I am building a Flutter app for a sandwich shop. The app has two main pages
Order Screen: Users select sandwiches and add them to their cart.
Cart Screen: Users view the items in their cart and see the total price.
I want to implement features that allow users to modify the items in their cart. Here are the features I need, with clear descriptions and expected behaviors:

1. Change Quantity of an Item
Description:
Allow users to increase or decrease the quantity of a specific sandwich in their cart.

Expected Behavior:

The cart screen should display the current quantity for each item.
Users can tap "+" to increase or "–" to decrease the quantity.
If the quantity is decreased to 0, the item should be removed from the cart.
The total price should update automatically as the quantity changes.
2. Remove an Item from the Cart
Description:
Allow users to remove a sandwich from their cart entirely.

Expected Behavior:

Each item in the cart should have a "Remove" button (e.g., a trash icon).
When the user taps "Remove," the item is deleted from the cart.
The total price updates to reflect the removal.
3. Edit Item Details (Optional)
Description:
Allow users to edit details of a sandwich in their cart (e.g., change bread type, toppings, or size).

Expected Behavior:

Each cart item should have an "Edit" button.
Tapping "Edit" opens a dialog or navigates to a screen where the user can modify the sandwich options.
After saving changes, the cart updates to reflect the new item details and price.
General Requirements
All changes should be reflected immediately in the UI.
The cart's total price should always be accurate.
The user should receive feedback (e.g., a snackbar) when an item is removed or updated.

- **Prompt 2**: Add one new screen to your app. This can be a profile or sign-up/sign-in screen where users can enter and/or view their details. For now, you can add a link to this screen at the bottom of your order screen (we will fix this in the next exercise). There’s no need to perform any actual authentication or data persistence yet.

- **Prompt 3**: Let’s enhance our app’s navigation by adding a Drawer menu. A Drawer is a panel that slides in from the edge of a Scaffold to show the app’s main navigation options. You can read more about it in its documentation page.

Ask your AI assistant to explain how Drawer widgets work and how they integrate with the AppBar. Could you make this drawer accessible from all screens in your app? Is there any way to reduce the redundant code that this creates? As an extra challenge, make the navigation of your website responsive (different screen widths should make the navigation look and act differently). (Re)visit exercise 6 from Worksheet 2 for a hint.

Make sure to add this new task to the requirements.md instead of creating a new one. The existing information and completed tasks should technically speed up the implementation of the new feature and make it more consistant.

As always, update your widget tests to cover the new navigation drawer (or generally, navigation) functionality.