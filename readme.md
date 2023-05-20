Fluxi is written to simplify distributed statemanagement.

A difficult problem that arises often in Software Engineering is the state management of stateful objects that have potentially many observers, some off which may not be online.

Our preqrequisites are:
* We want to synchronize the state of an object across devices.
* A state can have many different observers. When a state is mutated, it should be made visible to all observers.
* These observers may not be connected to the backend.
* If they are, however, we want to synchronize the state in realtime.

Distributed state synchronization is more difficult than it sounds like:
* The backend needs to be highly reliable, or else, state may dissynchronize. Due to the CAP-theorem it must thus be a distributed system. 
* The backend might keep track of an online state of a user, which is especially difficult in distributed systems.

Phoenix and Elixir solve many of these problems out of the box and are a particularly good choice for distributed state management and come with out-of-the-box OTP capabilities and Channels based on the actor model.

On top of that however, this creates organizational difficulties, as tight communication between backend and frontend developers is needed, while you often end up writing the same boilerplate code anyways, where 70% is the same... models, migrations, repositories, phoenix channels etc.

I first made a model generator, but this is insufficient to be practically useful. It needs to be a programming language to account for the proper hierarchy of objects and to create proper useful statements for the database.

This is where this is going and I like to move quickly and break things, my head is on fire and I want a brick to put it off, because sadly noone offers me water.

Fluxi assumes you want to make a Flutter-App and possibly a VueJS-App with a Phoenix-Backend.

It further assumes 
* you want to work with provider, phoenix_socket, sqflite and timex 
* each of your models should have a globally unique UUID.

To avoid locale issues and because sqflite has no dative datetimes, all dates are stored
as milisecondsSinceEpoch in databases.

The code-generators of phoenix are very handy. Fluxi is supposed to extend the code-generation to Flutter, too.

Often times you will have to write similar boilerplate-code for Flutter and Elixir: 
repositories, models, ways of communicating and syncing state of an object and migrations.

Fluxi is aimed at auto-generating this boilerplate code.

write

fluxi make installer PROJECT_NAME

to generate a phoenix-installer and a flutter-installer for the setup of a new Fluxi-App.

Write 

fluxi make model Person age:integer name:string

to generate 

* Repositories for both flutter and phoenix
* DTOs
* A phoenix/channel and a client to sync state

You find the templates for all generated files in the folder templates.