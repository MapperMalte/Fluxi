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