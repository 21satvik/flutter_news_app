# Flutter News App

A feature-rich Flutter news application that delivers real-time top headlines from around the world. The app integrates Firebase Authentication and Firestore for user management and NewsData.io API to fetch news articles, offering a seamless experience on both Android and iOS devices.

## Features

- **News API Integration**: Fetches the latest news articles from NewsData.io based on country and category.
- **Firebase Authentication**: Implements secure email/password authentication and user data management.
- **Provider for State Management**: Ensures clean, maintainable, and scalable state management.
- **Firestore Integration**: Stores user details such as name and email, with seamless data retrieval.
- **Responsive Design**: Adapts to different screen sizes using MediaQuery for a user-friendly experience on all devices.

## Screens

- **Login & Signup**: Users can register or sign in using email and password authentication.
- **Home Screen**: Displays top headlines with the ability to view full article details.
- **Article Screen**: Allows users to read individual news articles and provides a link to view the full article in the browser.

## Technology Stack

- **Flutter**: Cross-platform development framework.
- **Firebase**: Authentication, Firestore for user data storage & Remote Config.
- **Provider**: State management for handling app-wide state.
- **NewsData.io API**: Fetches real-time news based on country and category.
  
## Prerequisites

- **Flutter SDK**: v2.0 or later.
- **Firebase Console**: Set up Firebase project for both Android and iOS with email/password authentication enabled.
- **NewsData.io API**: Obtain an API key from [NewsData.io](https://newsdata.io/) to fetch news articles.

## Setup

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/21satvik/flutter-news-app.git
    ```
   
2. **Install Dependencies**:
    Navigate to the project folder and run the following:
    ```sh
    flutter pub get
    ```

3. **Configure Firebase**:
    Follow the instructions on [Firebase's documentation](https://firebase.google.com/docs/flutter/setup) to set up Firebase for both Android and iOS.

4. **API Key Setup**:
    Add your NewsData.io API key in your `.env` file or directly in your service layer where the API call is made.

5. **Run the App**:
    ```sh
    flutter run
    ```

## Usage

- **Authentication**: Users can sign up or log in to access personalized features.
- **News Feed**: Fetches the latest news based on country, with real-time updates.
- **View Article**: Click on any article to view its details and access the full news in a browser.

## Code Structure

- **lib/providers/**: Contains Provider classes for state management.
- **lib/views/**: UI code for different app screens (login, home, article).
- **lib/models/**: Data models, such as `User` and `NewsArticle`.
- **lib/services/**: Handles API requests and Firebase operations.
- Other widgets and constants