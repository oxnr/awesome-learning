# Javascript

## Strings

### Basics

Basic ways to construct strings

```javascript
var name = "Onur";
console.log(name);

var name2 = 'Onur'
console.log(name2);

var statemement = "This is Onur's string";
console.log(statement);

var statement2 = 'He said "This is awesome"';
console.log(statement2);
```
### Escape characters

Special technique to tell JavaScript how to interpret special charactesr

```javascript
var statement3 = 'He said "This is Onur\'s string"';
console.log(statement3);

var path = "C:\\folder\\myfile.txt";
console.log(path);

var multiline = "This is line 1\nThis is line2\nThis is line3 with a\t tab";
console.log(multiline);
```

### Concatenation

Join two strings together

```javascript
var part1 = "Hello ";
var part2 = "World!";
var whole = part1 + part2;
console.log(whole + "!!!!");
```

### Methods

Transform or get information about string

```javascript
var length = whole.length;
console.log(whole, length);

var index = whole.indexOf("World");
console.log(index);

var index2 = whole.indexOf("world");
console.log(index2);

if (whole.indexOf("W") !== -1){
    console.log("W exists in string")
} else{
    console.log("W does not exists in string");
}

console.log(whole.charAt(2));

var start = 6;
var world = whole.substr(start, 5);

console.log(whole.toLowerCase());
console.log(whole.toUpperCase());
```

### Compare Strings

Ability to compare strings

```javascript
var first = "Hello";
var second = "hello";

if (first === second){
    console.log("The strings are equal");
} else {
    console.log("The strings are different");
}

function compare (a, b){
    console.log(a + " <= " + b, a <= b);
}

compare('a','b');
compare('a','A');
compare('apples','oranges');
compare('apples','applications');
compare('app','apples');
compare('hello','hello');
```
