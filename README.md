# SocialMediApp 

## SocialMediaApp allows user to do the following:
- Signup using Email
- Login
- Logout
- Share posts
- View other users posts
- Reset Password

Developed using xCode 13.0 and Swift 5

## 3rd party dependencies, Libraries used
- [Firebase](https://github.com/firebase/quickstart-ios)
Email Authentication
Realtime Database
Storage
- ![Catchy](https://github.com/Sadmansamee/CachyKit)
- ![GrowingTextView](https://github.com/KennethTsang/GrowingTextView)

## A a tour inside the app:
https://drive.google.com/file/d/1F5n4YrHiUdykFLtMAKuQu0hoHgitvTZI/view?usp=sharing


## Challenges and difficulties:
- Integrate all Firebase services (Authentication, Real-time, Storage) of the same user!.. How I managed that: trying to give all these 1 id which is userId `Auth.auth().uid`
- Collect everything I have learned in 1 project! every small task is easy, but how you bring and combine everything together is the real challenge.
- Integrate Swift packages with cocoapods.. I got conflicts when I tried to download libraries using cocoapods and swift packages simultaneously. How I managed that? I tried: Creating a new project and copying all files to it.. I forget to change the bundle identifier of the new project.  I also needed to redownload the google info file again. I end up creating a new firebase. Finally, it was solved after simply stopping trying and creating a new project with a new firebase. **Time is gold**
 - Consistency between multiple roles.. "it is not always working to be a UX/UI/ios developer at the same time, especially if you're still learning and trying multiple things for the first time and your time is limited!"

## Future directions:
if I had more time I would like to:
- Take more time in designing the GUI and the UX of the app
- Give an app an identity
- Doing more useability testing and writing down the outcomes
- Allow user to update other components of his/her own profile such as display name, profile Image
- Allow user to post Images or videos along with the text
- Sort posts last is at the top
- Allow user to manage his/her own posts, view, modify, or delete
- Allow users to react to other users posts such as like, share, or repost
