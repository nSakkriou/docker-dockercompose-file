db = db.getSiblingDB('klikego_database');

db.createCollection('account');

db.account.insertMany([
 {
    name: 'John1',
    lastname: 'Doe1',
  },
  {
    name: 'John2',
    lastname: 'Doe2',
  },
  {
    name: 'John2',
    lastname: 'Doe3',
  }  
]);