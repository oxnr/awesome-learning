# Javascript

## Functions

### Arguments

Passing data to functions

```javascript
function sayHello (name, greeting) {
    if (typeof name === 'undefined') {
        return 0;
    }else if (typeof greeting === 'undefined') {
        greeting = 'Hello';
    }
    console.log(greeting + " World! " + name);

    return name.length;
    console.log('End of function');
}

sayHello("Jim","Yo");
```

### Scope

Passing data to functions

```javascript

var color = 'black';
var number = 1;

function showColor(){
    var color = 'green';
    console.log('showColor color', color);
    console.log('showColor number', number);
}

showColor();

console.log('Global color', color);
console.log('Global number', number);
```
### Anonymous Functions

Declaring functions without a name to use once

```javascript
var myFunction = function () {
    console.log('myFunction was called');
};

myFunction();

var callTwice = function (targetFunction) {
    targetFunction();
    targetFunction();
};

callTwice(function() {
    console.log("Hello from anon function");
});

// Pattern to create private scope for functions and variables
(function() {
    var a, b, c;
    console.log('from anon function')
})(1, 'hello')
```

### Examples

Some examples using common techniques

```javascript
var button = document.getElementById('action');
var input = document.getElementById('text_field');

// Basic DOM manipulation
button.addEventListener('click', function () {
    console.log('clicked');
    input.setAttribute('value', 'Hello World');
});

```
