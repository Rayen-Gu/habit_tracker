# User Stories

Below are the nine user stories for the Learner App.

## 1. User registration
As a new user, I want to register with a username, email, and password so that I can create a personal account.

**Acceptance criteria**
- Fields: username, email, password.
- Shows validation errors for invalid email or short password.
- Persists user and navigates to Home on success.

## 2. User login
As a registered user, I want to log in using my email and password so that I can access my account.

**Acceptance criteria**
- Fields: email, password.
- Shows authentication error on invalid credentials.
- Navigates to Home on success.

## 3. Home feed
As a user, I want to see a home screen with a list of items (fetched from API) so I can browse available content.

**Acceptance criteria**
- Displays list with title and thumbnail.
- Pull-to-refresh support.
- Tapping item navigates to Detail screen.

## 4. Detail view
As a user, I want to view item details (title, description, image) so I can read more about an item.

**Acceptance criteria**
- Shows image, title, description.
- Shows an icon to add/remove to Favorites.

## 5. Favorites/Profile with persistence
As a user, I want to add items to my Favorites and see them in a Profile/Favorites page with data persisted locally.

**Acceptance criteria**
- Favorites list persists across app restarts.
- Can remove item from favorites.

## 6. External API integration
As a user, I want the app to fetch item data from an external API so content remains updated dynamically.

**Acceptance criteria**
- Shows fetched items on Home.
- Handles offline/failure with message.

## 7. Settings menu and screen
As a user, I want a Settings menu and screen so I can change preferences (dark mode, notifications).

**Acceptance criteria**
- Settings menu accessible from header.
- Settings screen with toggle options and save.

## 8. Notifications
As a user, I want to receive in-app notifications and test alerts so I'm informed about important updates.

**Acceptance criteria**
- Can configure notifications.
- App can trigger a test notification.

## 9. Error handling and UX
As a user, I want clear error messages (signup/login/API) so I understand what went wrong and how to fix it.

**Acceptance criteria**
- Error screens/popups for network/auth/validation failures.
