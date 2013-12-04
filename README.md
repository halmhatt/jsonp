Jsonp
=====

A javascript library to do jsonp requests and load scripts dynamically


## Usage
*Please be careful when using jsonp, because of how it works it is possible to Cross Site Scripting attacks if you
do not trust the source.*

```js
Jsonp.get({
  url: 'test.json',
  data: {
    hello: 'world'
  },
  success: function(data) {
    console.log(data);
  }
});
```

Load a javascript file

```js
Jsonp.load('myscript.js');
```

## How it works
The script inserts a `<script>` tag in the `head` element that loads an external API source. 

It looks like this
```js
<script src="source?jsonp=callback_4fsdf83mflsddf2&timestamp=12312434646"></script>
```

The response from the API will look something like this

```js
callback_4fsdf83mflsddf2({
  response: 'data',
  goes: 'here'
});
```

This code will call the function `callback_4fsdf83mflsddf2` that the library has registered as **your callback function**. Then the script tag will be removed
