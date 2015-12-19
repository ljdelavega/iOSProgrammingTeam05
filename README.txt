=================================================
README for Zeal
CPSC 599.72 iOS Programming for Creative Minds (Fall 2015)
Team 05 - Lester Dela Vega, Brandon Yip, Michael Ng
=================================================

=================================================
Opening the Xcode project:
=================================================
- Since we used CocoaPods, the Xcode project file had to be modified in order to satisfy the required dependencies.
- Open the folder "CPSC 599 App Project" and open the project by using the Zeal.xcworkspace file (NOT the .xcodeproj or it will cause build errors).

=================================================
Running the App:
=================================================
- Once you have opened the project use the Zeal.xcworkspace file, you should be able to just run the application using the “Play” button and simulating. 
- NOTE: We have primarily tested the app with the iPhone 6s Plus scheme in iOS 9.1 (The default one in Xcode 7.1) but the constraints should let us simulate 
on other devices. If you are seeing anything that looks off, please try simulating using the iPhone 6s Plus configuration.

=================================================
Code:
=================================================
- Here is a link to our github page for this project: https://github.com/ljdelavega/iOSProgrammingTeam05
- If you want to look at the actual source code for our app, here is an overview of how we structured it so you know where to look.
- There are 6 Storyboards in our app. We have divided the workflows this way so it was easier for all of us to work on the interface using source control.
	- There are the Main and LaunchScreen storyboards which are in every app
	- And then there are the 4 storyboards for each main tab of our app.
- Below the storyboards for each workflow are the relevant data model and controller classes for that storyboard.
- The “Libs” folder was meant to contain any external libraries we used but we moved to CocoaPods. Right now it just contains some extension methods to 
NSDecimalNumber to make it easier to work with currency
- The Pods folder contains the different CocoaPods (pretty much external libraries hooked up to the project using Ruby)  we used in our project.

=================================================
Walkthrough of the App:
=================================================
- When you run the app you should be greeted by the startup screen with our logo in the middle and names on the bottom. 
- When the app finishes loading, the first tab you will be on is the “Overview” tab. 
- The tab bar controller at the bottom is the backbone of our app and separates our 4 core features for the prototype.
- We have added some sample data to the app already for your convenience so you do not need to add all the data yourself.

=====================
Overview:
=====================
- The overview screen is the first screen you see in the app, it provides a high level overview of your income and expenses, primary goal, and budgets.
- You can click on the Chart button on the top right of the navigation controller to see a pie chart visualization of your data. It loads data from the 
Transactions and Budgets table to show you a visual overview of where most of your spending is going.

=====================
Transactions:
=====================
- The Transactions Tab is a detailed list of all the transactions you’ve inputted. 
- It serves as the main data entry point for the values that will be used in the overview and budget tabs.
- You can interact with the transactions table view like any other table view that follows Apple’s standards. You can swipe left on a cell or click edit 
button on the top left to quickly delete transactions.
- You can click the “+” button on the top right to add a new transaction. 
	- The segment control at the top lets you distinguish between income (adding funds) and expenses (spending/decreasing funds).
	- You can enter in values into the fields as you wish. Note that the save button only activates when the Name and Amount have values because 
	they are required fields.
- You can also edit transactions by clicking on a cell in the table view which works the same way as adding a new transaction.

=====================
Budgets:
=====================
Note: We haven’t completely finished this feature so most of it is just sample data to get our point across.
- The Budgets tab is a way to keep track of your spending and set limits based on categories.
- The first screen is a list of all the budgets you have and shows your progress on each of them.
- You can tap on one of the budgets to see a list of the transactions that contribute towards that budget.
- The graph button takes you to a screen where it will show you bar/line chart that shows an overview of all your previous months (this is not 
currently done and is just fake data)
- The add button allows you to add new budgets (this is not currently, just the fields that would be available)

=====================
Goals:
=====================
- The goals tab is the main feature of our app and allows the user to set new saving goals for themselves and quickly make contributions and track
 progress with motivational messages. 
- The first screen you see in the goals tab is the Primary Goal screen which is a quick look at the current goal you are saving towards.
- You can make quick contributions to the goal using the “Contribute” button at the bottom. 
- Making a contribution will do some background analysis to calculate how many days it would take for you to reach your goal.
- The bar will start changing tints (becoming a more solid color) as you make progress towards your goal.
- If you click on the list button on the top right, you can see a list of your goals.
	- The table view for the lists works the same way as any other table view.
	- You can remove goals by swiping to the left just like with transactions.
	- As you can see, one of the goals will have a star on the right of the cell, this signifies the Primary Goal.
	- You can start editing an existing goal by clicking on one of the cells.
- You can add a new goal by clicking on the plus sign on the top right of the navigation controller.
- When editing or adding a goal, they use the same screen so the workflow is the same.
	- You can edit the values for fields
	- You can change the picture by clicking on the image and using the image picker.
	- You can set the goal to be primary or not by using our custom checkbox control.

And that’s the gist of what we’ve accomplished so far with our app!
Thanks for trying out our app!

=================================================
Closing:
=================================================
We’ve had an amazing experience with this course and learned a lot about not just iOS Programming, but also the business and social aspects about making
an app. We encountered a many challenges along the way and had our initial idea change quite a bit, but learned many valuable lessons in the process. 
If we were to make a new app, we would definitely use what we’ve learned here in the future.
- Lester, Brandon, and Michael.