# Javascript

## Variables

### Basics

Create a variable and assign a value

```javascript
var color = "red";

var myDiv = document.getElementById('myDiv');
myDiv.style.background = "black";
```

### Naming

Rules for valid JavaScript variable names

```javascript
// Start with A-Z a-z _ $
// Continue with A-Z a-z 0-9 _ $

// Valid variables
var car = "Mercedes";
var color = "blue";
var _myVariable = "juhu";
var $specialName = 1;
var a456456 = "number";

// Invalid variables
var 3cars = "Mercedes BMW Audi";
var winning% = 30;
var person-name = "Jumanji";

// Reserved names
var continue = true;
// class, super, let, package, protected etc.
```

### Null and undefined

Types when a variable value is not defined
Null and undefined are falsy values

```javascript
// Undefined is value was never assigned
var myVar;

console.log(typeof myVar === "undefined");

var x = null;

if (myVar == null){
    console.log("if");
}else {
    console.log("else");
}

```

### Scope

Variables belong to a scope i.e. to a function

```javascript
var world = "World!";

function sayHello(){
    var hello = "Hello ";
    function inner (){
        var extra = "There is more";
        console.log(hello + world + extra);
    }

    inner();
}

// invoke say hello
sayHello();

console.log("world outside sayHello(): ", world);
// hello is defined inside of sayHello function
// console.log("world outside sayHello(): ", hello);
```

### Shadowing

Two variables in different scopes using the same name

```javascript
var myColor = "blue";
console.log("myColor before myFunc() ",myColor);

function myFunc(){
    var myColor = "yellow";
    // Now unable to access global variable from within myFunc
    myNumber = 42;
    // If assigning to a variable that doesn't exist, global variable will be created
    // So always use var!
    console.log("myColor inside myFunc() ",myColor);
}

myFunc();
console.log("myColor after myFunc() ",myColor);
console.log("myNumber after myFunc() ",myNumber);
```

### Hoisting

Declaring variables in the middle of a scope

```javascript
function doSomething(doit){
    var color = "blue",
        number,
        name ="Onur";
    if(doit){
        color = "red";
        // 'var' for color doesn't matter because it's in the same scope
        var number = 10;
        // hoisting comes in place for number, declaration is hoisted to the top of function
        // keep all variable definitions at top of the function
        console.log("Color in if(){}", color)
    }
    console.log("Color after if(){}", color)
}

doSomething(false);
doSomething(true);
```
