## SquareAlfa Dart Framework
This repository contains SquareAlfa's Dart Framework. 

### Introduction

There is one single driving purpose behind this framework, or rather, by this cohesive, yet loosely coupled collection of packages. The purpose is to enable us to use Dart as a full-stack language with as less busy work as possible. Manually typed boilerplate code fits perfectly into our definition of busy work.

Since Flutter is already an amazing framework, our focus with this framework is to:

- Make it really easy to use Dart on the server.

- Make it even easier to share code between the server and the client. This means mainly two things:

    - Sharing the classes that constitute the  business model. We absolutely hate typing a model to represent a concept that needs to be stored in a database and typing it all over again in a different language so we can present the concept to the user.

    - Sharing validation logic. Validation should be done at the client for usability, and must be done at the server for security. Having to type the rules only once is, however, a time saver.

This framework is not trying to be very opinionated. It is based, however, on assumptions. If your needs do not fit the existing assumptions, you are free to create an issue and we will consider the improvement idea. Even better, after submitting an issue, you can submit a pull request. Moreover, you are not required to use the whole framework as a single monolithic entity. We tried to design the framework so its users could cherry-pick the packages they need.

The assumptions are the following:

- Communications between client and server are done mainly using gRPC. This means that at the time of this writing, we do not care about REST.

- Data is persisted to a NoSQL database. If you need to persist to a RDBMS, bring your own ORM. At this moment, we are using ArangoDB, but we are using the repository pattern, with a driver to the concrete database server.

### Nice Features

This framework does offer a few nice features:
- Multi-tenancy out of the box, with all tenants sharing the same database.
- Database access using the repository pattern is filtered by tenant and user permissions.
- Logging of CRUD operations.

