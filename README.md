### PushCart API Documentation


All URLs referenced have the following base:

	http://gopushcart.com/api/v1

** To Show All Users ** *along with* user household size, user’s total number of purchases and user’s alias

> **API endpoint:** `/users`

> **Sample data:**
		
>		[
		
>			{
>				id: 2,
> 				household_size: 2,
> 				purchase_count: 0,
> 				alias: "outrageous-reserve-thriving-briars"
> 			},
> 		
> 			{
> 				id: 3,
> 				household_size: 2,
> 				purchase_count: 4,
> 				alias: "limitless-forest-snowy-desert”
> 			}
> 		
> 		]


 
**To Show A User’s Purchases ** *along with* the purchase vendor, purchase total price and purchase date

> **API endpoint:** `/users/:id/purchases`

> **Required Param:** `id `  example: `/users/3/purchases `

> **Sample data:**

>		[
>		
>			{
>				id: 92,
>				vendor: "Instacart",
>				total_price: 71.47,
> 				purchase_date: "2014-04-06T22:54:39.670-04:00"
> 			},
> 		
> 			{
> 				id: 91,
> 				vendor: "Fresh Direct",
> 				total_price: 0,
> 				purchase_date: "2014-04-05T22:54:21.119-04:00"
> 			},
> 		
> 			{
> 				id: 90,
> 				vendor: "Fresh Direct",
> 				total_price: 0,
> 				purchase_date: "2014-03-28T12:17:00.012-04:00”
> 			}
> 		
> 		]
 

**To Show A User's Purchase Items ** *along with* item details such as the quantity bought and item nutritional information

> **API endpoint:** `/users/:id/purchases/:purchase_id/items`

> **Required Param:** `id` and `purchase_id` example: `/users/3/purchases/92/items`

> **Sample data:**

>		[
>		
> 			{
> 				id: 565,
> 				purchase_id: 92,
> 				name: "Finn Crisp Original Thin Rye Crispbread",
> 				description: "7 oz",
> 				price_breakdown: "1 × $3.79",
> 				category: "Snacks",
> 				total_price: 3.79,
> 				quantity: 1,
> 				discounted: false,
> 				purchase_date: "2014-04-06T22:54:41.556-04:00",
> 			  _ nutritional_data: {
> 					calcium_dv: 0,
> 					calories: 40,
> 					calories_from_fat: 0,
> 					cholesterol: 0,
> 					dietary_fiber: 2,
> 					ingredient_statement: "Whole Grain Rye Flour, Yeast, Salt.",
> 					iron_dv: 2,
> 					monounsaturated_fat: null,
> 					polyunsaturated_fat: null,
> 					protein: 1,
> 					refuse_pct: null,
> 					saturated_fat: 0,
> 					serving_size_qty: 2,
> 					serving_size_unit: "slices",
> 					serving_weight: null,
> 					serving_weight_grams: 13,
> 					serving_weight_uom: null,
> 					servings_per_container: 15,
> 					sodium: 85,
> 					sugars: 0,
> 					total_carbohydrate: 10,
> 					total_fat: 0,
> 					trans_fatty_acid: 0,
> 					vitamin_a_dv: 0,
> 					vitamin_c_dv: 0,
> 					water_grams: null
> 				}
> 			},
> 		]

#### Access Token to the Pushcart Dashboard


A user access token is needed to view the [PushCart Dashboard](http://ohmage.org/pushcart-dashboard/).  The user access token is obtained via the login dialog.

The login process will issue a POST request to `http://gopushcart.com/api/v1/oauth/token`.  The request contains the following parameters:

            grant_type: “client_credentials"
            client_id: clientId
            client_secret: clientSecret

With the correct credentials entered, PushCart will send an access token to the client server. 