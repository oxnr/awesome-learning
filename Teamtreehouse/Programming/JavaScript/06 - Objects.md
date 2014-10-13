# Javascript

## Objects

### Basic Objects

Create basic JavaScript Objects

```javascript
var onur = {
    name: "Onur",
    skills: ["JavaScript","Ruby","Dancing"],
    "favorite color": "red"
};

onur["favorite color"] = "yellow";

console.log(onur.name);
console.log(onur["favorite color"]);
```

### Methods

A function associated with an object is called method.
In other words a method is a function property of an object.

```javascript
var onur = {
    name: "Onur",
    skills: ["JavaScript","Ruby","Dancing"],
    "favorite color": "red",
    greet: function (name, mood) {
        name = name || "You";
        mood = mood || "good";

        console.log("Hello, " + name +
                    "I am " + this.name +
                    " and I am in a " + mood + " mood!");
    }
};

onur.greet("Ozan","awesome");

var onurGreet = onur.greet;
onurGreet.call({name:"Ozan"},"Gueven","bad");

onur.greet.apply(onur,["Ozan","awesome"]);

var args = ["Michael", "happy"];
onur.greet.apply(onur, args);
```

### Prototypes

Reuse common objects by reusing other objects

```javascript
var personPrototype = {
    name: 'Anonymous',
    greet: function (name, mood) {
        name = name || "You";
        mood = mood || "good";

        console.log("Hello, " + name +
                    "I am " + this.name +
                    " and I am in a " + mood + " mood!");
    },
    species: 'Homo Sapien'
}

// Create constructor function
function Person (name) {
    this.name = name;
}

// Assign prototype to constructor method
Person.prototype = personPrototype;

// Create new object based on prototype
onur = new Person('Onur');

// Add attribute to prototype object and links instances
Person.prototype.favouriteColor = "red";
```
