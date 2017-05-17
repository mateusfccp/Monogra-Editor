# Monogra-Editor
Front-end Single-page-application editor used in Monogra

## Installing

Clone to your PC. Then, install node dependencies:

```
$ npm install
```

Then, install Elm dependencies:

```
$ elm package install
```

## Compiling

If you want simply to build your Elm and css files, run the following command:

```
$ gulp build
```

## Running debug server

I made a debug server which serves a dummy document (`public/dummy.json`) and a `index.html` to test the editor. You can run the server with the following command:

```
$ gulp debug-server
```

Then, the editor will be available at `localhost:3000`, and the json server at `localhost:3000/api/db`.
