# Image Generator - iOS - MVP based

* ### Description
A simple iOS application for generating images as part of a user request.

* ### Run Requirements
Xcode 14.1 (14B47b)
Swift 5

___________________________________________________________________________________________________
>###  ****MVP (Model — View — Presenter)****

**Model (Entity):** Layer for storing data. It is responsible for handling the domain logic(real-world business rules) and communication with the database and network layers.

**View:** UI(User Interface) layer. It provides the visualization of the data and keep a track of the user’s action in order to notify the Presenter.

**Presenter:** Fetch the data from the model and applies the UI logic to decide what to display. It manages the state of the View and takes actions according to the user’s input notification from the View.
