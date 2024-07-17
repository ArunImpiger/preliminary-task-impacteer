# Preliminary Task Impacteer

A new Flutter project.

## Getting Started

To run this App: 
(Android)
Step 1 : Flutter version - 3.22.1
Step 2 : flutter pub get
step 3 : flutter run

(IOS)
step 4 : Project Root directory -> cd iso
step 5 : pod install 
step 6 : Open ios folder in xcode and build



Task Question: 
Flutter Developer preliminary screening task
You need to create an application to list users using the following api
• Create the application using clean architecture
• The application should run on both IOS and Android
• Use SF-PRO font family
• Use Bloc for State management

The application should have two screens,
First screen
• Should list all the users and support infinite scroll using pagination.
• You can design the UI as per your skills.
Second screen
• Should display the user content
• Try to show your designing & animation skills in this page

You should push your code to github and publicly share the url with us with build instructions.

Api Docs

Base url = https://reqres.in/

List users
End point : api/users?page={page_number}
Params supported: page

Get User
Endpoint : api/users/{user_id}
