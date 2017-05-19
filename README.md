# Decarbonate.me--front-end
iOS Front End for the Decarbonate Application

# Carbon Offsetting

Every time you travel using a car, bus, or plane you create harmful emissions in the form of CO2 (There are other modes of transportation that also create a carbon footprint but those are out of the scope of the current version of this API). In an ideal world we would not need to rely on fossil fuels, but in many cases this is unavoidable for the average person trying to get from point A to point B. That is where carbon offsetting comes in.

A carbon offset is a reduction in emissions of carbon dioxide or greenhouse gases made in order to compensate for, or to offset, an emission made elsewhere. A carbon offset can be planting trees that convert CO2 into oxygen, installing solar panels to provide sustainable and clean energy, reducing methane gases from animal waste on farms, and many more. However, these all require funding that can be hard to get on the scale needed to make a substantial difference. By purchasing a carbon offset, you help fund a third party aimed at creating a sustainable world and help reduce your carbon footprint.

There are hundreds of projects working toward a more sustainable world, each requiring different amounts of funding to offset a ton of CO2. The initial version will use a static value of $4.99 per ton.

# Current Version (1.0.0)

User can log in with an Eventbrite account (Eventbrite account is required to get signed in. This uses OAuth2 to sign-in).
The users events are fetched from Eventbrite and populated into the user and event schema.
The user selects a single event.
The user provides a starting point and mode of transportation (Automobile, Bus, or Flight) for the selected event.
Using the starting point provided by the user and the destination provided by Eventbrite the distance is calculated.
The distance and mode of transportation are used to request the Brighter Planet API's footprint calculator.
Price of a carbon offset for that trip is calculated using a flat rate of $4.99 per ton.
For example: the user travels 5 miles via automobile and emits 3 tons of CO2 which costs $14.97 to offset.

# Future Functionality

App sends updates for upcoming events that have not been offset.
Ability for an event organizer to see how many people have offset their trip.
More modes of transportation.
More specific types of transportation (ex: Car || diesel, hybrid, electric, etc).
Optional ability for a user to select an offset project to pay for.
B2B app for Event Organizers with organizers' dashboard.
Allow event organizers to pay for offsets.

# Authors
  -[Adrian Kenepah](https://github.com/ackenepah)
  -[Austin Rogers](https://github.com/nomadik223)

# License

This project is licensed under the MIT License

# Acknowledgments

The JS and iOS TA's for their assistance.
Caffeine
CodeFellows
Friends and Family
