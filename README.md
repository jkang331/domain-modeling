# domain-modeling
INFO 498B - Project 4

###### Make the Unit Tests Pass

 – clone the repo at [Link](https://bitbucket.org/TedNeward/uwsimpledomainmodel.git)
 – this consists of:
  - SimpleDomainModel: "standard" command-line project 
  - SimpleDomainModelTests: set of unit tests exercising the above
 – as written, the tests will not pass; it won't even compile! – your job: make the tests pass! WITHOUT changing them!

###### Create a value type: Money
 – Properties: amount & currency
 – Methods:
  - convert: convert from one currency to another 
  - add, subtract: do the math thing
 – If you use a String for currency, make sure that only the four listed are accepted
 – Note that it is totally acceptable to add/subtract GBP to EUR or CAN

###### Create a class: Job
 – Properties: title & salary
 – Salaries can be either per-hour or per-year
 – Methods:
  - calculateIncome, which should accept a number of hours worked this year; if this is a per-year salary, then ignore the hours
  - raise, which will bump up the salary by the passed percentage

###### Create a class: Person
– It have the following properties: firstName, lastName, age, job (Job), & spouse (Person)
– Methods:
  - display a string representation of Person (toString())
– Note: 
  - that if the Person is under age 16, they cannot have a job
  - that if the Person is under age 18, they cannot have a spouse

###### Create a class: Family
– Properties: members (a collection of Persons)
– Methods:
  - initializer: take two Persons, make sure they each have no spouse, set spouse to each other 
  - householdIncome: return the combined income of the entire family 
  - haveChild: add a new Person to the collection of age 0
- Note: there must be one Person in the family who is over age 21 to be legal

###### Submit your work to your Github account

– call the repository "domain-modeling"
– Grading: (10 points total!)
  - all the tests must pass to get points for that type: +2 points for Money, +2 points for Job, +3 points for Person, +3 points for Family
– Optional: rewrite Money to use enums for currency (2 points)
  - rewrite the Money class 
  - rewrite the MoneyTests tests