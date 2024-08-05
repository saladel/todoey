## Table of contents

- [Design](#Design)
- [Description](#Description)
- [Packages Used](#Packages-Used)
- [Demo](#Demo)
- [Android APK](#Android-APK)
- [iOS IPA](#iOS-IPA)

## Design

![todoey](https://github.com/user-attachments/assets/c6d795a0-ed60-49c0-9775-50db3fb3f2a1)

## Description

This Flutter app is a task management application that interacts with Firebase Firestore to post, retrieve, store and manage tasks.

### Features

#### Task Management:
The main screen shows a list of tasks retrieved from Firestore.
Each task is displayed with a checkbox, task description, and a delete button.
Users can mark tasks as completed by checking the checkbox. Completed tasks will be shown with a strikethrough decoration.
Users can delete tasks by tapping the delete button.

#### Add New Task:

A Floating Action Button (FAB) at the bottom-right corner allows users to add new tasks.
When the FAB is pressed, a modal bottom sheet appears with an interface to add a new task.

#### Firestore Integration:

The app uses a Firebase Firestore to interact, store and manage tasks.
It fetches the list of tasks in real-time using a StreamBuilder.
It also shows the total number of tasks dynamically.

## Packages Used
- firebase_core
- cloud_firestore

## Demo

Both Demos simulteaneously show how tasks are instanstly retrieved, created and deleted across two devices using one account.

### iOS Demo

https://github.com/user-attachments/assets/e81a1984-6c11-4de4-8404-901cf2ea5015

### Android Demo

https://github.com/user-attachments/assets/cbd64594-31e3-46f9-80b5-3fa79e6698fc

## Android APK
[Download APK (22M)](https://drive.google.com/file/d/1FRkz6A4LfP7FCrJaZeok2iCYaaCPJ4oj/view?usp=share_link)

#

Feel free to reach out to me on [Linkedin](https://bit.ly/AdewaleSanusi) or [Twitter](https://twitter.com/A_4_Ade) if you have any questions or
feedback!

[🔝](#Table-of-contents)
