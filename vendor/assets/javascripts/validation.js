jQuery(document).ready(function() {
  jQuery("#new_subscribe").validate({
errorElement:'div',
rules: {
"subscription[email]":{
required: true
},

"subscription[price]":{
required: true
},

"subscription[card_number]":{
required: true
},	
"subscription[card_code]":{
required:true
},

"subscription[card_month]":{
required:true
},

"subscription[card_year]":{
required:true
}
},
messages: {
"subscription[email]":{
required: "Please enter the subscription_email",
remote:"email id already exists"
                     },
  "subscription[price]":{
required: "Please enter subscription_price"
},
"subscription[card_number]":{
required: "Please enter the card number"
},
"subscription[card_code]":{
required: "Please enter card_code"
},
"subscription[card_month]":{
required: "Please enter card_month"
},
"subscription[card_year]":{
required:"Please enter card_year"
}
}
});





});
