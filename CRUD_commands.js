mongoimport restaurants.json
mongo
show dbs
use test
show collections

/*----------------------
    CREATE
----------------------*/
db.restaurants.insertOne({
    "cuisine": "European",
    "name": "Florence"
})

db.restaurants.insertMany([
    {
        "cuisine": "American",
        "name": "Pierre"
    },
    {
        "cuisine": "European",
        "name": "Marguerite"
    }])


/*----------------------
    UPDATE
----------------------*/

db.movieDetails.updateOne({
    name: "Pieces"
}, {
        $set: {
            "grades": {
                "date" : ISODate("2014- 08 - 21T00: 00:00Z"),
                "grade": "B",
                "score": 25,
            }
        }
    });
db.restaurants.updateMany({
    cuisine: null
}, {
        $unset: {
            cuisine: "UNRATED"
        }
    })

/*----------------------
    READ
----------------------*/

//1) Print all restaurants
db.restaurants.find().pretty()

//1b) Print the first restaurant
db.restaurants.find().limit(1).pretty()

//2) Print only _id, name, borough and cuisine of restaurant
db.restaurants.find({}, { '_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1 }).pretty() \

//3) Print restaurant_id but not _id
db.restaurants.find({}, { 'restaurant_id': 1, 'name': 1, 'borough': 1, 'cuisine': 1, '_id': 0 }).limit(1).pretty()

//4) Display the first 5 restaurants in the borough 'Bronx'
db.restaurants.find({ 'borough': 'Bronx' }).limit(5)

//5) Display the first 5 restaurants in the borough 'Bronx' after skipping 5
db.restaurants.find({ 'borough': 'Bronx' }).skip(5).limit(5)

//6) Find the restaurants who achieved a score more than 90
db.restaurants.find({ 'grades': { $elemMatch: { 'score': { $gte: 90 } } } }).pretty()

//7) Find the restaurants that achieved a score, more than 80 but less than 100
db.restaurants.find({ 'grades': { $elemMatch: { 'score': { $gte: 80, $lt: 100 } } } }).pretty()

//8) Find the restaurants that do not prepare any cuisine of 'American' and their grade score more than 70 and latitude less than - 65.754168
db.restaurants.find({ $and: [{ "cuisine": { $ne: "American" } }, { "grades.score": { $gt: 70 } }, { "address.coord": { $lt: -65.754168 } }] }).pretty()

//9) Find the restaurants which do not prepare any cuisine of 'American ' and achieved a grade point 'A' not belongs to the borough Brooklyn.Sort according to the cuisine in descending order.
    db.restaurants.find({ $and: [{ 'cuisine': { $ne: "American" } }, { "grades.grade": "A" }, { "borough": { $ne: "Brooklyn" } }] }).sort({ "cuisine": -1 }).pretty()

//10) Find the restaurant Id, name, borough and cuisine for those restaurants which contain 'ces' as last three letters for its name
db.restaurants.find({ "name": { $regex: /ces$/ } }, { "restaurant_id": 1, "name": 1, "cuisine": 1 }).limit(1)


/*----------------------
    DELETE
----------------------*/


