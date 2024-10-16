# Introduction

This VideoPlayer is designed for playing videos from public video URLs. Users can input a video URL to play the video, and the app will store previously played videos, displaying them in a list for easy rewatching.

# Technical
The app uses the native SwiftUI-wrapped AVKit’s VideoPlayer for video playback. It leverages SwiftUI and Combine extensively, implementing data flow and state-driven UI changes to ensure that data updates are immediately reflected in the UI. The overall architecture follows the MVVM (Model-View-ViewModel) design pattern, separating playback logic from the UI to adhere to the Single Responsibility Principle (SRP), improving code readability and maintainability. The app also utilizes Core Data as a persistent store to provide long-term storage and querying capabilities.
