# Topis
Topis is an iOS application that let user publish their topic. It allows user to upvote, downvote and comment on every topic in their network.

## Features

- [x] Show top 20 topics (sorted by upvotes, descending) on the homepage
- [x] Post topic with title and content
- [x] Upvote, downvote every topic in network. The user may upvote or downvote the same topic multiple times
- [x] Comment about the topic
- [x] Search topic by their name
- [x] Filter list topics by upvotes, downvotes or posted date

For demo purpose, this app get default data from JSON file and display on the screen as initial data with some predefined users. Will be updated soon!

## Used Design Patterns

#### Strategy pattern

The filter has 3 options: by upvotes, downvotes or posted date. Each filter option has its own characteristics. 
With the data is stored in a TopicList object, when user choose any 1 of 3 options, the TopicList object will alter its behavior. The filter behavior will switch when user choose different option.

#### Singleton design pattern

Throughout the app, there's only one instance of DataManager, which manages all the task with data such as storing, parsing,... Therefore, we can use singleton design pattern for this class.

#### Delegate design pattern

Delegate pattern is a simple and powerful tool to let an object to act on behalf of another object.  

#### MVC design pattern

The traditional Apple MVC architecture with View, Model and Massive View Controller that are so involved in View's life cycle. For the purpose of small demo, I used it for effectively maintain and readable code.

## Libraries

#### ObjectMapper for parsing data

ObjectMapper enables us to efficiently parse JSON to our defined model in a safe, persisted and fast way.

ObjectMapper can be reach out at here: https://github.com/Hearst-DD/ObjectMapper


### PopupDialog for showing custom dialog

For a better dialog appearance, I used PopupDialog. The source code is at here: https://github.com/Orderella/PopupDialog

## Data Structure

Because of time limit, I simply store data in an object called TopicList, which keeps the list of topic. Every topic stores the information such as title, content of topic, posted date, its owner which is a User object, and a list of comments.
Current version only let the user to comment on the topic. In the future, when the app let the user to reply other comments, the data structure below might be use:

```swift
comment1
    comment2
        comment3
        comment4
    comment5
    comment6
        comment7
```

Comments will be stored in a linked list. Each comment will have a link to its sibling and also a link to its first child. Whenever we need to access comments, we will iterate through this linked list from the root (first comment). 

Check out my demo video: https://youtu.be/FDiuDPGBZC4
