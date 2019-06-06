class Person {
  constructor(name) {
    this.name = name;
  }
}
const LAST_NAME = "Cobb"
let bob = new Person('Bob');
alert(`${bob.name} ${LAST_NAME}`);