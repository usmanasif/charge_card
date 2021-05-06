# Charge Card Dashboard

A backend for a theoretical Karat cardholder dashboard that displays basic information about a user's card and their spend. It collects transaction and authorization data from Stripe using webhooks and provides backend APIs to get this data for use. It returns data in a paginated way using offset and limit parameters on the endpoint to handle millions records in api response.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Installing


* Ruby version
 2.6.6

  ```
  rvm install 2.6.6
  ```
* Database
postgresql

	```
	brew install postgres
	```


* Clone the repository


	```
	mkdir charge_card

	cd charge_card

	git clone https://github.com/usmanasif/charge_card.git

	cd charge_card

	bundle install
	```

* Database creation

	```
	  rails db:create
	  rails db:migrate
	```
* Run app locally on 3000 port

	```
	rails server
	```

it will run the app on this url. Visit it and you can play with it
http://localhost:3000/

### How to link it with stripe to get data

* install ngrok

	```
	brew install ngrok
	```

*  run this command, it will create a internet available endpoint to connect with your local server
  ```
  ngrok http 3000
  ```

It will create such endpoints

  ```
  https://92ee1f5152fe.ngrok.io -> http://localhost:3000
  ```



You need to add this to Stripe webhook https://92ee1f5152fe.ngrok.io/stripe/webhook
Follow this.

https://stripe.com/docs/webhooks/test#dashboard

* create .env file

  ```
  touch .env
  ```
Add these variable required for webhook and cors issue
  ```
  STRIPE_SECRET_KEY=sk_test_51Gx..
  STRIPE_SIGNING_SECRET=whsec_..
  ALLOWED_ORIGIN="*.ngrok.io"
  ```


### Gems
- Used stripe and stripe_events gems to handle stripe webhooks
- Used jbuilder gem to return proper json api response


### APIs

* Cards:
  - List all cards
    ```
    api/v1/cards
    ```
  - Show specific card
    ```
    api/v1/cards/:card_id
    ```

- response:
  ```
  [
    {
        "id": "12d94a0f-43fb-4926-b57d-ef07ff4b9e10",
        "name": "Jame Doson",
        "last4": "3892",
        "expiry_month": "4",
        "expiry_year": "2024",
        "status": "active",
        "currency": "usd",
        "card_type": "virtual",
        "balance_owed": "1.0"
    }
  ]
  ```

* Authorization:
	It will return all approved and decline authorization lists

	It accepts card_id, offset, limit params. Offset and limit params for pagination

- List all Authorization
  ```
  http://localhost:3000/api/v1/transaction_lists
  http://localhost:3000/api/v1/transaction_lists?card_id=12d94a0f-43fb-4926-b57d-ef07ff4b9e10
  http://localhost:3000/api/v1/transaction_lists?card_id=12d94a0f-43fb-4926-b57d-ef07ff4b9e10&offset=0&limit=10
  ```
- Show specific Authorization
  ```
  api/v1/transaction_lists/api/v1/:transaction_list_id
  ```

- response
  ```
  [
      {
          "id": "4d6767a3-6e16-453a-9ced-2c3e47b2024e",
          "merchant_name": "Rocket Rides",
          "amount": "1000.0",
          "card_id": "12d94a0f-43fb-4926-b57d-ef07ff4b9e10",
          "created_at": "2021-05-06T09:56:33.197Z",
          "merchant_category": "Ac Refrigeration Repair",
          "status": "decline"
      },
      {
          "id": "f2219815-27cb-46e3-a4f0-d1ef9339ca35",
          "merchant_name": "Rocket Rides",
          "amount": "1.0",
          "card_id": "12d94a0f-43fb-4926-b57d-ef07ff4b9e10",
          "created_at": "2021-05-06T12:13:54.094Z",
          "merchant_category": "Ac Refrigeration Repair",
          "status": "approved"
      }
  ]
  ```


* Transactions:
It will return approved authorization, it accept same params as accepted by Authorization endpoint. I have not added extra table to save Transactions by keeping in mind that approved authorization are transactions so we don't need an extra table for it.

  ```
  http://localhost:3000/api/v1/transactions
  http://localhost:3000/api/v1/transactions?card_id=12d94a0f-43fb-4926-b57d-ef07ff4b9e10
  http://localhost:3000/api/v1/transactions?card_id=12d94a0f-43fb-4926-b57d-ef07ff4b9e10&offset=0&limit=10
  ```
- response
  ```
  [
      {
          "id": "f2219815-27cb-46e3-a4f0-d1ef9339ca35",
          "merchant_name": "Rocket Rides",
          "amount": "1.0",
          "card_id": "12d94a0f-43fb-4926-b57d-ef07ff4b9e10",
          "created_at": "2021-05-06T12:13:54.094Z",
          "merchant_category": "Ac Refrigeration Repair",
          "status": "approved"
      }
  ]
  ```

### Design Questions

- How else might you have improved your solution given more time?
  - A rake task can be implemented to populate the existing cards and authorization in our database. In current implementation, only newly created cards and authorization are being handled through webhook and being saved in our app database.
  - We can add some filters on cards and authorization endpoints and implement elasticsearch at backend for fast searching

- Feedback
    - Approximately how many hours did you spend on this challenge?
     10 to 12 hours
    - What did you find most interesting / rewarding about this challenge?
      - Integration with stripe to get real time data using webhooks
    - What did you find least interesting / rewarding about this challenge?
      - I did not see any searching and filtering option on endpoints
